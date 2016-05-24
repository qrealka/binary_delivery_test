cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(library_for_delivery CXX)

#use it client project
#set(CMAKE_DEBUG_POSTFIX d)

# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

set(SOURCE_FILES main.cpp)
add_library(library_for_delivery ${SOURCE_FILES})

# force enable C++11
set_target_properties(library_for_delivery PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES)

target_include_directories(library_for_delivery PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include/library_for_delivery>)

set_target_properties(library_for_delivery
        PROPERTIES DEBUG_POSTFIX d)

# INSTALL
install(FILES ${library_for_delivery_SOURCE_DIR}/main_lib.h   DESTINATION include/library_for_delivery)

install(TARGETS library_for_delivery   
  EXPORT library_for_delivery
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  INCLUDES DESTINATION include
  CONFIGURATIONS Debug Release)

install(FILES library_for_delivery-config.cmake DESTINATION lib)
install(EXPORT library_for_delivery DESTINATION lib)
