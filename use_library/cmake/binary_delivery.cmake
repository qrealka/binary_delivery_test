include(CMakeParseArguments)

function(binary_delivery)
    set(options QUIET)

    set(oneValueArgs
        PROJ
        URL
        PREFIX
        INSTALL_DIR
        DOWNLOAD_DIR
        # Prevent it
        CMAKE_ARGS
        CONFIGURE_COMMAND
        PATCH_COMMAND
        BUILD_COMMAND
        INSTALL_COMMAND
        UPDATE_COMMAND
        TEST_COMMAND
        )
    set(multiValueArgs "")
    cmake_parse_arguments(BIN_DELIVERY_ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT BIN_DELIVERY_ARGS_PREFIX)
        set(BIN_DELIVERY_ARGS_PREFIX "${CMAKE_BINARY_DIR}")
    endif()

    if (NOT BIN_DELIVERY_ARGS_INSTALL_DIR)
        set(BIN_DELIVERY_ARGS_INSTALL_DIR "${CMAKE_BINARY_DIR}")
    endif()

    if (NOT BIN_DELIVERY_ARGS_DOWNLOAD_DIR)
        set(BIN_DELIVERY_ARGS_DOWNLOAD_DIR "${CMAKE_BINARY_DIR}/${BIN_DELIVERY_ARGS_PROJ}.tmp")
    endif()

    set(${BIN_DELIVERY_ARGS_PROJ}_DIR "${CMAKE_BINARY_DIR}/${BIN_DELIVERY_ARGS_PROJ}" PARENT_SCOPE)

    configure_file("${CMAKE_CURRENT_LIST_DIR}/cmake/external.CMakeLists.in"
            "${BIN_DELIVERY_ARGS_DOWNLOAD_DIR}/CMakeLists.txt")

    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
            WORKING_DIRECTORY "${BIN_DELIVERY_ARGS_DOWNLOAD_DIR}"
            )
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
            WORKING_DIRECTORY "${BIN_DELIVERY_ARGS_DOWNLOAD_DIR}"
            )
endfunction()