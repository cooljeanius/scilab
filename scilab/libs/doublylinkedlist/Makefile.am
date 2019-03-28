# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2007 - INRIA - Sylvestre LEDRU
#
# This file is distributed under the same license as the Scilab package.

DOUBLYLINKEDLIST_C_SOURCES = src/DoublyLinkedList.c

libscidoublylinkedlist_la_includedir=$(pkgincludedir)

libscidoublylinkedlist_la_include_HEADERS = includes/DoublyLinkedList.h

libscidoublylinkedlist_la_CPPFLAGS= -Wp,-I$(srcdir)/src/ \
    -Wp,-I$(srcdir)/includes/ \
    -Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
    $(AM_CPPFLAGS)

pkglib_LTLIBRARIES = libscidoublylinkedlist.la

libscidoublylinkedlist_la_SOURCES = $(DOUBLYLINKEDLIST_C_SOURCES)

# For the code check (splint)
CHECK_SRC= $(DOUBLYLINKEDLIST_C_SOURCES)
INCLUDE_FLAGS = `echo $(libscidoublylinkedlist_la_CPPFLAGS) | $(SED) "s/-Wp,//g"`

libscidoublylinkedlist_la_LIBADD = 

#### Target ######
modulename=doublylinkedlist

include $(top_srcdir)/Makefile.incl.am

distclean-local-1:
	-rm -rfv src/.deps/* || rmdir src/.deps
