cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(use_library)

# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

set(SOURCE_FILES main.cpp)
add_executable(use_library ${SOURCE_FILES})

# force enable C++11
set_target_properties(use_library PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES
        )

include(../cmake/binary_delivery.cmake)

# Download lib if required
if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(lib_zip_name "msvc2013x64.zip")
else()
	set(lib_zip_name "msvc2013x86.zip")
endif()

binary_delivery(PROJ library_for_delivery
		URL "https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/${lib_zip_name}")

find_package(library_for_delivery REQUIRED)

if (library_for_delivery_FOUND)
	message(STATUS "library_for_delivery configurations: ${library_for_delivery_CONSIDERED_CONFIGS}")

	target_link_libraries(use_library PRIVATE library_for_delivery)
else()
	message(FATAL_ERROR "library_for_delivery not found!")
endif()

