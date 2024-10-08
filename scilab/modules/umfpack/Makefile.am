# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2008 - INRIA - Sylvestre LEDRU <sylvestre.ledru@inria.fr>
# Copyright (C) 2008 - INRIA - Pierre MARECHAL <pierre.marechal@inria.fr>
#
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

modulename=umfpack

pkglib_LTLIBRARIES = libsciumfpack.la

if UMFPACK
noinst_LTLIBRARIES = libsciumfpack-algo.la
endif

libsciumfpack_la_LDFLAGS = $(AM_LDFLAGS)

#### umfpack : Conf files ####
libsciumfpack_la_rootdir = $(mydatadir)
libsciumfpack_la_root_DATA =  \
license.txt \
 \
 \
TAUCS_license.txt \
UMFPACK_license.txt

#### umfpack : init scripts ####
libsciumfpack_la_etcdir = $(mydatadir)/etc
libsciumfpack_la_etc_DATA = etc/umfpack.quit etc/umfpack.start

if UMFPACK

libsciumfpack_la_LDFLAGS += $(UMFPACK_LIB)
UMFPACK_C_SOURCES = src/c/taucs_scilab.c \
src/c/common_umfpack.c \
src/c/with_umfpack.c

GATEWAY_C_SOURCES =  sci_gateway/c/gw_umfpack.c \
sci_gateway/c/sci_res_with_prec.c \
sci_gateway/c/sci_taucs_chdel.c \
sci_gateway/c/sci_taucs_chfact.c \
sci_gateway/c/sci_taucs_chget.c \
sci_gateway/c/sci_taucs_chinfo.c \
sci_gateway/c/sci_taucs_chsolve.c \
sci_gateway/c/sci_umf_ludel.c \
sci_gateway/c/sci_umf_lufact.c \
sci_gateway/c/sci_umf_luget.c \
sci_gateway/c/sci_umf_luinfo.c \
sci_gateway/c/sci_umf_lusolve.c \
sci_gateway/c/sci_umfpack.c

#### umfpack : gateway declaration ####
libsciumfpack_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libsciumfpack_la_sci_gateway_DATA = sci_gateway/umfpack_gateway.xml

libsciumfpack_algo_la_SOURCES = $(UMFPACK_C_SOURCES)
libsciumfpack_la_SOURCES = $(GATEWAY_C_SOURCES)
libsciumfpack_algo_la_CPPFLAGS = $(libsciumfpack_la_CPPFLAGS)

# For the code check (splint)
CHECK_SRC= $(libsciumfpack_la_SOURCES)
INCLUDE_FLAGS = $(libsciumfpack_la_CPPFLAGS)

libsciumfpack_la_LIBADD =  libsciumfpack-algo.la

libsciumfpack_la_CPPFLAGS=-Wp,-I$(srcdir)/includes/ \
			  -Wp,-I$(srcdir)/src/c/ \
			  -Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
			  -Wp,-I$(top_srcdir)/libs/dynamiclibrary/includes/ \
			  -Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
			  -Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
			  -Wp,-I$(top_srcdir)/modules/localization/includes/ \
			  -Wp,-I$(top_srcdir)/modules/mexlib/includes/ \
			  $(AM_CPPFLAGS)

else

UMFPACK_C_SOURCES = src/noumfpack/noumfpack.c

libsciumfpack_la_SOURCES = $(UMFPACK_C_SOURCES)
libsciumfpack_la_CPPFLAGS= -Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/umfpack/includes/ \
-Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
-Wp,-I$(top_srcdir)/modules/localization/includes/ \
$(AM_CPPFLAGS)
endif

include $(top_srcdir)/Makefile.incl.am
