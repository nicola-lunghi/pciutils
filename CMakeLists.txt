# CMakeLists for The PCI Utilities
# (c) 1998--2023 Martin Mares <mj@ucw.cz>

cmake_minimum_required(VERSION 3.20)

project(pci
    DESCRIPTION "The PCI Utilities package contains a library for portable access to PCI bus configuration registers and several utilities based on this library."
    HOMEPAGE_URL "https://github.com/pciutils/pciutils"
    LANGUAGES C
    VERSION "3.10.0"
)

################################################################################
# Build options
################################################################################
option(BUILD_SHARED_LIBS "Build  pci libraries as shared libs" OFF)

include(pciutils_config.cmake)

################################################################################
# pci lib
################################################################################
add_subdirectory(lib)

################################################################################
# pci utilities
################################################################################
set(PCIUTILS_COMMON_SRCS common.c)

if(COMPAT_GETOPT)
list(APPEND PCIUTILS_COMMON_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/compat/getopt.c
    ${CMAKE_CURRENT_SOURCE_DIR}/compat/getopt.h
)
endif()

# lspci
add_executable(lspci
    lspci.c lspci.h
    ls-vpd.c
    ls-caps.c
    ls-caps-vendor.c
    ls-ecaps.c
    ls-kernel.c
    ls-tree.c
    ls-map.c
    ${PCIUTILS_COMMON_SRCS}
)
target_link_libraries(lspci pci)

# setpci
add_executable(setpci
    setpci.c
    ${PCIUTILS_COMMON_SRCS}
)
target_link_libraries(setpci pci)
