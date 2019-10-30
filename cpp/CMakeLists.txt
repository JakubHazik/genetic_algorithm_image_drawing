cmake_minimum_required(VERSION 3.5)
project(ga_image)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )


add_executable(ga_image main.cpp)

target_link_libraries(ga_image
        ${OpenCV_LIBS})