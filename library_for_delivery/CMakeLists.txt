cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(library_for_delivery CXX)

# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES main.cpp)
add_library(library_for_delivery ${SOURCE_FILES})

# force enable C++11
set_target_properties(library_for_delivery PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES
        )
