
################################################################################
# Platform Checks
################################################################################
set(PCILIB_VERSION ${pci_VERSION})
set(PCI_SHARED_LIB ${BUILD_SHARED_LIBS})

string(TOUPPER "${CMAKE_SYSTEM_NAME}" CMAKE_SYSTEM_NAME_UPPER)
# set(PCI_OS_${CMAKE_SYSTEM_NAME_UPPER} 1)

if(APPLE)
    message(FATAL_ERROR "APPLE NOT SUPPORTED")
elseif(CYGWIN)
    message(FATAL_ERROR "CYGWIN NOT SUPPORTED")
elseif(UNIX) # LINUX
    set(PCI_OS_LINUX TRUE)
    set(PCI_ARCH_${CMAKE_SYSTEM_NAME_UPPER} TRUE)

    set(PCI_HAVE_PM_LINUX_SYSFS TRUE)
    set(PCI_HAVE_PM_LINUX_PROC TRUE)
    set(PCI_HAVE_PM_MMIO_CONF TRUE)
    set(PCI_HAVE_PM_ECAM TRUE)
    set(PCI_HAVE_LINUX_BYTEORDER_H TRUE)
    set(PCI_PATH_PROC_BUS_PCI "/proc/bus/pci")
    set(PCI_PATH_SYS_BUS_PCI "/sys/bus/pci")
    set(PCI_PATH_DEVMEM_DEVICE "/dev/mem")
    set(PCI_PATH_ACPI_MCFG "/sys/firmware/acpi/tables/MCFG")
    set(PCI_PATH_EFI_SYSTAB "/sys/firmware/efi/systab")

    message(STATUS "CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "i386" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" )
        set(PCI_HAVE_PM_INTEL_CONF TRUE)
    endif()

elseif(MINGW)
    message(FATAL_ERROR "MINGW NOT SUPPORTED")
elseif(WIN32)
    message(FATAL_ERROR "WIN32 NOT SUPPORTED")
endif()

################################################################################
# Checking for optional features
################################################################################
include(FindPkgConfig)
include(CheckIncludeFiles)

# zlib
find_package(ZLIB)
set(PCI_IDS "pci.ids")
if(ZLIB_FOUND)
    set(PCI_IDS "pci.ids.gz")
    set(PCI_COMPRESSED_IDS TRUE)
endif(ZLIB_FOUND)

# resolv
pkg_check_modules(RESOLV resolv)
if(RESOLV_FOUND)
    set(PCI_USE_DNS TRUE)
    set(PCI_ID_DOMAIN "pci.id.ucw.cz")
endif(RESOLV_FOUND)

# libkmod
pkg_check_modules(KMOD libkmod)
if(KMOD_FOUND)
    set(PCI_USE_LIBKMOD TRUE)
endif(KMOD_FOUND)

# udev hwdb support
pkg_check_modules(UDEV libudev>=196)
if(UDEV_FOUND)
    set(PCI_HAVE_HWDB TRUE)
endif(UDEV_FOUND)

# dump?
set(PCI_HAVE_PM_DUMP TRUE)

################################################################################
# configure file
################################################################################
configure_file("${CMAKE_CURRENT_LIST_DIR}/pciutils_config.h.in" "${CMAKE_BINARY_DIR}/config.h")
include_directories("${CMAKE_BINARY_DIR}")
