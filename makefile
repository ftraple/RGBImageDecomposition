CC = g++
debug: CXXFLAGS = -std=c++17 -Wall -Wextra -ggdb
release: CXXFLAGS = -std=c++17 -Wall -Wextra -O1
LDFLAGS = 
INCLUDE_DIR = Include/
BINARY_DIR = Bin/
BUILD_DIR = Build/
SOURCE_DIR = Source/

TARGET = Test
SOURCE = $(wildcard $(SOURCE_DIR)*.cpp)
OBJECT = $(patsubst %,$(BUILD_DIR)%, $(notdir $(SOURCE:.cpp=.o)))

all: release

release: pre_build $(OBJECT)
	$(CC) $(SOURCE) -I $(INCLUDE_DIR) $(CXXFLAGS) $(LDFLAGS) -o $(BINARY_DIR)$(TARGET)

debug: pre_build $(OBJECT)
	$(CC) $(SOURCE) -I $(INCLUDE_DIR) $(CXXFLAGS) $(LDFLAGS) -o $(BINARY_DIR)$(TARGET)Debug

$(BUILD_DIR)%.o: $(SOURCE_DIR)%.cpp
	$(CC) -I $(INCLUDE_DIR) -c $< -o $@

pre_build:
	@mkdir -p $(BINARY_DIR) $(BUILD_DIR)

clean:
	rm -rf $(BINARY_DIR) $(BUILD_DIR)
