cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(dll_for_delivery CXX)

#####################################################################
# BUILD section
# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

if(NOT(CMAKE_VERSION LESS 3.4) AND MSVC)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
    message( STATUS "CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS: ${CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS}" )
endif()

set(SOURCE_FILES main.cpp)
add_library(dll_for_delivery SHARED ${SOURCE_FILES})

# force enable C++11
set_target_properties(dll_for_delivery PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES)

target_include_directories(dll_for_delivery PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include>)

# we need posfix because library files copy to same directory
set_target_properties(dll_for_delivery
        PROPERTIES DEBUG_POSTFIX d)
#####################################################################


#####################################################################
# INSTALL section
set(LIB_NAME dll_for_delivery)
configure_file(../cmake/export-config.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/dll_for_delivery-config.cmake
	@ONLY)

install(TARGETS dll_for_delivery
  EXPORT dll_for_delivery
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION include
  INCLUDES DESTINATION include
  PUBLIC_HEADER DESTINATION include)
  

install(FILES ${dll_for_delivery_SOURCE_DIR}/main_dll.h  DESTINATION include)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/dll_for_delivery-config.cmake DESTINATION cmake)
install(EXPORT dll_for_delivery
        DESTINATION cmake
        EXPORT_LINK_INTERFACE_LIBRARIES)
#####################################################################
