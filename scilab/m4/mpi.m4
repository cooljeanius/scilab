dnl#
dnl# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
dnl# Copyright (C) INRIA - 2007 - Sylvestre Ledru
dnl# 
dnl# This file must be used under the terms of the CeCILL.
dnl# This source file is licensed as described in the file COPYING, which
dnl# you should have received as part of this distribution.  The terms
dnl# are also available at    
dnl# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
dnl#
dnl# Detection of openmpi
dnl# When we check :
dnl# * if the path is provided or that we have to find it ourself
dnl# * if it is available
dnl# * what are the compilation flags 
dnl# * what are linking flags
AC_DEFUN([AC_OPENMPI],[
if test "$with_openmpi" != 'yes' -a "$with_openmpi" != 'no'; then
   # Look if mpicc (which provides cflags and ldflags) is available
   AC_MSG_CHECKING([openmpi, for mpicc])
   OPENMPI_FOUND=0
   MPICC="${with_openmpi}/bin/mpicc" 
        if test -x "$MPICC"; then
                AC_MSG_RESULT([$MPICC])
		OPENMPI_CC=$MPICC
		OPENMPI_FOUND=1
	fi
   if test $OPENMPI_FOUND -eq 0; then
        MPICC="$with_openmpi/mpicc" 
        if test -x "$MPICC"; then
                OPENMPI_FOUND=1
                OPENMPI_CC=$MPICC
                AC_MSG_RESULT([$MPICC])
        fi
   fi
   if test $OPENMPI_FOUND -eq 0; then
      AC_MSG_ERROR([Unable to find $MPICC. Please check the path you provided])
   else
      unset OPENMPI_FOUND
   fi
else
   AC_CHECK_PROGS([OPENMPI_CC],[mpicc],[no])
   if test "x$MPICC" = "xno"; then
      AC_MSG_ERROR([Unable to find mpicc in the path. Please check your installation of openmpi (example : openmpi & openmpi-dev with Debian)])
   fi
fi
saved_cflags=$CFLAGS
saved_LIBS="$LIBS"
AC_CHECK_HEADER([mpi.h],
	[],
	[AC_MSG_ERROR([Cannot find headers of the library OpenMPI. Please install the dev package (Debian : openmpi-dev)])])dnl

AC_CHECK_LIB([mpi],[MPI_Init],
             [OPENMPI_LIBS="-lmpi"],
             [AC_MSG_ERROR([openmpi : library missing. (Cannot find symbol MPI_Init in -lmpi). Check if OpenMPI is installed])])dnl

if test "x$OPENMPI_CPPFLAGS" = "x"; then
	OPENMPI_CPPFLAGS="-Wp,-I${openmpi_dir}/include"
fi
if test "x$OPENMPI_LDFLAGS" = "x"; then
	OPENMPI_LDFLAGS="-L${openmpi_dir}/lib/"
fi

if test "x$OPENMPI_HEADER" = "x"; then
	OPENMPI_HEADER="${openmpi_dir}/include/mpi.h"
fi
if test "x$OPENMPI_DIR" = "x"; then
	OPENMPI_DIR="$openmpi_dir"
fi

LIBS="$saved_LIBS"
CFLAGS=$saved_cflags

AC_SUBST([OPENMPI_FLAGS])dnl
AC_SUBST([OPENMPI_LIBS])dnl

CFLAGS="$CFLAGS $OPENMPI_FLAGS"

AC_REQUIRE([AC_LIBXML2])
AC_CHECK_LIB([xml2],[xmlInitParserCtxt],[],
             [AC_MSG_ERROR([libxml2 : library missing])])dnl

AC_REQUIRE([AC_PCRE])
AC_CHECK_HEADERS([pcre/tree.h],[],
                 [AC_MSG_ERROR([pcre : library missing missing])])dnl	

# Gets compilation and library flags
])dnl
