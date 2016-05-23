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

# bad version. first try
include(ExternalProject)

link_directories(${CMAKE_CURRENT_BINARY_DIR}/lib)
ExternalProject_Add(lib_external
    URL https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/msvc2013.zip
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/external/library
    INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}
)

add_library(lib_static STATIC IMPORTED GLOBAL)
add_dependencies(lib_static lib_external)
if(MSVC)
    set_target_properties(lib_static PROPERTIES
                         IMPORTED_LOCATION_DEBUG ${CMAKE_CURRENT_BINARY_DIR}/lib/library_for_deliveryd.lib
                         IMPORTED_LOCATION_MINSIZEREL ${CMAKE_CURRENT_BINARY_DIR}/lib/library_for_delivery.lib
                         IMPORTED_LOCATION_RELEASE ${CMAKE_CURRENT_BINARY_DIR}/lib/library_for_delivery.lib
                         IMPORTED_LOCATION_RELWITHDEBINFO ${CMAKE_CURRENT_BINARY_DIR}/lib/library_for_delivery.lib
                         LINKER_LANGUAGE CXX)
else()
    set_target_properties(lib_static PROPERTIES
                          IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/lib/library_for_delivery.a
                          LINKER_LANGUAGE CXX)
endif()

target_include_directories(use_library PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/include)
target_link_libraries(use_library PRIVATE lib_static)

