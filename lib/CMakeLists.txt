# CMakeLists for The PCI Utilities
# (c) 1998--2023 Martin Mares <mj@ucw.cz>

################################################################################
# PCI lib
################################################################################
set(pcilib_SRCS
    init.c
    access.c
    generic.c
    dump.c
    names.c
    filter.c
    names-hash.c
    names-parse.c
    names-net.c
    names-cache.c
    names-hwdb.c
    params.c
    caps.c

    internal.h
    pci.h
    header.h
    sysdep.h
    types.h
)
################################################################################
# platform options
################################################################################
if(PCI_HAVE_PM_LINUX_SYSFS)
    list(APPEND pcilib_SRCS sysfs.c)
endif(PCI_HAVE_PM_LINUX_SYSFS)

if(PCI_HAVE_PM_LINUX_PROC)
    list(APPEND pcilib_SRCS proc.c)
endif(PCI_HAVE_PM_LINUX_PROC)

if(PCI_HAVE_PM_INTEL_CONF)
    list(APPEND pcilib_SRCS i386-ports.c)
endif(PCI_HAVE_PM_INTEL_CONF)

if(PCI_HAVE_PM_MMIO_CONF)
    list(APPEND pcilib_SRCS mmio-ports.c)
endif(PCI_HAVE_PM_MMIO_CONF)

if(PCI_HAVE_PM_ECAM)
    list(APPEND pcilib_SRCS ecam.c)
endif(PCI_HAVE_PM_ECAM)

if(PCI_HAVE_PM_DUMP)
    list(APPEND pcilib_SRCS dump.c)
endif(PCI_HAVE_PM_DUMP)

if(PCI_HAVE_PM_FBSD_DEVICE)
    list(APPEND pcilib_SRCS fbsd-device.c)
    # CFLAGS() += -I/usr/src/sys
    # if(FREEBSD_SYS)
    # # CFLAGS += -I${FREEBSD_SYS}
    # endif
endif(PCI_HAVE_PM_FBSD_DEVICE)

if(PCI_HAVE_PM_OBSD_DEVICE)
    list(APPEND pcilib_SRCS obsd-device.c)
endif(PCI_HAVE_PM_OBSD_DEVICE)

if(PCI_HAVE_PM_AIX_DEVICE)
    list(APPEND pcilib_SRCS aix-device.c)
endif(PCI_HAVE_PM_AIX_DEVICE)

if(PCI_HAVE_PM_NBSD_LIBPCI)
    list(APPEND pcilib_SRCS nbsd-libpci.c)
endif(PCI_HAVE_PM_NBSD_LIBPCI)

if(PCI_HAVE_PM_DARWIN_DEVICE)
    list(APPEND pcilib_SRCS darwin.c)
endif(PCI_HAVE_PM_DARWIN_DEVICE)

if(PCI_HAVE_PM_SYLIXOS_DEVICE)
    list(APPEND pcilib_SRCS sylixos-device.c)
endif(PCI_HAVE_PM_SYLIXOS_DEVICE)

if(PCI_HAVE_PM_HURD_CONF)
    list(APPEND pcilib_SRCS hurd.c)
endif(PCI_HAVE_PM_HURD_CONF)

if(PCI_HAVE_PM_WIN32_CFGMGR32)
    list(APPEND pcilib_SRCS emulated.c win32-cfgmgr32.c)
endif(PCI_HAVE_PM_WIN32_CFGMGR32)

if(PCI_HAVE_PM_WIN32_KLDBG)
    list(APPEND pcilib_SRCS win32-kldbg.c)
endif(PCI_HAVE_PM_WIN32_KLDBG)

if(PCI_HAVE_PM_WIN32_SYSDBG)
    list(APPEND pcilib_SRCS win32-sysdbg.c)
endif(PCI_HAVE_PM_WIN32_SYSDBG)

################################################################################
# optional libraries
################################################################################
# if(WIN32)
#     list(APPEND WITH_LIBS cfgmgr32)
#     if(CYGWIN)
#         list(APPEND WITH_LIBS lioperm)
#     else()
#         list(APPEND WITH_LIBS advapi32)
#     endif(CYGWIN)
# endif(WIN32)

################################################################################
# pci lib
################################################################################
add_library(pci ${pcilib_SRCS})
target_include_directories(pci
    PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}" "${PCILIB_GEN_INCLUDE_DIR}"
)
target_link_libraries(pci
    ${ZLIB_LIBRARIES}
    ${RESOLV_LIBRARIES}
    ${KMOD_LIBRARIES}
    ${UDEV_LIBRARIES}
)
# CFLAGS += -fPIC -fvisibility=hidden
