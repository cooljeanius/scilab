# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2007 - INRIA - Allan CORNET
#
# This file is distributed under the same license as the Scilab package.

DYNAMICLIBRARY_C_SOURCES = src/dynamiclibrary_others.c

libscidynamiclibrary_la_includedir=$(pkgincludedir)

libscidynamiclibrary_la_include_HEADERS = includes/dynamiclibrary_others.h \
includes/dynamiclibrary.h

libscidynamiclibrary_la_CPPFLAGS= -Wp,-I$(srcdir)/src/ -Wp,-I$(srcdir)/includes/

pkglib_LTLIBRARIES = libscidynamiclibrary.la

libscidynamiclibrary_la_SOURCES = $(DYNAMICLIBRARY_C_SOURCES)

# For the code check (splint)
CHECK_SRC= $(DYNAMICLIBRARY_C_SOURCES)
INCLUDE_FLAGS = $(libscidynamiclibrary_la_CPPFLAGS)

libscidynamiclibrary_la_LIBADD = 

#### Target ######
modulename=dynamiclibrary

include $(top_srcdir)/Makefile.incl.am

distclean-local-1:
	-rm -rfv src/.deps/* || rmdir src/.deps
