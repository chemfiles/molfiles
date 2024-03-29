cmake_minimum_required(VERSION 3.16)

project(chemfiles-molfiles C CXX)

if (POLICY CMP0063)
    # Use of `CXX_VISIBILITY_PRESET` and `VISIBILITY_INLINES_HIDDEN` in OBJECT
    # libraries
    cmake_policy(SET CMP0063 NEW)
endif()

set(MOLFILES_SRC "")
foreach(plugin ${VMD_MOLFILE_PLUGINS})
    FILE(GLOB PLUGIN_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/${plugin}*.c*)
    list(LENGTH PLUGIN_PATH PLUGIN_PATH_NUMBER)
    if(NOT PLUGIN_PATH_NUMBER EQUAL 1)
        message(FATAL_ERROR "Could not find molfiles plugin ${plugin}")
    endif()
    set_source_files_properties(${PLUGIN_PATH} PROPERTIES COMPILE_FLAGS "-DSTATIC_PLUGIN -DVMDPLUGIN=${plugin}")
    list(APPEND MOLFILES_SRC ${PLUGIN_PATH})
endforeach()

if("${VMD_MOLFILE_PLUGINS}" STREQUAL "")
    message(WARNING "VMD_MOLFILE_PLUGINS variable is empty, no plugin will be compiled")
endif()

include_directories(include)
add_library(chemfiles_molfiles OBJECT ${MOLFILES_SRC})
set_target_properties(chemfiles_molfiles PROPERTIES
    C_VISIBILITY_PRESET hidden
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN ON
)
