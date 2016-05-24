cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(library_for_delivery CXX)

# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

set(SOURCE_FILES main.cpp)
add_library(library_for_delivery ${SOURCE_FILES})

# force enable C++11
set_target_properties(library_for_delivery PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES
        )

target_include_directories(library_for_delivery
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>		
		$<INSTALL_INTERFACE:include/library_for_delivery>) 

if(USE_BINARY_DELIVERY)
   set_target_properties(library_for_delivery PROPERTIES
					 IMPORTED_LOCATION lib
					 LINKER_LANGUAGE CXX)

    install(DIRECTORY include/ 
        DESTINATION include/library_for_delivery
        FILES_MATCHING PATTERN "*.h")
endif()

install(TARGETS library_for_delivery   
  EXPORT library_for_delivery
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  INCLUDES DESTINATION include)

install(EXPORT library_for_delivery DESTINATION lib)
