# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2008 - INRIA - Sylvestre Ledru <sylvestre.ledru@inria.fr>
#
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

#### Target ######
modulename=scicos
DISABLE_HELP_CLEAN=yes

libsciscicos_la_LDFLAGS = $(RT_LIB) $(AM_LDFLAGS)


include $(top_srcdir)/Makefile.incl.am

# Build modelica stuff
include $(srcdir)/Makefile.modelica.am


if XCOS
# Code not factorized with the one on the bottom since sundials must be
# compiled first
pkglib_LTLIBRARIES = libscisundials.la libsciscicos.la
noinst_LTLIBRARIES = libsciscicos-algo.la

SCICOS_C_SOURCES = src/c/tree.c \
src/c/scicos_malloc.c \
src/c/import.c \
src/c/slider.c \
src/c/scicos.c \
src/c/scicos_free.c \
src/c/sciblk2.c \
src/c/scicosclip.c \
src/c/sciblk4.c \
src/c/ezxml.c \
src/c/il_state.c \
src/c/il_sim.c \
src/c/createblklist.c \
src/c/var2sci.c \
src/c/copyvarfromlistentry.c \
src/c/MlistGetFieldNumber.c \
src/c/extractblklist.c

SCICOS_FORTRAN_SOURCES = src/fortran/scitovv.f \
src/fortran/vvtosci.f \
src/fortran/skipvars.f \
src/fortran/coselm.f \
src/fortran/scitod.f \
src/fortran/sctree.f \
src/fortran/scierr.f \
src/fortran/ftree2.f \
src/fortran/ftree3.f \
src/fortran/list2vars.f \
src/fortran/ftree4.f \
src/fortran/scitoi.f \
src/fortran/scifunc.f

GATEWAY_C_SOURCES = sci_gateway/c/gw_scicos.c \
sci_gateway/c/sci_buildouttb.c \
sci_gateway/c/sci_callblk.c \
sci_gateway/c/sci_coserror.c \
sci_gateway/c/sci_ctree2.c \
sci_gateway/c/sci_ctree3.c \
sci_gateway/c/sci_ctree4.c \
sci_gateway/c/sci_curblock.c \
sci_gateway/c/sci_curblockc.c \
sci_gateway/c/sci_data2sig.c \
sci_gateway/c/sci_diffobjs.c \
sci_gateway/c/sci_duplicate.c \
sci_gateway/c/sci_end_scicosim.c \
sci_gateway/c/sci_ftree2.c \
sci_gateway/c/sci_ftree3.c \
sci_gateway/c/sci_ftree4.c \
sci_gateway/c/sci_getblocklabel.c \
sci_gateway/c/sci_getscicosvars.c \
sci_gateway/c/sci_haltscicos.c \
sci_gateway/c/sci_loadScicos.c \
sci_gateway/c/sci_model2blk.c \
sci_gateway/c/sci_phase_simulation.c \
sci_gateway/c/sci_pointer_xproperty.c \
sci_gateway/c/sci_scicos_debug.c \
sci_gateway/c/sci_scicos_debug_count.c \
sci_gateway/c/sci_scicosim.c \
sci_gateway/c/sci_scicos_time.c \
sci_gateway/c/sci_sctree.c \
sci_gateway/c/sci_set_blockerror.c \
sci_gateway/c/sci_set_xproperty.c \
sci_gateway/c/sci_sig2data.c \
sci_gateway/c/sci_var2vec.c \
sci_gateway/c/sci_vec2var.c


GATEWAY_FORTRAN_SOURCES = sci_gateway/fortran/sci_f_ctree.f \
sci_gateway/fortran/sci_f_curblock.f \
sci_gateway/fortran/sci_f_debug_count.f \
sci_gateway/fortran/sci_f_getblocklabel.f \
sci_gateway/fortran/sci_f_scicos_debug.f \
sci_gateway/fortran/sci_f_tree2.f \
sci_gateway/fortran/sci_f_tree3.f \
sci_gateway/fortran/sci_f_tree4.f \
sci_gateway/fortran/sci_f_var2vec.f \
sci_gateway/fortran/sci_f_vec2var.f

#CLEANFILES=includes/blocks.h build/Cblocknames build/Fblocknames

libsciscicos_la_CPPFLAGS= -Wp,-I$(srcdir)/includes/ \
-Wp,-I$(srcdir)/src/c/ \
-Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
-Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
-Wp,-I$(top_srcdir)/libs/doublylinkedlist/includes/ \
-Wp,-I$(top_srcdir)/modules/graphics/includes/ \
-Wp,-I$(top_srcdir)/modules/dynamic_link/includes/ \
-Wp,-I$(top_srcdir)/modules/string/includes/ \
-Wp,-I$(top_srcdir)/modules/localization/includes/ \
-Wp,-I$(top_srcdir)/modules/intersci/includes/ \
-Wp,-I$(top_srcdir)/modules/scicos_blocks/includes/ \
-Wp,-I$(top_srcdir)/modules/action_binding/includes/ \
-Wp,-I$(top_srcdir)/modules/time/includes/ \
-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/core/includes/ \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/ \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/sundials/ \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/ida/ \
$(AM_CPPFLAGS)

## Need to put this include in FFLAGS too, because fortran is different:
libsciscicos_la_FFLAGS= -I$(top_srcdir)/modules/core/includes/

libsciscicos_algo_la_SOURCES = $(SCICOS_C_SOURCES) $(SCICOS_FORTRAN_SOURCES)
libsciscicos_la_SOURCES = $(GATEWAY_C_SOURCES) $(GATEWAY_FORTRAN_SOURCES)
libsciscicos_algo_la_CPPFLAGS = $(libsciscicos_la_CPPFLAGS)
libsciscicos_algo_la_FFLAGS = $(libsciscicos_la_FFLAGS)

# For the code check (splint)
CHECK_SRC= $(SCICOS_C_SOURCES) $(GATEWAY_C_SOURCES)
INCLUDE_FLAGS = $(libsciscicos_la_CPPFLAGS)
LOCAL_SPLINT_OPTIONS = -redef

libsciscicos_la_LIBADD = libsciscicos-algo.la libscisundials.la \
	$(top_builddir)/modules/scicos_blocks/libsciscicos_blocks.la 

if GUI
libsciscicos_la_LIBADD += $(top_builddir)/modules/graphics/libscigraphics.la 
endif

#### scicos : Conf files ####
libsciscicos_la_rootdir = $(mydatadir)
libsciscicos_la_root_DATA =  license.txt


#### scicos : init scripts ####
libsciscicos_la_etcdir = $(mydatadir)/etc
libsciscicos_la_etc_DATA = etc/scicos.quit etc/scicos.start

#### scicos : gateway declaration ####
libsciscicos_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libsciscicos_la_sci_gateway_DATA = sci_gateway/scicos_gateway.xml


#### scicos : include files ####
libsciscicos_la_includedir=$(pkgincludedir)/
libsciscicos_la_include_HEADERS = includes/scicos.h \
includes/scicos-def.h \
includes/scicos_free.h \
includes/scicos_malloc.h \
includes/scicos_math.h \
includes/dynlib_scicos.h \
includes/import.h



#### scicos : cosf files ####
libsciscicos_la_cosfdir=$(mydatadir)
nobase_libsciscicos_la_cosf_DATA = palettes/Branching.cosf \
palettes/DemoBlocks.cosf \
palettes/Events.cosf \
palettes/Integer.cosf \
palettes/Linear.cosf \
palettes/Lookup_Tables.cosf \
palettes/Matrix.cosf \
palettes/Modelica.cosf \
palettes/Non_linear.cosf \
palettes/OldBlocks.cosf \
palettes/Others.cosf \
palettes/Sinks.cosf \
palettes/Sources.cosf \
palettes/Threshold.cosf

#### scicos : MACROS ####
MACROSDIRSEXT= macros/scicos_auto \
macros/scicos_scicos \
macros/scicos_utils


#### scicos : SUNDIALS STUFF ####
SUNDIALS_SOURCES = src/scicos_sundials/src/cvode/cvode.c \
src/scicos_sundials/src/cvode/cvode_dense.c \
src/scicos_sundials/src/cvode/cvode_io.c \
src/scicos_sundials/src/ida/ida.c \
src/scicos_sundials/src/ida/ida_dense.c \
src/scicos_sundials/src/ida/ida_ic.c \
src/scicos_sundials/src/ida/ida_io.c \
src/scicos_sundials/src/kinsol/kinsol.c \
src/scicos_sundials/src/kinsol/kinsol_dense.c \
src/scicos_sundials/src/kinsol/kinsol_io.c \
src/scicos_sundials/src/nvec_ser/nvector_serial.c \
src/scicos_sundials/src/sundials/sundials_dense.c \
src/scicos_sundials/src/sundials/sundials_math.c \
src/scicos_sundials/src/sundials/sundials_nvector.c \
src/scicos_sundials/src/sundials/sundials_smalldense.c \
src/scicos_sundials/src/sundials/sundials_extension.c

libscisundials_la_CPPFLAGS = -Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/cvode \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/ida \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/kinsol \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/nvec_ser \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/include/sundials \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/cvode \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/ida \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/kinsol \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/nvec_ser \
-Wp,-I$(top_srcdir)/modules/scicos/src/scicos_sundials/src/sundials \
$(AM_CPPFLAGS)


libscisundials_la_SOURCES = $(SUNDIALS_SOURCES)

else

pkglib_LTLIBRARIES = libsciscicos.la
NO_SCICOS_C_SOURCES = src/c/noscicos/noscicos.c

libsciscicos_la_SOURCES = $(NO_SCICOS_C_SOURCES)

libsciscicos_la_CPPFLAGS= -Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
-Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
-Wp,-I$(top_srcdir)/modules/scicos/includes/ \
$(AM_CPPFLAGS)

#### scicos : init scripts ####
libsciscicos_la_etcdir = $(mydatadir)/etc
libsciscicos_la_etc_DATA = etc/scicos.quit etc/scicos.start

endif

.NOTPARALLEL: libscisundials.la libsciscicos.la

