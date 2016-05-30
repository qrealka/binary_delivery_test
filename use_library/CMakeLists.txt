cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

project(use_library CXX)

##########################################################################
# CONFIG section
#

# force enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message(STATUS "Supported CPP features = ${CMAKE_CXX_COMPILE_FEATURES}")

# remove standart configurations (just for testing)
if (CMAKE_CONFIGURATION_TYPES)
	list(REMOVE_ITEM CMAKE_CONFIGURATION_TYPES Release Debug)
	list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
	set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" 
		CACHE STRING "Configurations that we need" FORCE)
endif()

message(STATUS "CMAKE_CONFIGURATION_TYPES = ${CMAKE_CONFIGURATION_TYPES}")

include(../cmake/binary_delivery.cmake)
include(../cmake/copy_import.cmake)

##########################################################################
# BUILD section
#
set(SOURCE_FILES main.cpp)
add_executable(use_library ${SOURCE_FILES})

# force enable C++11
set_target_properties(use_library PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES
        )


##########################################################################
# IMPORT section
#
if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(lib_zip_suffix "x64")
else()
	set(lib_zip_suffix "x86")
endif() #CMAKE_SIZEOF_VOID_P

# Download lib 
# command line parameter -D USE_SHARED=1
if(USE_SHARED)

	# DOWNLOAD DYNAMIC LIB
	binary_delivery(PROJ dll_for_delivery
			URL "https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/msvc2013${lib_zip_suffix}.dll.zip")

	find_package(dll_for_delivery REQUIRED)
	copy_import(dll_for_delivery Release MinSizeRel)

	if (dll_for_delivery_FOUND)
		message(STATUS "dll_for_delivery configuration file: ${dll_for_delivery_CONSIDERED_CONFIGS}")

		target_compile_definitions(use_library PRIVATE "USE_SHARED")
		target_link_libraries(use_library PRIVATE dll_for_delivery)
		add_custom_command(TARGET use_library POST_BUILD	
			COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:dll_for_delivery> $<TARGET_FILE_DIR:use_library>
		)
	else()
		message(FATAL_ERROR "dll_for_delivery not found!")
	endif() #dll_for_delivery_FOUND
	
else()

	# DOWNLOAD STATIC LIB 	
	binary_delivery(PROJ library_for_delivery
			URL "https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/msvc2013${lib_zip_suffix}.zip")

	find_package(library_for_delivery REQUIRED)
	copy_import(library_for_delivery Release MinSizeRel)

	if (library_for_delivery_FOUND)
		message(STATUS "library_for_delivery configuration file: ${library_for_delivery_CONSIDERED_CONFIGS}")

		target_link_libraries(use_library PRIVATE library_for_delivery)
	else()
		message(FATAL_ERROR "library_for_delivery not found!")
	endif() #library_for_delivery_FOUND
	
endif() #USE_SHARED


