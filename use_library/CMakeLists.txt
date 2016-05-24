cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(use_library)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
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

include(cmake/binary_delivery.cmake)

# Download lib if required
if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(lib_zip_name "msvc2013-x64.zip")
else()
	set(lib_zip_name "msvc2013-x86.zip")
endif()

binary_delivery(PROJ library_for_delivery
		URL "https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/${lib_zip_name}")

link_directories(${CMAKE_CURRENT_BINARY_DIR}/lib)
find_package(library_for_delivery)

target_include_directories(use_library PRIVATE ${library_for_delivery_INCLUDE_DIR})
target_link_libraries(use_library PRIVATE library_for_delivery)

# bad version. first try
#include(ExternalProject)

#ExternalProject_Add(lib_external
#        URL https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/${lib_zip_name}
#        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/external/library
#        INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}
#        CONFIGURE_COMMAND ""
#        PATCH_COMMAND ""
#        BUILD_COMMAND ""
#        UPDATE_COMMAND ""
#        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}
#)


