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
	  if test -e $${mydir}/Makefile; then \
	    if test ! -e $${mydir}/stamp-splint -o ! -e $${mydir}/stamp-clang -o $${mydir}/stamp-splint -ot $${mydir}/Makefile -o $${mydir}/stamp-clang -ot $${mydir}/Makefile; then \
	      $(MAKE) -S -C $${mydir} check-code; \
	    else \
	      echo "Already checked code in $${mydir}"; \
	    fi; \
	  else \
	    echo "Cannot check code in $${mydir} without a Makefile"; \
	  fi; \
	done

.PHONY: check-local check-code
