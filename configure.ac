dnl#                                            -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Scilab],[5.4.0],[http://bugzilla.scilab.org/])
AC_CONFIG_AUX_DIR([scilab/config])dnl

# (just a simple wrapper to run the one in the true source directory)
AM_INIT_AUTOMAKE([foreign])
AM_MAINTAINER_MODE

AC_ARG_WITH([arpack-ng],
    [AS_HELP_STRING([--without-arpack-ng],
                    [Disable the interface to ARPACK-NG])])dnl

AC_ARG_WITH([umfpack],
    [AS_HELP_STRING([--without-umfpack],
                    [Disable the interface to the UMFPACK library])])dnl

AC_ARG_WITH([matio],
    [AS_HELP_STRING([--without-matio],
                    [Disable interface to Matio (MAT File I/O library)])])dnl

AC_ARG_ENABLE([build-help],
        [AS_HELP_STRING([--disable-build-help],[Disable the help build])
        ])dnl

# Output.
AC_CONFIG_FILES([Makefile])
AC_CONFIG_SUBDIRS([scilab])
AC_OUTPUT
