#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

void RGBImageDecomposition(
    cv::Mat& originalImage, 
    cv::Mat& blueImage,
    cv::Mat& greenImage,
    cv::Mat& redImage) {

    // Populate the images
    size_t imageSize = originalImage.rows * originalImage.cols * originalImage.elemSize();
    int elementSize = originalImage.elemSize();
    for (size_t i = 0; i < imageSize; i += elementSize) {
        blueImage.data[i] = originalImage.data[i];
        greenImage.data[i+1] = originalImage.data[i+1];
        redImage.data[i+2] = originalImage.data[i+2];
    }
}

int main() {
    std::cout <<  "Start Program.\n";

    //cv::Mat image = cv::imread("Resource/Image/RGBImage.jpg", CV_LOAD_IMAGE_COLOR);
    cv::Mat image = cv::imread("Resource/Image/RGBImage.jpg", CV_LOAD_IMAGE_COLOR);
    if (image.empty()) {
        std::cout << "Could not open or find the image.\n";
        return EXIT_FAILURE;
    }

    // Create three new images
    cv::Mat blueImage = cv::Mat::zeros(image.rows, image.cols, CV_8UC3);
    cv::Mat greenImage = cv::Mat::zeros(image.rows, image.cols, CV_8UC3);
    cv::Mat redImage = cv::Mat::zeros(image.rows, image.cols, CV_8UC3);

    RGBImageDecomposition(image, blueImage, greenImage, redImage);

    // Save the images
    imwrite("Bin/BlueChannel.jpg", blueImage);
    imwrite("Bin/GreenChannel.jpg", greenImage);
    imwrite("Bin/RedChannel.jpg", redImage);

    std::cout <<  "End Program.\n";
    return EXIT_SUCCESS;
}
