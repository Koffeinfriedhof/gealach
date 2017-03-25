SET(catalogue plasma_applet_${_FULL_PROJECT_NAME})

FILE(GLOB MO_FILES *.mo)

FOREACH(_moFile ${MO_FILES})

    GET_FILENAME_COMPONENT(_moFileName ${_moFile} NAME)
    MESSAGE (${_moFileName})
    STRING(REGEX REPLACE "^${catalogue}_?" "" _langCode ${_moFileName} )
    STRING(REGEX REPLACE "\\.mo$" "" _langCode ${_langCode} )

    MESSAGE("*** found translation for: " ${_langCode})

    IF( _langCode )
        STRING(REGEX REPLACE "\\_${_langCode}.mo$" "" _pmoFile ${_moFileName} )
        INSTALL(FILES ${_moFile} DESTINATION ${LOCALE_INSTALL_DIR}/${_langCode}/LC_MESSAGES/ RENAME ${catalogname}.mo)
    ENDIF( _langCode )

ENDFOREACH(_moFile ${MO_FILES})

