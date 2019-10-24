dnl# serial 1
dnl# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
dnl# Copyright (C) DIGITEO - 2009 - Bruno JOFRET
dnl# 
dnl# This file must be used under the terms of the CeCILL.
dnl# This source file is licensed as described in the file COPYING, which
dnl# you should have received as part of this distribution.  The terms
dnl# are also available at    
dnl# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
dnl#
dnl# libhdf5 is mandatory in Scilab 
dnl# When we check :
dnl# * if the path is provided or that we have to find it ourself
dnl# * if it is available
dnl# * what are the compilation flags 
dnl# * what are linking flags
AC_DEFUN([AC_HDF5],[

AC_ARG_WITH([hdf5_include],
        [AS_HELP_STRING([--with-hdf5-include=DIR],
                        [Set the path to the HDF5 headers])],
        [with_hdf5_include=${withval}],
        [with_hdf5_include='yes'])dnl

AC_ARG_WITH([hdf5_library],
        [AS_HELP_STRING([--with-hdf5-library=DIR],
                        [Set the path to the HDF5 libraries])],
        [with_hdf5_library=${withval}],
        [with_hdf5_library='yes'])dnl
        
if test "x${with_hdf5_include}" != "xyes"; then
    save_CFLAGS="${CFLAGS}"
    CFLAGS="-Wp,-I${with_hdf5_include}"
    AC_CHECK_HEADER([hdf5.h],
        [HDF5_CFLAGS="${CFLAGS}"],
        [AC_MSG_ERROR([Cannot find headers (hdf5.h) of the library HDF5 in ${with_hdf5_include}. Please install the dev package])])
    CFLAGS="${save_CFLAGS}"
else
    HDF5_CFLAGS=""
    AC_CHECK_HEADER([hdf5.h],
        [HDF5_CFLAGS=""],
        [AC_MSG_ERROR([Cannot find headers (hdf5.h) of the library HDF5. Please install the dev package])])
fi

AC_CHECK_TYPES([hid_t],[
  AC_CHECK_SIZEOF([hid_t])dnl
  AC_CHECK_ALIGNOF([hid_t])dnl
],[],[
#ifdef HAVE_HDF5_H
# include <hdf5.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for hid_t expects <hdf5.h> to be included"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_HDF5_H */
])dnl

save_LIBS="${LIBS}"

# --with-hdf5-library set then check in this dir
if test "x${with_hdf5_library}" != "xyes"; then
    HDF5_LIBS="-L${with_hdf5_library} -lhdf5"
    LIBS="${LIBS} ${HDF5_LIBS}"
    AC_CHECK_LIB([hdf5],[H5Fopen],
            [],
            [AC_MSG_WARN([the libhdf5 library is missing. We cannot find symbol H5Fopen in ${with_hdf5_library}. Check if libhdf5 is installed and if the version is correct. This should be a hard error but it hase been changed to a warning to facilitate configure script development.])])dnl
    ## (sorry about that)
else
    HDF5_LIBS="-lhdf5"
    LIBS="${LIBS} ${HDF5_LIBS}"
    AC_CHECK_LIB([hdf5],[H5Fopen],
            [],
            [AC_MSG_WARN([the libhdf5 library is missing. We cannot find the symbol H5Fopen. Check if libhdf5 is installed and if the version is correct. This should be a hard error but it hase been changed to a warning to facilitate configure script development.])])
fi

LIBS="${save_LIBS}"

AC_SUBST([HDF5_LIBS])dnl
AC_SUBST([HDF5_CFLAGS])dnl

AC_DEFINE([WITH_HDF5],[],[With the HDF5 library])dnl

# Gets compilation and library flags
])dnl
