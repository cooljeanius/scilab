# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2007 - INRIA - Sylvestre LEDRU
#
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

if GUI
#List of the c files
COMPLETION_JNI_SOURCES = src/jni/Completion_wrap.c
USEANT=1

endif

# List of the c files
COMPLETION_C_SOURCES = src/c/completion.c \
src/c/completion_generic.c \
src/c/getfilesdictionary.c \
src/c/getmacrosdictionary.c \
src/c/getfieldsdictionary.c \
src/c/toolsdictionary.c \
src/c/completion_wrap_java.c \
src/c/getPartLine.c \
src/c/getCommonPart.c \
src/c/completeLine.c \
src/c/completeLine_wrap_java.c

COMPLETION_CXX_SOURCES = src/cpp/FieldsManager.cpp \
                         src/cpp/XMLFieldsGetter.cpp \
                         src/cpp/getfields.cpp

# List of the gateway c files
GATEWAY_C_SOURCES = sci_gateway/c/sci_completion.c \
sci_gateway/c/gw_completion.c

# Includes need for the compilation
libscicompletion_la_CPPFLAGS = -I$(srcdir)/includes/ \
    -Wp,-I$(srcdir)/src/c/ \
    -Wp,-I$(srcdir)/src/cpp/ \
    -Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
    -Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
    -Wp,-I$(top_srcdir)/modules/functions/includes/ \
    -Wp,-I$(top_srcdir)/modules/localization/includes/ \
    -Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
    -Wp,-I$(top_srcdir)/modules/graphics/includes/ \
    -Wp,-I$(top_srcdir)/modules/fileio/includes/ \
    -Wp,-I$(top_srcdir)/modules/xml/includes/ \
    -Wp,-I$(top_srcdir)/modules/xml/src/cpp \
    $(JAVA_JNI_INCLUDE) \
    $(XML_FLAGS) \
    $(COMPLETION_FLAGS) \
    $(AM_CPPFLAGS)

# Name of the future library (.la will be replace by .so, .a, etc regarding
# the system)
pkglib_LTLIBRARIES = libscicompletion.la
noinst_LTLIBRARIES = libscicompletion-algo.la


# All the sources needed by libscicompletion.la
libscicompletion_algo_la_SOURCES = $(COMPLETION_JNI_SOURCES) $(COMPLETION_C_SOURCES) $(COMPLETION_CXX_SOURCES)
libscicompletion_la_SOURCES = $(GATEWAY_C_SOURCES)
libscicompletion_algo_la_CPPFLAGS = $(libscicompletion_la_CPPFLAGS)

# For the code check (splint)
CHECK_SRC= $(COMPLETION_C_SOURCES) $(GATEWAY_C_SOURCES)
INCLUDE_FLAGS = $(libscicompletion_la_CPPFLAGS)

## Libraries necessary
libscicompletion_la_LIBADD = libscicompletion-algo.la

#### Name of the module and the path ######
modulename=completion

#### completion : Conf files ####
libscicompletion_la_rootdir = $(mydatadir)
libscicompletion_la_root_DATA =  license.txt

#### completion : init scripts ####
libscicompletion_la_etcdir = $(mydatadir)/etc
libscicompletion_la_etc_DATA = etc/completion.quit etc/completion.start

#### completion : gateway declaration ####
libscicompletion_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libscicompletion_la_sci_gateway_DATA = sci_gateway/completion_gateway.xml

#### completion : include files ####
libscicompletion_la_includedir=$(pkgincludedir)
libscicompletion_la_include_HEADERS = includes/gw_completion.h \
includes/completion.h \
includes/getCommonPart.h \
includes/getPartLine.h \
includes/dynlib_completion.h \
includes/completeLine.h

#### completion : test file ####
libscicompletion_la_testutilitiesdir = $(mydatadir)/tests/utilities
libscicompletion_la_testutilities_DATA = tests/utilities/build_primitives.sce \
tests/utilities/sci_completeline.c \
tests/utilities/sci_getcommonpart.c \
tests/utilities/sci_getfields.c \
tests/utilities/sci_getfilepartlevel.c \
tests/utilities/sci_getpartlevel.c

#### SWIG Declaration ####
SWIG_WRAPPERS = src/jni/Completion.i

if SWIG
BUILT_SOURCES=swig
endif


# Provides macros compilation, Java compilation, cleaning
# If you want Makefile to call ant, added USEANT=1


include $(top_srcdir)/Makefile.incl.am
