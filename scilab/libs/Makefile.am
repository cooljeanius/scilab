# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) 2006 - INRIA - Sylvestre LEDRU
#
# This file is distributed under the same license as the Scilab package.

# The order DOES matter !!!
SUBDIRS = \
	MALLOC \
	hashtable \
	libst \
	dynamiclibrary \
	doublylinkedlist

check-local: check-code
check-code:
	for mydir in $(SUBDIRS); do \
	  $(MAKE) -C $${mydir} check-code; \
	done

.PHONY: check-local check-code
