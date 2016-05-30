function(copy_import import_lib config_src config_dst)
    # uppercase configs names
    string(TOUPPER ${config_dst} NEW_CFG)
    string(TOUPPER ${config_src} OLD_CFG)
        
    # read specified config parameters
    get_property(src_interface TARGET ${import_lib} PROPERTY IMPORTED_LINK_INTERFACE_LANGUAGES_${OLD_CFG})
    get_property(src_lib TARGET ${import_lib} PROPERTY IMPORTED_LOCATION_${OLD_CFG})
	get_property(src_imp TARGET ${import_lib} PROPERTY IMPORTED_IMPLIB_${OLD_CFG})
	message(STATUS "Copy from ${OLD_CFG} to ${NEW_CFG}: ${src_interface}")
	message(STATUS "${src_lib}")
	message(STATUS "${src_imp}")
    
    # set new config parameters
    set_property(TARGET ${import_lib} APPEND PROPERTY IMPORTED_CONFIGURATIONS ${NEW_CFG})
    set_target_properties(${import_lib} PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_${NEW_CFG} "${src_interface}"
        IMPORTED_LOCATION_${NEW_CFG} "${src_lib}"
		IMPORTED_IMPLIB_${NEW_CFG} "${src_imp}"
    )
endfunction(copy_import)
