cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(library_for_delivery CXX)




# BUILD section
# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

set(SOURCE_FILES main.cpp)
add_library(library_for_delivery STATIC ${SOURCE_FILES})

# force enable C++11
set_target_properties(library_for_delivery PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES)

target_include_directories(library_for_delivery PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include>)

# we need posfix because library files copy to same directory
set_target_properties(library_for_delivery
        PROPERTIES DEBUG_POSTFIX d)






# INSTALL section
# export store current full path name to cmake file! Don't use it:
# export(TARGETS library_for_delivery FILE library_for_delivery.cmake)

set(LIB_NAME library_for_delivery)
configure_file(../cmake/export-config.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/library_for_delivery-config.cmake
	@ONLY)

install(TARGETS library_for_delivery
  EXPORT library_for_delivery
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION include
  INCLUDES DESTINATION include
  PUBLIC_HEADER DESTINATION include)
  

install(FILES ${library_for_delivery_SOURCE_DIR}/main_lib.h  DESTINATION include)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/library_for_delivery-config.cmake DESTINATION cmake)
install(EXPORT library_for_delivery
        DESTINATION cmake
        EXPORT_LINK_INTERFACE_LIBRARIES)
