#
# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) DIGITEO - 2010 - Allan CORNET
# 
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at    
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
#

#### Target ######
modulename=history_browser


#### history_browser : Conf files ####
libscihistory_browser_la_rootdir = $(mydatadir)
libscihistory_browser_la_root_DATA =  license.txt 


#### history_browser : init scripts ####
libscihistory_browser_la_etcdir = $(mydatadir)/etc
libscihistory_browser_la_etc_DATA = etc/history_browser.quit \
				etc/history_browser.start

if GUI

# List of the JNI files
HISTORY_BROWSER_JNI_SOURCES = src/jni/CommandHistory.cpp

HISTORY_BROWSER_CXX_SOURCES = src/cpp/CommandHistory_Wrap.cpp

HISTORY_BROWSER_C_SOURCES = 

# List of the gateway c files
GATEWAY_C_SOURCES =  sci_gateway/c/gw_history_browser.c \
sci_gateway/c/sci_browsehistory.c

else
HISTORY_BROWSER_C_SOURCES = src/nohistory_browser/CommandHistory_Wrap_Fake.c
endif

libscihistory_browser_la_CPPFLAGS = $(JAVA_JNI_INCLUDE) \
-Wp,-I$(srcdir)/src/jni/ \
-Wp,-I$(srcdir)/src/c/ \
-Wp,-I$(srcdir)/includes/ \
-Wp,-I$(top_srcdir)/libs/MALLOC/includes \
-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/jvm/includes/ \
-Wp,-I$(top_srcdir)/modules/commons/src/jni/ \
$(AM_CPPFLAGS)

# Without the history_browser module 
libscihistory_browser_disable_la_CPPFLAGS = -Wp,-I$(srcdir)/includes/ $(AM_CPPFLAGS)
HISTORY_BROWSER_DISABLE_C_SOURCES =  src/nohistory_browser/CommandHistory_Wrap_Fake.c
libscihistory_browser_disable_la_SOURCES = $(HISTORY_BROWSER_DISABLE_C_SOURCES)

pkglib_LTLIBRARIES = libscihistory_browser-disable.la

if GUI
pkglib_LTLIBRARIES += libscihistory_browser.la 
endif

libscihistory_browser_la_LDFLAGS = $(X_LIBS) $(X_EXTRA_LIBS) $(AM_LDFLAGS)

libscihistory_browser_la_SOURCES = $(HISTORY_BROWSER_C_SOURCES) $(HISTORY_BROWSER_JNI_SOURCES) $(HISTORY_BROWSER_CXX_SOURCES) $(GATEWAY_C_SOURCES)

# For the code check (splint)
CHECK_SRC= $(HISTORY_BROWSER_C_SOURCES)
INCLUDE_FLAGS = $(libscihistory_browser_la_CPPFLAGS)

GIWS_WRAPPERS = src/jni/CommandHistory.giws.xml
SWIG_WRAPPERS = 

BUILT_SOURCES=
if GIWS
BUILT_SOURCES+=giws
endif
if SWIG
BUILT_SOURCES+=swig
endif


#### history_browser : gateway declaration ####
libscihistory_browser_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libscihistory_browser_la_sci_gateway_DATA = sci_gateway/history_browser_gateway.xml

if GUI
USEANT=1
endif

include $(top_srcdir)/Makefile.incl.am
