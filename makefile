CC := g++
debug: CXXFLAGS = -std=c++17 -Wall -Wextra -ggdb
release: CXXFLAGS = -std=c++17 -Wall -Wextra -O1
LDFLAGS := `pkg-config --libs --cflags opencv` -lpthread
TARGET := Test
INCLUDE_DIR := Include/
SOURCE_DIR := Source/
BUILD_DIR := Build/
BINARY_DIR := Bin/

SOURCE := $(shell find $(SOURCE_DIR) -name "*.cpp")
OBJECT := $(patsubst $(SOURCE_DIR)%.cpp, $(BUILD_DIR)%.o, $(SOURCE))

all: release

debug: pre_build $(OBJECT)
	$(CC) $(OBJECT) $(LDFLAGS) -o $(BINARY_DIR)$(TARGET)Debug

release: pre_build $(OBJECT)
	$(CC) $(OBJECT) $(LDFLAGS) -o $(BINARY_DIR)$(TARGET)

$(BUILD_DIR)%.o: $(SOURCE_DIR)%.cpp
	$(CC) -I $(INCLUDE_DIR) $(CXXFLAGS) -c $< -o $@

pre_build:
	mkdir -p $(BUILD_DIR) $(BINARY_DIR)
clean:
	rm -rf $(BUILD_DIR) $(BINARY_DIR)

