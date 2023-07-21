include(CMakePrintHelpers)
cmake_print_variables(CMAKE_SYSTEM_PROCESSOR CMAKE_SYSTEM_NAME)

# message("CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")
# # echo >>$c "#define PCI_ARCH_`echo $cpu | tr '[a-z]' '[A-Z]'`"
# message("CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
# # echo >>$c "#define PCI_OS_`echo $sys | tr '[a-z]' '[A-Z]'`"

################################################################################
# Options
################################################################################

option(PCI_PM_DUMP "Pci" ON)
option(ZLIB "Enable Zlib support" ON)
option(DNS "Enable dns support" ON)
option(LIBKMOD "Enable libkmod support" ON)
option(HWDB "Enable hwdb support" ON)
# option(BUILD_STATIC_LIBS "Build the static library" ON)

################################################################################
# default values
################################################################################

set(PCI_PATH_IDS_DIR "")

################################################################################
# Set defines depending of the OS
################################################################################
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "OS=Linux")
    set(PCI_OS_LINUX TRUE)
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

    if((CMAKE_SYSTEM_PROCESSOR STREQUAL "i386") OR
        (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64"))
        set(PCI_HAVE_PM_INTEL_CONF TRUE)
    endif()

    set(PCI_HAVE_64BIT_ADDRESS TRUE)
endif(CMAKE_SYSTEM_NAME STREQUAL "Linux")

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    message("OS=Windows")
endif()

# if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
# target_compile_definitions(example PUBLIC "IS_MACOS")
# endif()
# if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
# target_compile_definitions(example PUBLIC "IS_WINDOWS")
# endif()

################################################################################
# ZLIB
################################################################################
set(PCI_COMPRESSED_IDS FALSE)
set(PCI_IDS "pci.ids")
if(ZLIB)
    message(STATUS "Checking for zlib support...")
    find_package(ZLIB REQUIRED)

    if(NOT ZLIB_FOUND)
        message(WARNING "Zlib not found")
    else(NOT ZLIB_FOUND)
        set(PCI_COMPRESSED_IDS TRUE)
        set(PCI_IDS "pci.ids.gz")
        # FIXME:
        # include_directories(${ZLIB_INCLUDE_DIRS})
        # target_link_libraries(YourProject ${ZLIB_LIBRARIES})
    endif(NOT ZLIB_FOUND)
endif(ZLIB)

################################################################################
# Dns Support
################################################################################
if(DNS)
    message(STATUS "Checking for dns support...")
    find_library(RESOLV_LIBRARY NAMES resolv)
    if(RESOLV_LIBRARY)
        set(PCI_USE_DNS TRUE)
        set(PCI_ID_DOMAIN "pci.id.ucw.cz")
        # 	echo >>$m "WITH_LIBS+=$LIBRESOLV"
    endif(RESOLV_LIBRARY)
endif(DNS)

################################################################################
# libkmod Support
################################################################################
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    if(LIBKMOD)
        message(STATUS "Checking for libkmod support...")
        find_library(LIBKMOD_LIBRARY NAMES libkmod)
        if(LIBKMOD_LIBRARY)
            set(PCI_USE_LIBKMOD TRUE)
            # set(LIBKMOD_CFLAGS=$($PKG_CONFIG --cflags libkmod)"
            # set("LIBKMOD_LIBS=$($PKG_CONFIG --libs libkmod)"
        endif(LIBKMOD_LIBRARY)
    endif(LIBKMOD)
endif(CMAKE_SYSTEM_NAME STREQUAL "Linux")

################################################################################
# udev hwdb Support
################################################################################
if(HWDB)
    message(STATUS "Checking for udev hwdb support...")
    find_library(LIBUDEV_LIBRARY NAMES libkmod)
    if(LIBKMOD_LIBRARY)
        set(PCI_HAVE_HWDB TRUE)
        # echo >>$m 'LIBUDEV=-ludev'
        # echo >>$m 'WITH_LIBS+=$(LIBUDEV)'
    endif(LIBKMOD_LIBRARY)
endif(HWDB)

################################################################################
# Generate configure file
################################################################################
configure_file(config.h.in config.h)
include_directories("${PROJECT_BINARY_DIR}")
