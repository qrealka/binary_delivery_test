# Binary delivery POC

## Purpose
All components can be extracted and added as binary dependencies on the application. The binary artifact is static library (*.lib or *.a) or shared library (*.dll or *.so) and headers. All components use [CMAKE](https://cmake.org/cmake/help/latest/) for describe build and install steps. Each component is developed in a separate repository.

## Condition
Application don't have nested dependecies. We can't use [CONAN](https://conan.io/) or [HUNTER](https://docs.hunter.sh/en/latest/) systems. 

## Using
I just try use [CMAKE Relocatable Packages](https://cmake.org/cmake/help/v3.4/manual/cmake-packages.7.html#creating-relocatable-packages). More details [here](https://foonathan.github.io/blog/2016/03/03/cmake-install.html)

### Relocatable static library
* Add [install commands](https://cmake.org/cmake/help/latest/command/install.html?highlight=install) to CMakeLists.txt file like [here](https://github.com/qrealka/binary_delivery_test/blob/master/library_for_delivery/CMakeLists.txt)
* Build package. For example:
```
cd library_for_delivery
mkdir !build
cd !build
cmake -DCMAKE_INSTALL_PREFIX=x86 -G"Visual Studio 12" ..
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
```
* zip directory x86/x64 and upload to server.
* Add [binary_delivery](https://github.com/qrealka/binary_delivery_test/blob/master/cmake/binary_delivery.cmake) command to **application** CMakeLists. [For example](https://github.com/qrealka/binary_delivery_test/blob/master/use_library/CMakeLists.txt)
* Add [find_package](https://cmake.org/cmake/help/latest/command/find_package.html?highlight=find_package) command after [binary_delivery](https://github.com/qrealka/binary_delivery_test/blob/master/cmake/binary_delivery.cmake).
* Use found target. If application habe not standart config name - use [copy_import](https://github.com/qrealka/binary_delivery_test/blob/master/cmake/copy_import.cmake) command
```
	binary_delivery(
        PROJ library_for_delivery
		URL "https://github.com/qrealka/binary_delivery_test/releases/download/1.0.1/msvc2013${lib_zip_suffix}.zip")

	find_package(library_for_delivery REQUIRED)
	copy_import(library_for_delivery Release MinSizeRel)

	if (library_for_delivery_FOUND)
		message(STATUS "library_for_delivery configuration file: ${library_for_delivery_CONSIDERED_CONFIGS}")

		target_link_libraries(use_library PRIVATE library_for_delivery)
	else()
		message(FATAL_ERROR "library_for_delivery not found!")
	endif() #library_for_delivery_FOUND
```

### Relocatable shared library
Same steps as for static library. But in application CMakeLists file we must one line:
```
		add_custom_command(TARGET use_library POST_BUILD	
			COMMAND ${CMAKE_COMMAND} -E copy_if_different 
              $<TARGET_FILE:dll_for_delivery> 
              $<TARGET_FILE_DIR:use_library>
		)
```
Just copy downloaded dll to target directory.
