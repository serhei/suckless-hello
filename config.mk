# hello version
VERSION = 0.1.0

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# XXX use to find includes and libs
#PKG_CONFIG = pkg-config

# includes and libs
INCS =
LIBS =

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\"
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# compiler and linker
#CC = c99
