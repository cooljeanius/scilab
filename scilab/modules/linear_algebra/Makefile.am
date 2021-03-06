# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2006 - INRIA - Sylvestre LEDRU
#
# This file is distributed under the same license as the Scilab package.


LINEAR_ALGEBRA_C_SOURCES = src/c/schurtable.c \
src/c/issymmetric.c

LINEAR_ALGEBRA_FORTRAN_SOURCES = src/fortran/intdggbal.f \
src/fortran/intzgeqpf4.f \
src/fortran/intzgehrd.f \
src/fortran/intzgesvd1.f \
src/fortran/intzfschur.f \
src/fortran/intzgesvd2.f \
src/fortran/intdgges.f \
src/fortran/intgschur.f \
src/fortran/intdgesv3.f \
src/fortran/intdgesv4.f \
src/fortran/DGELSY1.f \
src/fortran/intozgschur.f \
src/fortran/intdpotrf.f \
src/fortran/intdoldsvd.f \
src/fortran/intdgecon.f \
src/fortran/zoldqr.f \
src/fortran/intzgetrf.f \
src/fortran/intoschur.f \
src/fortran/complexify.f \
src/fortran/intzgebal.f \
src/fortran/intzgetri.f \
src/fortran/intzggbal.f \
src/fortran/intdgees0.f \
src/fortran/intdgees1.f \
src/fortran/intogschur.f \
src/fortran/intzgges.f \
src/fortran/intddet.f \
src/fortran/intzgesv3.f \
src/fortran/intzgesv4.f \
src/fortran/intzpotrf.f \
src/fortran/intzgecon.f \
src/fortran/intzgschur.f \
src/fortran/intzoldsvd.f \
src/fortran/intdgelsy.f \
src/fortran/intdgeqpf3.f \
src/fortran/intfschur.f \
src/fortran/intdgeqpf4.f \
src/fortran/intdgesvd1.f \
src/fortran/intdgehrd.f \
src/fortran/intzgees0.f \
src/fortran/intdgesvd2.f \
src/fortran/intzgees1.f \
src/fortran/intzdet.f \
src/fortran/doldqr.f \
src/fortran/scischur.f \
src/fortran/intdgetrf.f \
src/fortran/intzgelsy.f \
src/fortran/intdgetri.f \
src/fortran/intdgebal.f \
src/fortran/intzschur.f \
src/fortran/intzgeqpf3.f \
src/fortran/writebuf.f
#src/fortran/issymmetric.f

GATEWAY_C_SOURCES = sci_gateway/c/sci_backslash.c \
sci_gateway/c/sci_hess.c \
sci_gateway/c/sci_rcond.c \
sci_gateway/c/sci_bdiag.c \
sci_gateway/c/sci_slash.c \
sci_gateway/c/gw_linear_algebra2.c \
sci_gateway/c/sci_det.c \
sci_gateway/c/sci_lu.c \
sci_gateway/c/sci_balanc.c \
sci_gateway/c/sci_qr.c \
sci_gateway/c/sci_schur.c \
sci_gateway/c/sci_chol.c \
sci_gateway/c/sci_eig.c \
sci_gateway/c/gw_linear_algebra.c \
sci_gateway/c/sci_inv.c \
sci_gateway/c/sci_svd.c \
sci_gateway/c/sci_lsq.c \
sci_gateway/c/assembleEigenvectors.c \
sci_gateway/c/sci_dgeev.c \
sci_gateway/c/sci_dggev.c \
sci_gateway/c/sci_dsyev.c \
sci_gateway/c/sci_zgeev.c \
sci_gateway/c/sci_zggev.c \
sci_gateway/c/sci_zheev.c

GATEWAY_FORTRAN_SOURCES =

libscilinear_algebra_la_CPPFLAGS = -Wp,-I$(srcdir)/includes/ \
-Wp,-I$(srcdir)/src/c/ \
-Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
-Wp,-I$(top_srcdir)/modules/core/includes/ \
-Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
-Wp,-I$(top_srcdir)/modules/dynamic_link/includes/ \
-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/elementary_functions/includes/ \
-Wp,-I$(top_srcdir)/modules/localization/includes/ \
$(AM_CPPFLAGS)

## Need to put this include in FFLAGS too, because fortran is different:
libscilinear_algebra_la_FFLAGS= -I$(top_srcdir)/modules/core/includes/

if MAINTAINER_MODE
pkglib_LTLIBRARIES = libscilinear_algebra.la
noinst_LTLIBRARIES = libscilinear_algebra-algo.la
else
noinst_LTLIBRARIES = libscilinear_algebra-algo.la libscilinear_algebra.la
endif



libscilinear_algebra_algo_la_SOURCES = $(LINEAR_ALGEBRA_FORTRAN_SOURCES) $(LINEAR_ALGEBRA_C_SOURCES)
libscilinear_algebra_la_SOURCES = $(GATEWAY_C_SOURCES) $(GATEWAY_FORTRAN_SOURCES)
libscilinear_algebra_algo_la_CPPFLAGS = $(libscilinear_algebra_la_CPPFLAGS)
libscilinear_algebra_algo_la_FFLAGS = $(libscilinear_algebra_la_FFLAGS)

# For the code check (splint)
CHECK_SRC= $(LINEAR_ALGEBRA_C_SOURCES) $(GATEWAY_C_SOURCES)
INCLUDE_FLAGS = $(libscilinear_algebra_la_CPPFLAGS)

libscilinear_algebra_la_LIBADD = libscilinear_algebra-algo.la

#### Target ######
modulename=linear_algebra


#### linear_algebra : Conf files ####
libscilinear_algebra_la_rootdir = $(mydatadir)
libscilinear_algebra_la_root_DATA =  license.txt


#### linear_algebra : init scripts ####
libscilinear_algebra_la_etcdir = $(mydatadir)/etc
libscilinear_algebra_la_etc_DATA = etc/linear_algebra.quit etc/linear_algebra.start
#### linear_algebra : gateway declaration ####
libscilinear_algebra_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libscilinear_algebra_la_sci_gateway_DATA = sci_gateway/linear_algebra_gateway.xml


include $(top_srcdir)/Makefile.incl.am
