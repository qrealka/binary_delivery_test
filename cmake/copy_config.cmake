include(CMakeParseArguments)

function(copy_config)

    set(oneValueArgs
        NEW_CONFIG
        OLD_CONFIG
        )
        
    set(multiValueArgs "")
    set(options "")
    
    cmake_parse_arguments(COPY_CFG_ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    string(TOUPPER ${COPY_CFG_ARGS_NEW_CONFIG} NEW_CFG)
    string(TOUPPER ${COPY_CFG_ARGS_OLD_CONFIG} OLD_CFG)

    if(CMAKE_CONFIGURATION_TYPES)
        list(APPEND CMAKE_CONFIGURATION_TYPES ${NEW_CFG})
        list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
        
        set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" 
            CACHE STRING "Configurations that we need" FORCE)        
    endif()
    
    
	set (CMAKE_CXX_FLAGS_${NEW_CFG}           "${CMAKE_CXX_FLAGS_${OLD_CFG}} -D${NEW_CFG}"   
            CACHE STRING "Flags used by the compiler during ${NEW_CFG} builds" FORCE)
            
	set (CMAKE_C_FLAGS_${NEW_CFG}             "${CMAKE_C_FLAGS_${OLD_CFG}}   -D${NEW_CFG}"   
            CACHE STRING "Flags used by the compiler during ${NEW_CFG} builds" FORCE)
            
	set (CMAKE_EXE_LINKER_FLAGS_${NEW_CFG}    "${CMAKE_EXE_LINKER_FLAGS_${OLD_CFG}}"         
            CACHE STRING "Flags used by the linker during ${NEW_CFG} builds"   FORCE)
            
	set (CMAKE_MODULE_LINKER_FLAGS_${NEW_CFG} "${CMAKE_MODULE_LINKER_FLAGS_${OLD_CFG}}"      
            CACHE STRING "Flags used by the linker during ${NEW_CFG} builds"   FORCE)
            
	set (CMAKE_SHARED_LINKER_FLAGS_${NEW_CFG} "${CMAKE_SHARED_LINKER_FLAGS_${OLD_CFG}}"      
            CACHE STRING "Flags used by the linker during ${NEW_CFG} builds"   FORCE)
    
endfunction()

