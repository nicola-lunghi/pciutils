################################################################################
# sources
################################################################################

# OBJS=init names-hwdb params caps
set(PCILIB_SRCS
    init.c
    access.c
    generic.c
    names.c
    # names.h
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
    # config.h
    header.h
    sysdep.h
    types.h
)

if(PCI_HAVE_PM_LINUX_SYSFS)
    list(APPEND PCILIB_SRCS sysfs.c pread.h)
endif(PCI_HAVE_PM_LINUX_SYSFS)

if(PCI_HAVE_PM_LINUX_PROC)
    list(APPEND PCILIB_SRCS proc.c pread.h)
endif(PCI_HAVE_PM_LINUX_PROC)

if(PCI_HAVE_PM_INTEL_CONF)
    list(APPEND PCILIB_SRCS
        i386-ports.c
        i386-io-beos.h
        i386-io-cygwin.h
        i386-io-djgpp.h
        i386-io-haiku.h
        i386-io-hurd.h
        i386-io-linux.h
        i386-io-sunos.h
        i386-io-windows.h
    )
endif(PCI_HAVE_PM_INTEL_CONF)

if(PCI_HAVE_PM_MMIO_CONF)
    list(APPEND PCILIB_SRCS mmio-ports.c)
endif(PCI_HAVE_PM_MMIO_CONF)

if(PCI_HAVE_PM_ECAM)
    list(APPEND PCILIB_SRCS ecam.c)
endif(PCI_HAVE_PM_ECAM)

if(PCI_HAVE_PM_DUMP)
    list(APPEND PCILIB_SRCS dump.c)
endif(PCI_HAVE_PM_DUMP)

if(PCI_HAVE_PM_FBSD_DEVICE)
    list(APPEND PCILIB_SRCS fbsd-device.c)
    # CFLAGS += -I/usr/src/sys
    if(FREEBSD_SYS)
        # CFLAGS += -I${FREEBSD_SYS}
    endif(FREEBSD_SYS)
endif(PCI_HAVE_PM_FBSD_DEVICE)

if(PCI_HAVE_PM_OBSD_DEVICE)
    list(APPEND PCILIB_SRCS obsd-device.c)
endif(PCI_HAVE_PM_OBSD_DEVICE)

if(PCI_HAVE_PM_AIX_DEVICE)
    list(APPEND PCILIB_SRCS aix-device.c)
endif(PCI_HAVE_PM_AIX_DEVICE)

if(PCI_HAVE_PM_NBSD_LIBPCI)
    list(APPEND PCILIB_SRCS nbsd-libpci.c)
endif(PCI_HAVE_PM_NBSD_LIBPCI)

if(PCI_HAVE_PM_DARWIN_DEVICE)
    list(APPEND PCILIB_SRCS darwin.c)
endif(PCI_HAVE_PM_DARWIN_DEVICE)

if(PCI_HAVE_PM_SYLIXOS_DEVICE)
    list(APPEND PCILIB_SRCS sylixos-device.c)
endif(PCI_HAVE_PM_SYLIXOS_DEVICE)

if(PCI_HAVE_PM_HURD_CONF)
    list(APPEND PCILIB_SRCS hurd.c)
endif(PCI_HAVE_PM_HURD_CONF)

if(PCI_HAVE_PM_WIN32_CFGMGR32)
    list(APPEND PCILIB_SRCS emulated.c win32-cfgmgr32.c)
endif(PCI_HAVE_PM_WIN32_CFGMGR32)

if(PCI_HAVE_PM_WIN32_KLDBG)
    list(APPEND PCILIB_SRCS win32-kldbg.c)
endif(PCI_HAVE_PM_WIN32_KLDBG)

if(PCI_HAVE_PM_WIN32_SYSDBG)
    list(APPEND PCILIB_SRCS win32-sysdbg.c)
endif(PCI_HAVE_PM_WIN32_SYSDBG)

################################################################################
# library
#################################################################################

add_library(pci ${PCILIB_SRCS})
