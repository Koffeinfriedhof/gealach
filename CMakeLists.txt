cmake_minimum_required(VERSION 3.0)

SET (_CUSTOM_PROJECT_NAME "gealach")
SET (_ORG_DEFINITION "org.koffeinfriedhof")

project(plasma-${_CUSTOM_PROJECT_NAME})

SET(_FULL_PROJECT_NAME "${_ORG_DEFINITION}.${_CUSTOM_PROJECT_NAME}")

MESSAGE("Compiling:" ${_FULL_PROJECT_NAME})

find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

find_package(KF5Plasma REQUIRED)

#provide translations
add_subdirectory(po)

#provide icon
INSTALL(FILES "contents/images/luna-gskbyte14.svg" DESTINATION ${ICON_INSTALL_DIR}/ RENAME "${_FULL_PROJECT_NAME}.svg")

plasma_install_package(package ${_FULL_PROJECT_NAME})

# due there are no depencies I could kill I'm providing an uninstall target:
# → https://cmake.org/Wiki/CMake_FAQ#Can_I_do_.22make_uninstall.22_with_CMake.3F
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
