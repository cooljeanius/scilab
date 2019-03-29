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
	set -e; for mydir in $(SUBDIRS); do \
	  if test -e $${mydir}/Makefile -a ! -e $${mydir}/stamp-splint; then \
	    $(MAKE) -S -C $${mydir} check-code; \
	  else \
	    echo "Skipping checking code in $${mydir}"; \
	  fi; \
	done

.PHONY: check-local check-code
