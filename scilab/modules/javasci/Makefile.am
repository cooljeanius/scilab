#
# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) INRIA   - 2006 - Sylvestre Ledru
# Copyright (C) DIGITEO - 2009 - Pierre MARECHAL
# 
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at    
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
#

#### Target ######
modulename=javasci

#### javasci : Conf files ####
libjavasci2_la_rootdir = $(mydatadir)
libjavasci2_la_root_DATA =  license.txt 

#### javasci : init scripts ####
libjavasci2_la_etcdir = $(mydatadir)/etc
libjavasci2_la_etc_DATA = etc/javasci.quit etc/javasci.start


if JAVASCI
### All the compilation process of java is deleguated to ant


#### Javasci : sources ####
JAVASCI_V2_C_SOURCES = \
src/jni/call_scilab_wrap.c \
src/jni/putLists.c \
src/c/javasci2_helper.c

JAVASCI_V2_C_CFLAGS = -Wno-missing-prototypes -Wno-unused

pkglib_LTLIBRARIES = libjavasci2.la


libjavasci2_la_SOURCES = $(JAVASCI_V2_C_SOURCES)
libjavasci2_la_CFLAGS = $(JAVASCI_V2_C_CFLAGS)

# For the code check (splint)
CHECK_SRC= $(JAVASCI_C_SOURCES)
INCLUDE_FLAGS = $(libjavasci2_la_CPPFLAGS)

libjavasci2_la_CPPFLAGS = -Wp,-I$(srcdir)/includes/ \
			-Wp,-I$(srcdir)/src/c/ \
			$(JAVA_JNI_INCLUDE) \
			$(TCL_INC_PATH) \
			$(TK_INC_PATH) \
			-Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
			-Wp,-I$(top_srcdir)/libs/doublylinkedlist/includes/ \
			-Wp,-I$(top_srcdir)/modules/tclsci/includes/ \
			-Wp,-I$(top_srcdir)/modules/call_scilab/includes/ \
			-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
			-Wp,-I$(top_srcdir)/modules/fileio/includes/ \
			-Wp,-I$(top_srcdir)/modules/localization/includes/ \
			-Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
			$(AM_CPPFLAGS)

libjavasci2_la_LIBADD = \
	$(top_builddir)/libs/MALLOC/libscimalloc.la \
	$(top_builddir)/modules/api_scilab/libsciapi_scilab.la \
	$(top_builddir)/modules/libscilab.la

$(top_builddir)/modules/libscilab.la: $(top_builddir)/modules/Makefile
	$(MAKE) -C $(top_builddir)/modules libscilab.la

$(top_builddir)/modules/libscilab-cli.la: $(top_builddir)/modules/Makefile
	$(MAKE) -C $(top_builddir)/modules libscilab-cli.la

BUILT_SOURCES=
if SWIG
BUILT_SOURCES+=swig
endif

#### SWIG Declaration ####
SWIG_WRAPPERS = src/jni/call_scilab.i

USEANT=1

include $(top_srcdir)/Makefile.incl.am

endif
