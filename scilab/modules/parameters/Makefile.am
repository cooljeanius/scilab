# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2008 - INRIA - Pierre MARECHAL
#
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

### SOURCES ###

PARAMETERS_C_SOURCES = src/c/parameters.c

libsciparameters_la_CPPFLAGS=-Wp,-I$(srcdir)/includes/ \
-Wp,-I$(srcdir)/src/c/ \
-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/core/includes/ \
-Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
-Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
-Wp,-I$(top_srcdir)/modules/localization/includes/ \
$(AM_CPPFLAGS) 

if MAINTAINER_MODE
pkglib_LTLIBRARIES = libsciparameters.la
else
noinst_LTLIBRARIES = libsciparameters.la
endif



libsciparameters_la_SOURCES = $(PARAMETERS_C_SOURCES)

# For the code check (splint)
CHECK_SRC= $(libsciparameters_la_SOURCES)
INCLUDE_FLAGS = $(libsciparameters_la_CPPFLAGS) 

#### Target ######
modulename=parameters

#### parameters : Conf files ####
libparameters_la_rootdir = $(mydatadir)
libparameters_la_root_DATA =  license.txt 

#### parameters : init scripts ####
libparameters_la_etcdir = $(mydatadir)/etc
libparameters_la_etc_DATA = etc/parameters.quit etc/parameters.start

include $(top_srcdir)/Makefile.incl.am
