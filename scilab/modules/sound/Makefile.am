# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2006 - INRIA - Sylvestre Ledru <sylvestre.ledru@inria.fr>
# 
# This file is distributed under the same license as the Scilab package.


GATEWAY_C_SOURCES = sci_gateway/c/gw_sound.c \
sci_gateway/c/sci_beep.c \
sci_gateway/c/sci_PlaySound.c

libscisound_la_CPPFLAGS= -Wp,-I$(srcdir)/includes/ \
			 -Wp,-I$(srcdir)/src/c/ \
			 -Wp,-I$(top_srcdir)/libs/MALLOC/includes/ \
			 -Wp,-I$(top_srcdir)/modules/output_stream/includes/ \
			 -Wp,-I$(top_srcdir)/modules/api_scilab/includes/ \
			 -Wp,-I$(top_srcdir)/modules/localization/includes/ \
			 -Wp,-I$(top_srcdir)/modules/fileio/includes/ \
			 $(AM_CPPFLAGS)

pkglib_LTLIBRARIES = libscisound.la


libscisound_la_SOURCES = $(GATEWAY_C_SOURCES)

# For the code check (splint)
CHECK_SRC= $(libscisound_la_SOURCES)
INCLUDE_FLAGS = $(libscisound_la_CPPFLAGS)


#### Target ######
modulename=sound


#### sound : Conf files ####
libscisound_la_rootdir = $(mydatadir)
libscisound_la_root_DATA =  license.txt 


####�sound : init scripts ####
libscisound_la_etcdir = $(mydatadir)/etc
libscisound_la_etc_DATA = etc/sound.quit etc/sound.start

####�sound : gateway declaration ####
libscisound_la_sci_gatewaydir = $(mydatadir)/sci_gateway
libscisound_la_sci_gateway_DATA = sci_gateway/sound_gateway.xml

####�sound : include files ####
libscisound_la_includedir=$(pkgincludedir)

include $(top_srcdir)/Makefile.incl.am
