
function(copy_config NEW_CONFIG OLD_CONFIG)

    string(TOUPPER ${NEW_CONFIG} NEW_CFG)
    string(TOUPPER ${OLD_CONFIG} OLD_CFG)

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
    
endfunction(copy_config)

function(copy_import DST_TAGRET SRC_CONFIG DST_CONFIG)
    
endfunction(copy_import)


