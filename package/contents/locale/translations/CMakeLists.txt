SET(catalogue "org.kde.plasma.userbase.gealach")

FILE(GLOB MO_FILES *.mo)

FOREACH(_moFile ${MO_FILES})

    GET_FILENAME_COMPONENT(_moFileName ${_moFile} NAME)
    STRING(REGEX REPLACE "^${catalogue}_?" "" _langCode ${_moFileName} )
    STRING(REGEX REPLACE "\\.mo$" "" _langCode ${_langCode} )

    MESSAGE("*** found translation for: " ${_langCode})

    IF( _langCode )
        STRING(REGEX REPLACE "\\_${_langCode}.mo$" "" _pmoFile ${_moFileName} )

        INSTALL(FILES ${_pmoFile}_${_langCode}.mo DESTINATION ${LOCALE_INSTALL_DIR}/${_langCode}/LC_MESSAGES/ RENAME plasma_applet_${_pmoFile}.mo)
    ENDIF( _langCode )

ENDFOREACH(_moFile ${MO_FILES})
