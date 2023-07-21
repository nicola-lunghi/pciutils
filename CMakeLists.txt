cmake_minimum_required(VERSION 3.14)

project(pciutils
    VERSION 3.10.0
    LANGUAGES C
)

################################################################################
# Configuration options
################################################################################

# option(BUILD_STATIC_LIBS "Build the static library" ON)
option(PCI_HAVE_PM_DUMP "Enable reading of bus dumps" ON)

include(cmake/pciconfig.cmake)

################################################################################
# Main Project
################################################################################

add_subdirectory(libpci)
# add_subdirectory(pciutils)
# add_subdirectory(man)
# add_subdirectory(tests)
