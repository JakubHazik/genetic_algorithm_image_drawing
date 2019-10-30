#include <iostream>
#include <opencv2/opencv.hpp>

#define IMAGE_SIZE cv::Size(400,400)
#define IMAGE_TYPE CV_8U


cv::Mat readOriginalImg(std::string path) {
    auto img = cv::imread(path, cv::IMREAD_GRAYSCALE);

    if(img.empty())
    {
        std::cout<<"image not found or read!<<endl; <="" br=""> return -1";
        throw std::runtime_error("can not read image");
    }

    cv::resize(img, img,IMAGE_SIZE );
    img.convertTo(img, IMAGE_TYPE);
    img.convertTo(img, -1, 1, -40);

    cv::imshow("tsfs", img);
    cv::waitKey(0);

    cv::imwrite("customImage.jpg", img);

    return img;
}

void addCircle(cv::Mat &img, int x, int y, int r, int color) {
    cv::Mat tmp = cv::Mat::zeros(IMAGE_SIZE, IMAGE_TYPE);
    cv::circle(tmp, cv::Point(x, y), r, cv::Scalar(color), -1);
    cv::blur(tmp, tmp, cv::Size(7, 7));
    cv::add(tmp, img, img);
}

double computeDiff(cv::Mat &img1, cv::Mat &img2) {
    cv::Mat resultImg;
    cv::absdiff(img1, img2, resultImg);
    return cv::sum(resultImg)[0];
}

int main() {

    auto originalImg = readOriginalImg("../foto.JPG");

    cv::Mat gaImg(IMAGE_SIZE, IMAGE_TYPE);

    addCircle(gaImg, 100, 100, 50, 126);
    addCircle(gaImg, 150, 100, 50, 126);
    addCircle(gaImg, 100, 150, 50, 200);

    auto result = computeDiff(gaImg, originalImg);

    std::cout<<"result: "<< result;

    cv::imshow("foto", gaImg);
    cv::waitKey(0);

    return 0;
}