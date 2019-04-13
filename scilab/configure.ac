dnl# configure.ac                                  -*- Autoconf -*-
#
# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
# Copyright (C) INRIA - 2006-2008 - Sylvestre Ledru
# Copyright (C) DIGITEO - 2009-2011 - Sylvestre Ledru
# Copyright (C) DIGITEO - 2009 - Pierre MARECHAL <pierre.marechal@scilab.org>
#
# This file must be used under the terms of the CeCILL.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution.  The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
#

dnl# Process this file with autoconf to produce a configure script.

AC_REVISION($Revision$)dnl
AC_INIT([Scilab],[5.4.0],[http://bugzilla.scilab.org/])
AC_PREREQ([2.69])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([contrib/toolbox_skeleton/sci_gateway/c/sci_csub.c])dnl

SCI_BUILDDIR="`pwd`"
SCI_SRCDIR="${srcdir}"
SCI_SRCDIR_FULL="`cd ${SCI_SRCDIR} && pwd`"

AC_SUBST([top_srcdir])   dnl# force-SUBST-ing this and the next variable
AC_SUBST([top_builddir]) dnl# are related to a bug that currently requires
                         dnl# using the --disable-dependency-tracking
                         dnl# flag in order to work around it
SCILAB_VERSION_MAJOR=5
SCILAB_VERSION_MINOR=4
SCILAB_VERSION_MAINTENANCE=0
AC_SUBST([SCILAB_VERSION_MAJOR])dnl
AC_SUBST([SCILAB_VERSION_MINOR])dnl
AC_SUBST([SCILAB_VERSION_MAINTENANCE])dnl

SCILAB_LIBRARY_VERSION=${SCILAB_VERSION_MAJOR}:${SCILAB_VERSION_MINOR}:${SCILAB_VERSION_MAINTENANCE}
AC_SUBST([SCILAB_LIBRARY_VERSION])dnl

SCILAB_BINARY_VERSION=${SCILAB_VERSION_MAJOR}.${SCILAB_VERSION_MINOR}.${SCILAB_VERSION_MAINTENANCE}
AC_SUBST([SCILAB_BINARY_VERSION])dnl

# shared library versioning
# GENERIC_LIBRARY_VERSION=1:2:0
#                         | | |
#                  +------+ | +---+
#                  |        |     |
#               current:revision:age
#                  |        |     |
#                  |        |     +- increment if interfaces have been added
#                  |        |        set to zero if interfaces have been
#                  |        |        removed or changed
#                  |        +- increment if source code has changed
#                  |           set to zero if current is incremented
#                  +- increment if interfaces have been added, removed or
#                     changed

# Check if we have a space in the path to the source tree
SPACE_IN_PATH=`echo "${SCI_SRCDIR_FULL}"|grep " " > /dev/null; echo $?`
if test "${SPACE_IN_PATH}" = "0"; then
   AC_MSG_WARN([=====================================])
   AC_MSG_WARN([Configure thinks that there is a space in the path to the source.])
   AC_MSG_WARN([This may cause problem with libtool and some other things...])
   AC_MSG_WARN([=====================================])
   sleep 180
fi

AC_CONFIG_AUX_DIR([config])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_HEADERS([modules/core/includes/machine.h])dnl

# Check system
AC_CANONICAL_TARGET
AC_OBJEXT
AC_EXEEXT
AC_USE_SYSTEM_EXTENSIONS

# strip executable and stuff
AM_PROG_INSTALL_STRIP
AC_PROG_LN_S

AC_CUSTOM_LARGE_FILE

# In order to be able to change the scilab directory
# See http://wiki.debian.org/RpathIssue
AC_RELOCATABLE
AC_RELOCATABLE_LIBRARY
AC_LIB_RPATH

# If configure detect that timestamp changed,
# it tries to rebuild configure & makefile which can be a painmaker
# if the version is different
AM_MAINTAINER_MODE

AB_INIT dnl# Gives extra info about the build (from m4/autobuild.m4)
CMAKE_FIND_BINARY dnl# Ionic says to use `cmake -v`... (from m4/cmake.m4)
AM_INIT_AUTOMAKE([1.11.6 dejagnu dist-zip dist-bzip2 -Wall gnits subdir-objects]) # Not using -Werror because we override {C,F}FLAGS in order to disable optimization
dnl# subdir-objects is required as of automake1.14

#################################
## all the --with-* argument help
#################################

AC_ARG_ENABLE([debug],
   [AS_HELP_STRING([--enable-debug],
                   [Do not optimize, and instead print warning messages (C/C++/Fortran/Java code)])])dnl

AC_ARG_ENABLE([debug-C],
   [AS_HELP_STRING([--enable-debug-C],
                   [Do not optimize, and instead print warning messages (C code)])])dnl

AC_ARG_ENABLE([debug-CXX],
   [AS_HELP_STRING([--enable-debug-CXX],
                   [Do not optimize, and instead print warning messages (C++ code)])])dnl

AC_ARG_ENABLE([debug-java],
   [AS_HELP_STRING([--enable-debug-java],
                   [Print warning messages and line numbers (Java code)])])dnl

AC_ARG_ENABLE([debug-fortran],
   [AS_HELP_STRING([--enable-debug-fortran],
                   [Do not optimize, and instead print warning messages (Fortran code)])])dnl

AC_ARG_ENABLE([debug-linker],
   [AS_HELP_STRING([--enable-debug-linker],
                   [Print warning messages from the linker (ld)])])dnl

AC_ARG_ENABLE([code-coverage],
   [AS_HELP_STRING([--enable-code-coverage],[Enable code coverage])])dnl

AC_ARG_ENABLE([stop-on-warning],
   [AS_HELP_STRING([--enable-stop-on-warning],
                   [Stop the compilation on the first warning found in the C/C++ code])])dnl

AC_ARG_WITH([gcc],
    [AS_HELP_STRING([--with-gcc],[Use gcc C compiler ])])dnl

AC_ARG_WITH([gfortran],
    [AS_HELP_STRING([--with-gfortran],
                    [Use gfortran, GNU Fortran 95 compiler])])dnl

AC_ARG_WITH([intelcompilers],
    [AS_HELP_STRING([--with-intelcompilers],
                    [Use Intel C (icc) and Fortran (ifort) proprietary compilers (GNU/Linux only) ])])dnl

AC_ARG_WITH([tk],
    [AS_HELP_STRING([--without-tk],[Disable the interface to Tcl/Tk ])])dnl

AC_ARG_WITH([javasci],
    [AS_HELP_STRING([--without-javasci],
                    [Disable the Java/Scilab interface (javasci)])])dnl

AC_ARG_ENABLE([compilation-tests],
    [AS_HELP_STRING([--enable-compilation-tests],
                    [Enable unitary tests and checks at compilation time])])dnl

AC_ARG_WITH([gui],
    [AS_HELP_STRING([--without-gui],
                    [Disable the Scilab Graphical User Interface (GUI). Intended for embedded/clustering/grid Scilab ])])dnl

AC_ARG_ENABLE([build-swig],
    [AS_HELP_STRING([--enable-build-swig],
                    [Regenerate Java => C wrappers produced by Swig (A Java Development Kit (JDK) is mandatory for this option)])])dnl

AC_ARG_ENABLE([build-giws],
    [AS_HELP_STRING([--enable-build-giws],
                    [Regenerate C/C++ => Java wrappers produced by Giws (A Java Development Kit (JDK) is mandatory for this option)])])dnl

################################################
########## compilator & misc programs detection
################################################

AM_PROG_AR dnl# automake1.14 warns if this macro is missing
AM_PROG_AS
dnl# All of the `test`s here are a hack to emulate the use
dnl# of AC_REQUIRE([]) outside of an AC_DEFUN([])
if test "x${AWK}" = "x"; then
	test -z "${AWK}"
	AC_PROG_AWK
else
	# Autoconf likes to remove AC_SUBSTs from conditions
	# so this test and the others like it are dummies
	# to make sure that the "else" condition does not
	# become empty
	test ! -z "${AWK}" && export AWK
	AC_SUBST([AWK])
fi
if test "x${CPP}" = "x"; then
	test -z "${CPP}"
	AC_PROG_CPP
else
	XORG_PROG_RAWCPP([]) dnl# from m4/xorg-macros.m4
fi
if test "x${GREP}" = "x"; then
	test -z "${GREP}"
	AC_PROG_GREP
else
	test ! -z "${GREP}" && export GREP
	AC_SUBST([GREP])
fi
if test "x${INSTALL}" = "x"; then
	test -z "${INSTALL}"
	AC_PROG_INSTALL
else
	test ! -z "${INSTALL}" && export INSTALL
	AC_SUBST([INSTALL])
fi
if test "x${MAKE}" = "x"; then
	test -z "${MAKE}"
	AC_PATH_PROGS([MAKE],[make gmake gnumake remake])
	AC_PROG_MAKE_SET
	if test "x${SILENT_RULES}" = "x"; then
		test -z "${SILENT_RULES}"
		AM_SILENT_RULES
	fi
else
	test ! -z "${MAKE}" && export MAKE
	AC_SUBST([MAKE])
fi
AC_BAKEFILE_GNUMAKE dnl# from m4/bakefile.m4
AX_CHECK_GNU_MAKE([]) dnl# from m4/ax_check_gnu_make.m4
AC_PROG_MKDIR_P
AC_PROG_OBJC
AC_PROG_OBJCPP
AM_PROG_LEX
AC_PROG_YACC

######
### Mac OS X set of macports path with provided
### This block used to be for Fink, but it has been switched for this fork
######

AC_ARG_WITH([macports_prefix],
[AS_HELP_STRING([--with-macports-prefix],
                [Provide a macports prefix. Default: /opt/local ])])
# Need MacosX Version to specify some path.                                  
case "${host_os}" in
     *Darwin* | *darwin*)
     	      AC_GET_MACOSX_VERSION dnl# from m4/macosx.m4
     ;;
esac

case "${host}" in
    *darwin*)
        if test -n "${with_macports_prefix}"; then
            # If with-macports-prefix is provided, use the provided path to
            # make sure that we will use it to detect dependencies
            # (for example, gfortran is not provided in Xcode. Therefore, we
            # use the one in macports)
            MACPORTS_PREFIX="${with_macports_prefix}"

            # Macports does not have an init.sh like Fink does, so we can
            # remove that part
        elif test -x "`which port`"; then
        	if test -L "`which port`"; then
        	    REAL_PORT=$(readlink `which port`)
        	    AC_MSG_WARN([`which port` is a symlink to ${REAL_PORT}.])
        	    export MACPORTS_PREFIX=$(dirname $(dirname ${REAL_PORT}))
        	    AC_MSG_NOTICE([Assuming MACPORTS_PREFIX is actually ${MACPORTS_PREFIX}.])
		else
        	    export MACPORTS_PREFIX=$(dirname $(dirname `which port`))
		fi
	else
		# default
		MACPORTS_PREFIX="/opt/local"
	fi

        # Append to the default flags on Apple machines
        CPPFLAGS="`echo \"${CPPFLAGS} -Wp,-I${MACPORTS_PREFIX}/include\" | uniq`"
        LDFLAGS="`echo \"${LDFLAGS} -L${MACPORTS_PREFIX}/lib\" | uniq`"
        ;;
esac

AC_ARG_WITH([min_macosx_version],
[AS_HELP_STRING([--with-min-macosx-version],
                [Force compilers to generate binaries compatible with MacOSX minimal version.])])
case "${host}" in
    *darwin*)
    dnl# FIXME: verify that we actually have a valid version number here:
    if test -n "${with_min_macosx_version}"; then
       MIN_MACOSX_VERSION=${with_min_macosx_version}
       # Append to the default flags on Apple machines
       ARCH_CFLAGS="-mmacosx-version-min=${MIN_MACOSX_VERSION}"
       ARCH_CXXFLAGS="-mmacosx-version-min=${MIN_MACOSX_VERSION}"
       ARCH_FFLAGS="-mmacosx-version-min=${MIN_MACOSX_VERSION}"
       ARCH_LDFLAGS="-mmacosx-version-min=${MIN_MACOSX_VERSION}"
       # We need this to be passed to all linker commands:
       LDFLAGS="${LDFLAGS} -mmacosx-version-min=${MIN_MACOSX_VERSION}"
       AC_DEFINE([MIN_MACOSX_VERSION],[${MIN_MACOSX_VERSION}],
             [Minimum MacOSX version with which binaries will be compatible.])
    fi
;;
esac

#####################################################
## Look for pkg-config
#####################################################
PKG_PROG_PKG_CONFIG dnl# from m4/pkg.m4

#####################################################
## check if options are correct (or not)
#####################################################

if test "x${with_intelcompilers}" = "xyes" -a "x${with_gcc}" = "xyes"; then
    AC_MSG_ERROR([Conflicting options: you specified two different compiler series (i.e. both Intel and gcc)])
fi

######## fortran ########

if test "x${with_gfortran}" = "xyes"; then
   AC_PROG_F77([gfortran])
   if test -z "${F77}"; then
     AC_MSG_ERROR([You asked me to use gfortran, but I have not been able to find it])
    fi
fi

if test "x${with_intelcompilers}" = "xyes"; then
   AC_PROG_F77([ifc ifort])
   if test -z "${F77}"; then
     AC_MSG_ERROR([You asked me to use ifc (intel fortran compiler), but I have not been able to find it])
    fi
fi

if test -z "${F77}"; then
   AC_MSG_NOTICE([No Fortran compiler specified; trying to find one (preferring gfortran and intel compilers)])
   AC_PROG_F77([gfortran ifc ifort])
   if test -z "${F77}"; then
        # Best effort to find a compiler (might be g77)
        AC_MSG_NOTICE([Still no Fortran compiler found; getting desperate now...])
	AC_PROG_F77
   fi
fi

# case statements were introduced in fortran 90 so we can use that
# as a test to see if our compiler is fortran 90 compatible.
f90compatible=false
if test -z "${F77}"; then
  AC_MSG_ERROR([No fortran compiler found. Cannot compile scilab without a fortran compiler])
fi

AC_MSG_CHECKING([if ${F77} is a fortran 90 compatible compiler])
 f90compatible=false
AC_LANG_PUSH([Fortran 77])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
      PROGRAM hello
        do 50 i = 1, 5
           select case ( i )
              case (1)
                 print*, "case is 1, i is ", i
              case ( 2 : 3 )
                 print*, "case is 2 to 3, i is ", i
              case default
                 print*, "default case, i is ", i
              end select
 50           continue
      END
    ]])],
    [AC_MSG_RESULT([yes])
     AC_DEFINE([G95_FORTRAN],[],[uses G95 fortran])
     f90compatible=true
    ],
    [AC_MSG_RESULT([no])])
AC_LANG_POP([Fortran 77])dnl

############ C ###############
if test "x${with_gcc}" = "xyes"; then
   AC_PROG_CC([gcc])
   if test -z "${CC}"; then
     AC_MSG_ERROR([You asked me to use gcc, but I have not been able to find it])
    fi
fi

if test "x${with_intelcompilers}" = "xyes"; then
   AC_PROG_CC([icc ecc])
   if test -z "${CC}"; then
     AC_MSG_ERROR([You asked me to use icc (intel C compiler), but I have not been able to find it])
    fi
fi

if test -z "${CC}"; then
   AC_MSG_NOTICE([No C compiler specified... relying on Autoconf to find the best])
   AC_PROG_CC
   XORG_COMPILER_BRAND dnl# from m4/xorg-macros.m4
fi

if test -z "${CC}"; then
  AC_MSG_ERROR([No C Compiler found. Cannot compile Scilab without a C compiler])
fi

AC_CHECK_SIZEOF([int])
AC_CHECK_ALIGNOF([int])
AC_CHECK_SIZEOF([void *])
AC_CHECK_ALIGNOF([void *])
AC_CHECK_SIZEOF([long])
AC_CHECK_ALIGNOF([long])dnl

### C++ ###
AC_PROG_CXX
if test "x${CXXCPP}" = "x"; then
	test -z "${CXXCPP}"
	AC_PROG_CXXCPP
else
	test ! -z "${CXXCPP}" && export CXXCPP
	AC_SUBST([CXXCPP])
fi
AC_PROG_OBJCXX
AC_PROG_OBJCXXCPP
dnl# we cannot just do something like
dnl# AC_CHECK_PROG([cxx_present],[${CXX}],["yes"],["no"])
dnl# because if the user has specified the full path of the desired C++
dnl# compiler, then AC_CHECK_PROG will fail. If AC_PROG_CXX fails to find a
dnl# c++ compiler, then it will set "CXX=g++", so instead just run
dnl# AC_CHECK_PROG in this special case.
case ${CXX} in
    g++)
        AC_CHECK_PROG([cxx_present],[${CXX}],[yes],[no])
        if test "x${cxx_present}" != "xyes"; then
            AC_MSG_ERROR([No C++ compiler found. Cannot compile scilab without a C++ compiler])
        fi
        ;;
esac

# testing for support for both "-c" and "-o" is for the "subdir-objects"
# automake option

if test "x${CC_C_O}" = "x"; then
	test -z "${CC_C_O}"
	AM_PROG_CC_C_O
else
	test ! -z "${CC_C_O}" && export CC_C_O
	AC_SUBST([CC_C_O])
fi
AC_PROG_CXX_C_O
AC_PROG_F77_C_O
AC_PROG_FC_C_O

# If this option is provided, enable the debug on C & C++
if test "x${enable_stop_on_warning}" = "xyes"; then
   AC_MSG_NOTICE([--enable-stop-on-warning implies --enable-debug-C and enable-debug-CXX])
   XORG_STRICT_OPTION dnl# from m4/xorg-macros.m4
   enable_debug_C=yes
   enable_debug_CXX=yes
fi

if test "x${enable_debug}" = "xyes"; then
   AC_MSG_NOTICE([--enable-debug implies the rest of the --enable-debug flags])
   XORG_MEMORY_CHECK_FLAGS dnl# from m4/xorg-macros.m4
   enable_debug_fortran=yes
   enable_debug_C=yes
   enable_debug_CXX=yes
   enable_debug_java=yes
   enable_debug_linker=yes
else
   enable_debug=no
fi

if test "x${enable_debug_fortran}" = "xyes"; then
   FFLAGS="`echo "${FFLAGS}"| sed -e 's|-O[0-9+]|-O0|'`"
else
   FFLAGS="-O3"
   enable_debug_fortran=no
fi

if test "x${enable_debug_C}" = "xyes"; then
   AC_MSG_NOTICE([hacking CFLAGS for --enable-debug-C])
   CFLAGS="`echo "${CFLAGS}"| sed -e 's|-O[0-9+]|-O0|'`"
   XORG_CWARNFLAGS dnl# from m4/xorg-macros.m4
else
   CFLAGS="-O2"
   enable_debug_C=no
fi

if test "x${enable_debug_CXX}" = "xyes"; then
   AC_MSG_NOTICE([hacking CXXFLAGS for --enable-debug-CXX])
   CXXFLAGS="`echo "${CXXFLAGS}"| sed -e 's|-O[0-9+]|-O0|'`"
   XORG_CXXWARNFLAGS dnl# from m4/xorg-macros.m4
else
   CXXFLAGS="-O2"
   enable_debug_CXX=no
fi

if test "x${enable_debug_java}" = "xyes"; then
   LOGGING_LEVEL="INFO"
else
   LOGGING_LEVEL="SEVERE"
fi
AC_SUBST([LOGGING_LEVEL])dnl

if test "x${prefix}" = "xNONE"; then
  prefix="${ac_default_prefix}"
fi

###############################
## get the version
###############################

SCIVERSION=`cat ${SCI_SRCDIR}/Version.incl | sed -e "s/SCIVERSION=//" `

#############################################
## Compilers and options according to machine
#############################################

######################
######## Set compilation options for intel C/Fortran compilers
######################

if test "x${with_intelcompilers}" = "xyes"; then
   SCI_INTEL_COMPILER([]) dnl# from m4/intel_compiler.m4
fi

########### FORTRAN ######################

######################
######## With gfortran ...
######################
if test -n "${F77}"; then
   case "${F77}" in
     gfortran* | */gfortran )
        AC_MSG_NOTICE([enabling gfortran-specific flags])
        ## With GNU Compiler enable the code coverage
        if test "x${enable_code_coverage}" = "xyes"; then
            CODE_COVERAGE_FFLAGS="-fprofile-arcs -ftest-coverage"
        fi
     ;;
     g77*)
        AC_MSG_ERROR([g77 is no longer supported. Please consider switching to gfortran.])
     ;;
   esac

   if test "x${enable_debug_fortran}" = "xyes"; then
    AC_LANG_PUSH([Fortran 77])
    dnl# FIXME: also add -Wimplicit-interface and -Wimplicit-procedure, but
    dnl# they are rather noisy:
    for flag in -g -Wall -Wextra -Wsurprising -Warray-temporaries -Wcharacter-truncation -Wconversion-extra -Wfrontend-loop-interchange -Wuse-without-only -Wrealloc-lhs -Wrealloc-lhs-all; do
        case " ${FFLAGS} " in
            *\ ${flag}\ *)
                # flag is already present
                ;;

            *)
                AC_MSG_CHECKING([if the Fortran compiler accepts ${flag}])
                ac_save_FFLAGS="${FFLAGS}"
                FFLAGS="${FFLAGS} ${flag}"
                AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
                    [AC_MSG_RESULT([yes])
                     DEBUG_FFLAGS="${flag}"
                    ],
                    [AC_MSG_RESULT([no])])
                ;;
        esac
    done
    AC_LANG_POP([Fortran 77])
   else
      DEBUG_FFLAGS="-DNDEBUG"
   fi
      case "${host}" in
         x86_64-*-linux*)
            ARCH_FFLAGS="-m64 -fPIC"
                    ;;
        # Dec Alpha OSF 4
        alpha*-dec-osf4.*)
          ARCH_FFLAGS="-fpe3"
        ;;
        alpha*-dec-osf*)
            ARCH_FFLAGS="-fpe3 -switch nosqrt_recip"
        ;;
        rs6000-*-*)
            ARCH_FFLAGS="-qcharlen=4096"
            ;;
        mips-*-ultrix*)
            ARCH_FFLAGS="-O0 -fpe1"
        ;;
          *-*-hpux9.*)
            ARCH_FFLAGS="+Obb1200 +E4 -Dhpux"
        ;;
          *-*-hpux10.*)
            if test "x${enable_debug_fortran}" = "xyes"; then
                ARCH_FFLAGS="+E4 +Z +DAportable -Dhpux"
            else
                ARCH_FFLAGS="+O2 +E4 +Z +DAportable -Dhpux"
            fi
            ;;
          *-*-hpux11.*)
           if test "x${enable_debug_fortran}" = "xyes"; then
              ARCH_FFLAGS=" +Z +DAportable -Dhpux"
             else
              ARCH_FFLAGS="+O2 +Z +DAportable -Dhpux"
           fi
           ARCH_LDFLAGS="-ldld -lnsl -lU77 -lm"
     ;;
      esac
fi

#########################
# setting parameters according to system types
#########################

case "${host}" in
    *-*-hpux9.*|*-*-hpux10.*|*-*-hpux11.*)
        HPUX=1
    ;;
    sparc-*)
        SPARC=1
    ;;
    mips-sgi-irix*)
      MIPS_SGI_IRIX=1
    ;;
     *-*-solaris*)
     SOLARIS=1
     ;;
    *darwin*)
      MACOSX=1
    ;;
esac

AM_CONDITIONAL([IS_MACOSX],[test -n "${MACOSX}"])
AM_CONDITIONAL([IS_HPUX],[test -n "${HPUX}"])
AM_CONDITIONAL([IS_SPARC],[test -n "${SPARC}"])
AM_CONDITIONAL([IS_SOLARIS],[test -n "${SOLARIS}"])
AM_CONDITIONAL([IS_MIPS_SGI_IRIX],[test -n "${MIPS_SGI_IRIX}"])dnl

############
## C++
############

if test -z "${CXX}"; then
  AC_MSG_ERROR([No C++ compiler found. Cannot compile scilab without a C++ compiler.])
fi

case "${CXX}" in
    g++-* | g++ | ccache*g++ | ccache*g++-* | */g++ )
        ## With GNU C++ Compiler

        AC_MSG_NOTICE([enabling g++-specific flags])dnl

        # enable the code coverage
        if test "x${enable_code_coverage}" = "xyes"; then
            CODE_COVERAGE_CXXFLAGS="-fprofile-arcs -ftest-coverage"
        fi

        if test "x${enable_debug_CXX}" = "xyes"; then
            DEBUG_CXXFLAGS="-pipe -Wshadow -Wpointer-arith -Wcast-align -Wreturn-type -Wswitch -Wtrigraphs -Wcomment -Wchar-subscripts -Wformat -Wparentheses -Wsign-compare -Wwrite-strings -Wunused -fno-strict-aliasing -Wextra -Wall -g3 -Wunsafe-loop-optimizations"
            case "$host" in
                *-linux-gnu )
                    # Only doing that under Linux
                    DEBUG_CXXFLAGS="${DEBUG_CXXFLAGS} -fdiagnostics-show-option -Werror=format-security"
                ;;
            esac
        else
            DEBUG_CXXFLAGS="-DNDEBUG"
        fi
        COMPILER_CXXFLAGS="-fno-stack-protector " # bug 3131
        COMPILER_LDFLAGS="-lstdc++"
    ;;

    clang-* | clang | clang++-* | clang++ | */clang | */clang++ )
        AC_MSG_NOTICE([enabling clang++-specific flags])
        # clang linker expect an explict declaration
        # until the http://libcxx.llvm.org/ release, we select the GNU one.
        COMPILER_LDFLAGS="-lstdc++"
        if test -n "${MACPORTS_PREFIX}" -a -d "${MACPORTS_PREFIX}"; then
          CHECK_COMPILER_ARG([C++],[-stdlib=macports-libstdc++],[CXXFLAGS],
                             [COMPILER_CXXLDFLAGS])
          AC_SUBST([COMPILER_CXXLDFLAGS])dnl
          ##TODO: use ${COMPILER_CXXLDFLAGS} somewhere
        fi
    ;;
esac

#### 64 bits detection
IS_64_BITS_CPU=false
case "${host}" in
         x86_64-*-linux-gnu | x86_64-linux-gnu | ia64-*-linux-gnu | alpha-*-linux-gnu | alpha-*-netbsd* | x86_64-*-netbsd* | sparc64-*-netbsd*)
                IS_64_BITS_CPU=true
    ;;
esac

##########"

AC_DEFUN([XORG_REQUIRE_COMPILER_FLAGS],[
  AC_REQUIRE([XORG_COMPILER_FLAGS])dnl# from m4/xorg-macros.m4
])dnl

case "${CC}" in
   gcc-* | gcc | ccache*gcc | ccache*gcc-* | */gcc )
   ## With GNU Compiler

   AC_MSG_NOTICE([enabling gcc-specific flags])dnl

   # enable the code coverage
   if test "x${enable_code_coverage}" = "xyes"; then
    CODE_COVERAGE_CFLAGS="-fprofile-arcs -ftest-coverage"
   fi

   if test "x${enable_debug_C}" = "xyes"; then
      DEBUG_CFLAGS="-pipe -Wformat -Wshadow -Wfloat-equal -Wpointer-arith -Wcast-align -Wmissing-prototypes -Wmissing-declarations  -Wstrict-prototypes  -Wmissing-noreturn -Wendif-labels -Wpointer-arith -Wwrite-strings -Winline -Wredundant-decls -Wall -Wchar-subscripts -Wextra -Wuninitialized -Wno-format-y2k -Wmissing-format-attribute -Wno-missing-field-initializers -fno-strict-aliasing -Wold-style-definition -g3 -Wunsafe-loop-optimizations"
      # used to be -O
      # -D_FORTIFY_SOURCE=2
      case "${host}" in
      *-linux-gnu )
      # Only doing that under Linux
        if test "x${enable_debug_linker}" = "xyes"; then
            LDFLAGS="$LDFLAGS -Wl,--warn-common,-x"
        fi
        DEBUG_CFLAGS="${DEBUG_CFLAGS} -fdiagnostics-show-option -Werror=format-security"
        ;;
      esac
      XORG_REQUIRE_COMPILER_FLAGS dnl# from above
      CHECK_COMPILER_ARG([C],[-Wc++-compat],[CFLAGS],[WCXX_COMPAT_CFLAGS])
      AC_SUBST([WCXX_COMPAT_CFLAGS])dnl
      ## only used conditionally
   else
      DEBUG_CFLAGS="-DNDEBUG"
   fi

   COMPILER_CFLAGS="-fno-stack-protector " # bug 3131
   # Explictly disable the as needed. It was disable by default but Ubuntu
   # activated it by default since release 11.04. See bug #8961.
   # Once all cyclic dependencies have been dropped, this line could be
   # removed.
   # Check if linker supports --as-needed and --no-as-needed options
   if ${LD} --help 2>/dev/null | grep no-as-needed > /dev/null; then
      COMPILER_LDFLAGS="${COMPILER_LDFLAGS} -Wl,--no-as-needed"
   fi

   case "${host}" in
     x86_64-*-linux-gnu | x86_64-linux-gnu)
        ARCH_CFLAGS="-m64"
     ;;
     alpha-*-linux-gnu)
        ARCH_CFLAGS="-mieee-with-inexact"
        ARCH_LDFLAGS="-mieee-with-inexact"
     ;;
     powerpc-*-linux-gnu)
        ARCH_CFLAGS="-D_GNU_SOURCE"
     ;;
     *-*-solaris*)
        ARCH_CFLAGS="-DSVR4 -DSYSV -Dsolaris"
     ;;
     *-*-freebsd*)
        ARCH_CFLAGS="-Dfreebsd"
        ARCH_LDFLAGS="-lm"
     ;;
     alpha-*-netbsd*)
        ARCH_CFLAGS="-Dnetbsd -mieee"
        ARCH_FFLAGS="-Dnetbsd -mieee"
     ;;
     *-*-netbsd*)
        ARCH_CFLAGS="-Dnetbsd"
     ;;
     *-*-darwin*)
        if test -x ${SW_VERS} -o -x "`which sw_vers`"; then 
          if test "`sw_vers -productVersion | cut -d\. -f2`" -lt "7"; then
            dnl# FIXME: this is the wrong way to go about checking for this
            dnl# linker flag; it should be based on linker version rather than
            dnl# OS version, since newer linkers can be installed on older
            dnl# systems, and older linkers can be installed on newer systems.
            ARCH_CFLAGS="${ARCH_CFLAGS} -Wl,-no_compact_linkedit"
            ARCH_CXXFLAGS="${ARCH_CXXFLAGS} -Wl,-no_compact_linkedit"
            ARCH_LDFLAGS="${ARCH_LDFLAGS} -Wl,-no_compact_linkedit"
            # We need this to be passed to all linker commands... except not
            # really because that can break further conftests
            LD_CLASSIC_FLAGS="${LD_CLASSIC_FLAGS} -no_compact_linkedit"
            AC_SUBST([LD_CLASSIC_FLAGS])
            AC_MSG_NOTICE([Adding -no_compact_linkedit to the linker flags for Darwin])
          else
            AC_MSG_NOTICE([Not using the -no_compact_linkedit linker flag on Lion and above])
          fi
        fi

        if test "x${enable_debug_linker}" = "xyes"; then
            dnl# FIXME: test these to ensure they work:
            LDFLAGS="${LDFLAGS} -Wl,-warn_compact_unwind -Wl,-warn_weak_exports -Wl,-warn_stabs -Wl,-warn_commons"
        fi

        QUIET_UNUSED_COMPILER_ARGS([C],[CFLAGS])
        QUIET_UNUSED_COMPILER_ARGS([C++],[CXXFLAGS])dnl

        case "${F77}" in
             gfortran-*|gfortran)
                 # Extract from gfortran -v the version it has been built for
                 MAC_DETECTED_ARCH="`${F77} -v 2>&1 | grep "Target:" | sed -e "s/Target: \([[a-z0-9A-Z_]]*\).*/\1/g"`"
                 QUIET_UNUSED_COMPILER_ARGS([Fortran 77],[FFLAGS])
             ;;
             *)
                 AC_MSG_WARN([gfortran not used. Could not detect the architecture. Switch to the default case: x86_64])
                 MAC_DETECTED_ARCH="x86_64"
             ;;
        esac
        CC="${CC} -arch ${MAC_DETECTED_ARCH}"
        CXX="${CXX} -arch ${MAC_DETECTED_ARCH}"
        ;;
   esac
   ;; # end of the gcc case on the ${CC}
   clang-* | clang | ccache*clang | ccache*clang-* | */clang )
        AC_MSG_NOTICE([enabling clang-specific flags])
        if test "x${enable_debug_C}" != "xyes"; then
             ARCH_CFLAGS="-DNDEBUG"
        fi
        QUIET_UNUSED_COMPILER_ARGS([C],[CFLAGS])
        QUIET_UNUSED_COMPILER_ARGS([C++],[CXXFLAGS])dnl

        case "${F77}" in
             gfortran-*|gfortran)
                 QUIET_UNUSED_COMPILER_ARGS([Fortran 77],[FFLAGS])
             ;;
             *)
             ;;
        esac
   ;; # end of the clang case on the ${CC}
   *)
        ## CC compiler (not GCC)
        AC_MSG_NOTICE([enabling flags for unknown C compiler])
        if test "x${enable_debug_C}" != "xyes"; then
             ARCH_CFLAGS="-DNDEBUG"
        fi

        case "${host}" in
        # Dec Alpha OSF 4
          alpha*-dec-osf4.*)
              ARCH_CFLAGS="-std -ieee_with_inexact"
              ARCH_LDFLAGS="-ieee_with_inexact"
              ;;
          alpha*-dec-osf*)
              ARCH_CFLAGS="-ieee_with_inexact"
              ARCH_LDFLAGS="-ieee_with_inexact"
              ;;
          rs6000-*-*) # IBM AIX RS 6000 (NO LONGER SUPPORTED)
            ARCH_CFLAGS="-Daix -DSYSV"
          ;;
          mips-sgi-irix*) # SGI
            ARCH_CFLAGS="-DSYSV -DSVR4"
          ;;
          *-*-hpux9.*)
            ARCH_CFLAGS="-DSYSV -Dhpux"
          ;;
          *-*-hpux10.*) # HP 10
            if test "x${enable_debug_C}" = "xyes"; then
              ARCH_CFLAGS="-DSYSV -Dhpux"
            else
              ARCH_CFLAGS="-DSYSV -Dhpux +Z +DAportable"
            fi
          ;;
          *-*-hpux11.*) # HP 11
            ARCH_CFLAGS="-DSYSV -Dhpux -Dhppa +Z +DAportable"
          ;;
          *-*-solaris*) # SUN SOLARIS
            ARCH_CFLAGS="-DSVR4 -DSYSV -Dsolaris -Wp,-I/usr/local/include/"
            ARCH_LDFLAGS="-L/usr/local/lib/"
          ;;
        esac
   ;; # end of not a gcc compiler
esac

# enable the code coverage
if test "x${enable_code_coverage}" = "xyes"; then
   AC_PATH_PROG([LCOV],[lcov])
   if test -z "${LCOV}"; then
        AC_MSG_ERROR([Cannot find lcov. Please install it (package lcov under Debian) or remove the option --enable-code-coverage])
   fi
   AC_PATH_PROG([GENHTML],[genhtml])
   if test -z "${GENHTML}"; then
        AC_MSG_ERROR([Cannot find genhtml. Please install it (package lcov under Debian) or remove the option --enable-code-coverage])
   fi
   CODE_COVERAGE_LDFLAGS="-coverage"
fi
AM_CONDITIONAL([CODE_COVERAGE],[test "x${enable_code_coverage}" = "xyes"])dnl

# flag for possible compilations in configure
SCILIBS_CFLAGS=''
SCILIBS_CXXFLAGS=''
SCILIBS_FFLAGS=''

if test $IS_64_BITS_CPU = true -o "$MACOSX" = "1"; then
   if test $f90compatible = false; then
      AC_MSG_ERROR([64 bits support needs a fortran 90 compiler (try --with-gfortran).])
   fi
   AC_DEFINE([USE_DYNAMIC_STACK],[],[If we are building a 64 bits version])
fi

AM_CONDITIONAL([IS_64_BITS_CPU],[test $IS_64_BITS_CPU = true])
AM_CONDITIONAL([USE_DYNAMIC_STACK],
               [test $IS_64_BITS_CPU = true -o "$MACOSX" = "1"])dnl

################
## SSE
## By default, for x86 CPU, enable the SSE.
## Note that it is already the case with 64 bits CPU
## (these extensions are enabled by default by gcc)
################

case "$host" in
     i*86-linux-gnu|i*86-*-linux-gnu)
        SSE_CFLAGS="-msse"
        SSE_FFLAGS="-msse"
        SSE_CXXFLAGS="-msse"
     ;;
esac

#######################
## test for underscores (name mangling issues between C and fortran)
#######################
AC_CHECK_UNDERSCORE_FORTRAN([]) dnl# from m4/fortran.m4

#################
## HDF5
#################

AC_HDF5([]) dnl# from m4/hdf5.m4
# The Java detection is done after in this file.

#################
## XCOS
#################

AC_ARG_WITH([xcos],
    [AS_HELP_STRING([--without-xcos],[Disable Xcos])])dnl

AC_ARG_WITH([modelica],
    [AS_HELP_STRING([--without-modelica],
                    [Disable the OCaml module (modelica)])])dnl

if test "x${with_gui}" = "xno"; then
   AC_MSG_WARN([GUI is disabled. Disabling then xcos])
   with_xcos=no
fi

XCOS_ENABLE=no

if test "x${with_xcos}" != "xno" -a "x${with_gui}" != "xno"; then
   AC_DEFINE([WITH_XCOS],[],[With XCOS])dnl

   save_LIBS="${LIBS}"

   AC_SEARCH_LIBS([clock_gettime],[rt c])
   AC_CHECK_LIB([rt],[clock_gettime],
              [RT_LIB="-lrt";
              AC_DEFINE([HAVE_CLOCK_GETTIME],[1],
                        [Whether clock_gettime is available])],
        [AC_MSG_WARN([librt: library missing (Cannot find symbol clock_gettime). Check if librt is installed (it is usually provided by the libc) and if the version is correct])])
   LIBS="${save_LIBS}"
   AC_SUBST([RT_LIB])dnl

   #################
   ## ocaml which is only called when using Xcos
   #################
   if test "x${with_modelica}" != "xno"; then
      AC_CHECK_PROG_OCAML([]) dnl# from m4/ocaml.m4
   else
      AC_MSG_NOTICE([modelica is disabled; skipping checks for ocaml])
   fi
   XCOS_ENABLE=yes
else
   AC_MSG_NOTICE([skipping xcos checks])
fi

AC_SUBST([XCOS_ENABLE])dnl

AM_CONDITIONAL([OCAML],
               [test "x${with_modelica}" != "xno" -a "x${OCAMLC}" != "xno" -a "x${OCAMLOPT}" != "xno"])
AM_CONDITIONAL([XCOS],[test "$XCOS_ENABLE" != no])dnl

###########################
## test for JAVA compiler
###########################
dnl# most of these macros come from either m4/java.m4
dnl# or m4/java-thirdparty.m4

if test "x${with_javasci}" != "xno" -o "x${with_gui}" != "xno" -o "x${enable_build_help}" != "xno"; then
     # See if --with-jdk command line argument is given
     # Try to detect the installed JVM, this could be controlled
     # by the above --with options
     AC_JAVA_WITH_JDK
     AC_JAVA_DETECT_JVM
     case "$ac_java_jvm_version" in
        1.6 | 1.7)
        ;;
        *)
            AC_MSG_ERROR([Wrong version of Java. Expected at least 1.6. Found ${ac_java_jvm_version}])
        ;;
     esac

   if test "x${ac_java_jvm_name}" = "xjdk"; then
        JAVA_HOME=${ac_java_jvm_dir}
        JAVA_VERSION=${ac_java_jvm_version}
        AC_JAVA_TOOLS
        AC_JAVA_JNI_INCLUDE
        JAVA_JNI_INCLUDE=${ac_java_jvm_jni_include_flags}

        case "$host_os" in
             *Darwin* | *darwin*)
               # Mac OS X does not link against the lib but uses -framework
               JAVA_JNI_LIBS="-Wl,-framework,JavaVM"
             ;;
             *)
               AC_JAVA_JNI_LIBS
               JAVA_JNI_LIBS=$ac_java_jvm_jni_lib_flags
               JAVA_JNI_LIBS_PRELOAD=$ac_java_jvm_ld_preload
             ;;
        esac

        AC_JAVA_CLASSPATH
        JAVA_CLASSPATH=$ac_java_classpath
        AC_JAVA_TOOLS
        AC_JAVA_ANT

        case "$host_os" in
             *Darwin* | *darwin*)
                  JAVA_HOME=""
             ;;
        esac

        if test "x${with_gui}" != "xno"; then
                if test "x${XCOS_ENABLE}" = "xyes"; then
                   # jgraphx
                   AC_JAVA_CHECK_PACKAGE([jgraphx],[com.mxgraph.model.mxCell],
                                         [Diagram design])
                   JGRAPHX=${PACKAGE_JAR_FILE}
                   AC_SUBST([JGRAPHX])dnl

                   AC_JAVA_CHECK_VERSION_PACKAGE([jgraphx],
                                         [import com.mxgraph.view.mxGraph;],
                                         [${JGRAPHX}],[1.8.0.0],
                                         [mxGraph.VERSION],[],[])
                fi

                # scirenderer
                AC_JAVA_CHECK_PACKAGE([scirenderer],
                                  [org.scilab.forge.scirenderer.PackageInfo],
                                  [Scilab Renderer])
                SCIRENDERER=${PACKAGE_JAR_FILE}
                AC_SUBST([SCIRENDERER])dnl

                AC_JAVA_CHECK_VERSION_PACKAGE([scirenderer],
                          [import org.scilab.forge.scirenderer.PackageInfo;],
                          [${SCIRENDERER}],[1.0.2],[PackageInfo.VERSION])dnl

               # Docking system
                AC_JAVA_CHECK_PACKAGE([flexdock],
                                      [org.flexdock.docking.DockingManager],
                                      [Scilab Gui])
                FLEXDOCK=${PACKAGE_JAR_FILE}
                AC_SUBST([FLEXDOCK])dnl

                AC_JAVA_CHECK_VERSION_PACKAGE([flexdock],
                                      [import org.flexdock.util.Utilities;],
                                      [${FLEXDOCK}],[1.2.0],
                                      [Utilities.VERSION])dnl

                # Swing look&feel implementations
                AC_JAVA_CHECK_PACKAGE([looks],
                                  [com.jgoodies.looks.common.MenuItemRenderer],
                                  [Scilab Gui - Look and feel],["yes"])
                LOOKS=${PACKAGE_JAR_FILE}

                # Named differently under ArchLinux or Fedora
                if test -z "$LOOKS"; then
                    AC_JAVA_CHECK_PACKAGE([jgoodies-looks],
                                  [com.jgoodies.looks.common.MenuItemRenderer],
                                  [Scilab Gui - Look and feel])
                    LOOKS=${PACKAGE_JAR_FILE}
                fi
                AC_SUBST([LOOKS])dnl

                #  Skin Look and Feel
                AC_JAVA_CHECK_PACKAGE([skinlf],
                                      [com.l2fprod.util.AccessUtils],
                                      [Scilab Gui - Skin Look and Feel])
                SKINLF=${PACKAGE_JAR_FILE}
                AC_SUBST([SKINLF])dnl

                # JOGL 2
                AC_JAVA_CHECK_PACKAGE([jogl2],
                                      [javax.media.opengl.glu.GLUnurbs],
                                      [Scilab 3D rendering - Version 2.0])
                JOGL2=${PACKAGE_JAR_FILE}
                AC_SUBST([JOGL2])dnl

                if test "$MACOSX" = 1; then
                   echo "Check of the presence of libjogl.jnilib and libjogl_awt.jnilib disabled under Mac OS X"
                else
                   LDFLAGS_save=$LDFLAGS
                   # Provide known paths where distribs/OS can store JNI libs
                   LDFLAGS="${LDFLAGS} -L/usr/lib/jni -L/usr/lib64/jni" # Debian
                   LDFLAGS="${LDFLAGS} -L/usr/lib/java -L/usr/lib64/java" # jpackage.org
                   LDFLAGS="${LDFLAGS} -L/usr/lib/jogl -L/usr/lib64/jogl" # RedHat
                   LDFLAGS="${LDFLAGS} -L${SCI_SRCDIR}/thirdparty -L${SCI_SRCDIR}/bin" # Scilab 3rdparties
                   AC_CHECK_LIB([jogl_desktop],[glTexParameterf],
                                [JOGL2_LIBS="-ljogl"],
                                [AC_MSG_WARN([Could not link against -ljogl_desktop. Will try against -ljogl2 -lGL])])
                   if test -z "$JOGL2_LIBS"; then # The previous test failed add more options to the LDFLAGS
                       # the space after "jogl" in the following line is on
                       # purpose to disable the cache
                          AC_CHECK_LIB([jogl_desktop ], [glTexParameterf],
                       [JOGL2_LIBS="-ljogl_desktop -lGL"],
                       [AC_MSG_ERROR(["libjogl: Library
missing (Cannot find symbol glTexParameterf). Check if libjogl - C/Java (JNI)
interface for JOGL2 - or libGL (OpenGL library) are installed and if the version is correct. Note that you might have to update etc/librarypath.xml to provide the actual path the the JNI libraries."])],
                       [-lGL])
                   fi

                   LDFLAGS=$LDFLAGS_save
                fi

                # JoGL Native <=> Java connector
                AC_JAVA_CHECK_PACKAGE([gluegen2-rt],
                                  [jogamp.common.os.MachineDescriptionRuntime],
                                  [Scilab 3D rendering])
                GLUEGEN2_RT=${PACKAGE_JAR_FILE}
                AC_SUBST([GLUEGEN2_RT])dnl

                if test "$MACOSX" = 1; then
                   echo "Check of the presence of libgluegen-rt.jnilib disabled under Mac OS X"
                else
                   LDFLAGS_save=$LDFLAGS
                   # Provide known paths where distribs/OS can store JNI libs
                   LDFLAGS="${LDFLAGS} -L/usr/lib/jni -L/usr/lib64/jni" # Debian
                   LDFLAGS="${LDFLAGS} -L/usr/lib/java -L/usr/lib64/java" # jpackage.org
                   LDFLAGS="${LDFLAGS} -L/usr/lib/gluegen -L/usr/lib64/gluegen" # RedHat
                   LDFLAGS="${LDFLAGS} -L${SCI_SRCDIR}/thirdparty -L${SCI_SRCDIR}/bin" # Scilab 3rdparties
                   symbol="Java_jogamp_common_jvm_JVMUtil_initialize"
                   AC_CHECK_LIB([gluegen2-rt],[${symbol}],
                                [GLUEGEN_RT_LIBS="-lgluegen-rt"],
                   [AC_MSG_ERROR([libgluegen2-rt: Library missing (Cannot find symbol $symbol). Check if libgluegen-rt - C/Java (JNI) interface for GLUEGEN2 - is installed and if the version is correct. Note that you might have to update etc/librarypath.xml to provide the actual path the the JNI libraries.])],
                   [-ldl])
                   LDFLAGS=$LDFLAGS_save
                fi

                # Jhall
                AC_JAVA_CHECK_PACKAGE([jhall],[javax.help.JHelp],
                                      [Scilab Help Browser],["yes"])
                JHALL=${PACKAGE_JAR_FILE}

                # Named differently under Mandriva or Fedora
                if test -z "$JHALL"; then
                    AC_JAVA_CHECK_PACKAGE([javahelp2],
                                          [javax.help.JHelp],
                                          [Scilab Help Browser])
                    JHALL=${PACKAGE_JAR_FILE}
                fi
                AC_SUBST([JHALL])dnl

                # Console API
                AC_JAVA_CHECK_PACKAGE([jrosetta-API],
                  [com.artenum.rosetta.interfaces.core.ConsoleConfiguration],
                  [JRosetta : Console API Artenum / Scilab],["yes"])
                JROSETTA_API=${PACKAGE_JAR_FILE}
		if test -z "$JROSETTA_API"; then
	                AC_JAVA_CHECK_PACKAGE([jrosetta-api],
                  [com.artenum.rosetta.interfaces.core.ConsoleConfiguration],
                                  [JRosetta : Console API Artenum / Scilab])
        	        JROSETTA_API=${PACKAGE_JAR_FILE}
		fi
                AC_SUBST([JROSETTA_API])dnl

                # Console Core
                AC_JAVA_CHECK_PACKAGE([jrosetta-engine],
                      [com.artenum.rosetta.core.action.AbstractConsoleAction],
                                  [JRosetta : Console Core Artenum / Scilab])
                JROSETTA_ENGINE=${PACKAGE_JAR_FILE}
                AC_SUBST([JROSETTA_ENGINE])
                AC_JAVA_CHECK_VERSION_PACKAGE([jrosetta-engine],
                      [import com.artenum.rosetta.util.ConfigurationBuilder;],
                      [${JROSETTA_ENGINE}],[1.0.4],
                      [ConfigurationBuilder.getVersion()])dnl

                # MathML rendering solution
                # Used in both graphic & help
                AC_JAVA_CHECK_PACKAGE([jeuclid-core],
                          [net.sourceforge.jeuclid.LayoutContext],
                          [MathML rendering solution (at least version 3.1.X)])
                JEUCLID_CORE=${PACKAGE_JAR_FILE}
                AC_SUBST([JEUCLID_CORE])dnl

                ################ Mandatory for graphic_export features #####
                # XML to PDF/other Translator
                AC_JAVA_CHECK_PACKAGE([fop],[org.apache.fop.pdf.PDFInfo],
                                      [XML to PDF Translator (fop)])
                FOP=${PACKAGE_JAR_FILE}
                if test "x${FOP}" = "x"; then
                	test -z "$FOP"
                	XORG_WITH_FOP dnl# from m4/xorg-macros.m4 (supplies the HAVE_FOP conditional)
                else
                	test ! -z "$FOP" && export FOP
                	HAVE_FOP=1
                	AC_SUBST([HAVE_FOP])
                fi
                AC_SUBST([FOP])dnl

                # xml.apache.org SVG Library (under mandriva for example)
                AC_JAVA_CHECK_PACKAGE([batik-all],
                                      [org.apache.batik.parser.Parser],
                                      [Apache SVG Library],["yes"])
                BATIK=${PACKAGE_JAR_FILE}

                if test -z "$BATIK"; then
                   # Other other distribs
                   AC_JAVA_CHECK_PACKAGE([batik],
                                         [org.apache.batik.parser.Parser],
                                         [Apache SVG Library])
                   BATIK=${PACKAGE_JAR_FILE}
                fi
                AC_SUBST([BATIK])
                AC_JAVA_CHECK_VERSION_PACKAGE([batik],
                                          [import org.apache.batik.Version;],
                                          [${BATIK}],[1.7],
                                          [Version.getVersion()])dnl

                # Commons I/O library
                AC_JAVA_CHECK_PACKAGE([commons-io],
                          [org.apache.commons.io.output.CountingOutputStream],
                          [Commons I/O library])
                COMMONS_IO=${PACKAGE_JAR_FILE}
                AC_SUBST([COMMONS_IO])dnl

                # XML graphics common
                AC_JAVA_CHECK_PACKAGE([xmlgraphics-commons],
                                      [org.apache.xmlgraphics.util.Service],
                                      [Commons graphics library])
                XMLGRAPHICS_COMMONS=${PACKAGE_JAR_FILE}
                AC_SUBST([XMLGRAPHICS_COMMONS])dnl

                # Avalon Framework (PDF)
                AC_JAVA_CHECK_PACKAGE([avalon-framework],
          [org.apache.avalon.framework.configuration.ConfigurationException],
                          [Common framework for Java server application])
                AVALON_FRAMEWORK=${PACKAGE_JAR_FILE}
                AC_SUBST([AVALON_FRAMEWORK])dnl

                # XML API EXT (conversion of a SVG => PNG)
                AC_JAVA_CHECK_PACKAGE([xml-apis-ext],
                                      [org.w3c.dom.svg.SVGDocument],
                                      [XML Commons external code],["yes"])
                XML_APIS_EXT=${PACKAGE_JAR_FILE}

                if test -z "$XML_APIS_EXT"; then
                    # Other other distribs (Ex: Fedora/Redhat)
                    AC_JAVA_CHECK_PACKAGE([xml-commons-apis-ext],
                                          [org.w3c.dom.svg.SVGDocument],
                                          [XML Commons external code])
                    XML_APIS_EXT=${PACKAGE_JAR_FILE}
                fi
                AC_SUBST([XML_APIS_EXT])dnl

                ############### END Mandatory for graphic_export features #####

                # Logging (flexdock dep)
                AC_JAVA_CHECK_PACKAGE([commons-logging],
                                      [org.apache.commons.logging.LogFactory],
                                      [Apache logging])
                COMMONS_LOGGING=${PACKAGE_JAR_FILE}
                AC_SUBST([COMMONS_LOGGING])dnl

                # JLaTeXMath
                AC_JAVA_CHECK_PACKAGE([jlatexmath],
                                      [org.scilab.forge.jlatexmath.TeXFormula],
                                      [LaTex Rendering])
                JLATEXMATH=${PACKAGE_JAR_FILE}
                AC_SUBST([JLATEXMATH])dnl

                AC_JAVA_CHECK_VERSION_PACKAGE([jlatexmath],
                              [import org.scilab.forge.jlatexmath.TeXFormula;],
                              [${JLATEXMATH}],[1.0.0],[TeXFormula.VERSION])dnl

                AC_DEFINE([WITH_GUI],[],
                          [With the JAVA stuff (GUI, Console, JOGL...)])
        fi

        # Checkstyle (code checking)
        AC_JAVA_CHECK_PACKAGE([checkstyle],
                              [com.puppycrawl.tools.checkstyle.CheckStyleTask],
                              [Checkstyle - code checking],["yes"])
        CHECKSTYLE=${PACKAGE_JAR_FILE}
        AC_SUBST([CHECKSTYLE])dnl

        # Commons beanutils (dependency of checkstyle)
        AC_JAVA_CHECK_PACKAGE([commons-beanutils],
                              [org.apache.commons.beanutils.Converter],
                              [Bean utility],["yes"])
        COMMONS_BEANUTILS=${PACKAGE_JAR_FILE}
        AC_SUBST([COMMONS_BEANUTILS])dnl

        # antlr (dependency of checkstyle)
        AC_JAVA_CHECK_PACKAGE([antlr],
                              [antlr.TokenStreamException],
                              [language tool for constructing recognizers],
                              ["yes"])
        ANTLR=${PACKAGE_JAR_FILE}
        AC_SUBST([ANTLR])dnl

        # Junit 4 (java unitary test)
        AC_JAVA_CHECK_PACKAGE([junit4],
                              [org.junit.Assert],
                              [Junit4 - Unit tests],
                              ["yes"])
        JUNIT4=${PACKAGE_JAR_FILE}
        AC_SUBST([JUNIT4])dnl

        # Cobertura (java code coverage)
        AC_JAVA_CHECK_PACKAGE([cobertura],
                              [net.sourceforge.cobertura.merge.Main],
                              [cobertura - Java code coverage],
                              ["yes"])
        COBERTURA=${PACKAGE_JAR_FILE}
        AC_SUBST([COBERTURA])dnl

        # ASM (a dependency of Cobertura)
        AC_JAVA_CHECK_PACKAGE([asm3],
                              [org.objectweb.asm.Type],
                              [Java bytecode manipulation (dep of cobertura)],
                              ["yes"])
        ASM3=${PACKAGE_JAR_FILE}
        AC_SUBST([ASM3])
        if test -z "$ASM3"; then
                AC_JAVA_CHECK_PACKAGE([asm],
                              [org.objectweb.asm.Type],
                              [Java bytecode manipulation (dep of cobertura)],
                              ["yes"])
                ASM3=${PACKAGE_JAR_FILE}
        fi

    else
        AC_MSG_WARN([Sun javac not found: I will not build the java interface])
        if test "x${ac_java_jvm_name}" != "x"; then
            AC_MSG_WARN([We do not support $ac_java_jvm_name yet])
        fi
    fi
    AC_SUBST([JAVA_JNI_INCLUDE])dnl
    AC_SUBST([JAVA_JNI_LIBS])dnl
    AC_SUBST([JAVA_HOME])dnl

    if test "x${enable_debug_java}" = "xyes"; then
        JAVAC_DEBUG="on"
    else
        JAVAC_DEBUG="off"
    fi
    AC_SUBST([JAVAC_DEBUG])dnl

    if test "x${enable_build_swig}" != "xno" -a "x${enable_build_swig}" != "x"; then
        dnl# these are from m4/swig.m4
        dnl# TODO: migrate to the AX_* versions of these macros
        SWIG_PROG([])
        SWIG_ENABLE_CXX([])
        SWIG_ENABLE_JAVA([])
        if test -z "${SWIG_BIN}"; then
          AC_PATH_PROG([SWIG_BIN],[swig],[no])
          if test "x${SWIG_BIN}" = "xno"; then
            AC_MSG_ERROR([Cannot find swig program, which is required to build Scilab. If it is installed on your system, ensure that it is in your path. If it is not, use the option --disable-build-swig])
          fi
        fi
        AC_SUBST([SWIG_BIN])dnl
        AC_SUBST([SWIG_CXX])dnl
        AC_SUBST([SWIG_JAVA])dnl
        ## that should be enough
    else
        AC_MSG_NOTICE([skipping checks for swig])
        if test -z "${SWIG_BIN}"; then
          ## need a dummy to keep the variable from being empty, just in case:
          SWIG_BIN=true
        fi
        dnl# make sure it is turned off if not specifically requested
        enable_build_swig=no
    fi

    # Giws is the equivalent of Swig developed by the Scilab team
    # in order to provide a wrapper to Java from C/C++
    if test "x${enable_build_giws}" != "xno" -a "x${enable_build_giws}" != "x"; then
        AC_GIWS([1.3.0]) dnl# from m4/giws.m4
    else
        dnl# make sure it is turned off if not specifically requested
        enable_build_giws=no
    fi
else
    AC_MSG_NOTICE([skipping checks for java stuff, including fop and swig])
    dnl# none of these can be turned on if Java is not turned on
    enable_build_swig=no
    enable_build_giws=no
    HAVE_FOP=no
    AC_SUBST([enable_build_swig])dnl
    AC_SUBST([enable_build_giws])dnl
    AC_SUBST([HAVE_FOP])dnl
    ## done with this java part
    if test -z "${SWIG_BIN}"; then
      ## need a dummy to keep the variable from being empty, just in case:
      SWIG_BIN=true
    fi
fi

JAVA_ENABLE=yes

if test -z "${JAVAC}"; then
   AC_MSG_NOTICE([no java compiler was found; turning off java])
   JAVA_ENABLE=no
fi

AC_SUBST([JAVA_ENABLE])dnl

# Xcos is not checked here because gui=no disables it
AM_CONDITIONAL([NEED_JAVA],
               [test "x${with_javasci}" != "xno" -o "x${with_gui}" != "xno" -o "x${enable_build_help}" != "xno"])
AM_CONDITIONAL([GUI],[test "x${with_gui}" != "xno"])
AM_CONDITIONAL([JAVASCI],[test "x${with_javasci}" != "xno"])
AM_CONDITIONAL([SWIG],
               [test "x${enable_build_swig}" != no -a "x${enable_build_swig}" != "x"])
AM_CONDITIONAL([GIWS],
               [test "x${enable_build_giws}" != "xno" -a "x${enable_build_giws}" != "x"])dnl

##############################################################
## GUI module
##############################################################

GUI_ENABLE=no

if test "x${JAVA_ENABLE}" != "xno"; then
   GUI_ENABLE=yes
fi

if test "x${with_gui}" != "xno"; then
   GUI_ENABLE=yes
fi

AC_SUBST([GUI_ENABLE])dnl

##############################################################
## test for functions in standard C library and C math library
##############################################################

# Provided by unistd.h
AC_CHECK_FUNCS([sleep usleep dup2 getcwd getpagesize getpass])
AC_CHECK_FUNCS([rmdir])dnl

dnl# replacing getwd via define is the wrong way to go about dealing with it;
dnl# just avoid it altogether
dnl# (the define that was here previously broke further conftests after it)

# Provided by regex.h
AC_CHECK_FUNCS([regcomp])dnl

# Provided by stdlib.h
AC_CHECK_FUNCS([atexit putenv setenv])dnl

# Provided by string.h
AC_CHECK_FUNCS([bzero memmove memset strcasecmp strerror strchr \
                strdup strpbrk strrchr strstr strtol])dnl

# Provided by select.h
AC_CHECK_FUNCS([select])dnl

# Provided by pwd.h
AC_CHECK_FUNCS([endpwent])dnl

# Provided by netdb.h
AC_CHECK_FUNCS([gethostbyaddr gethostbyname gethostname])dnl

# Provided by time.h
AC_CHECK_FUNCS([gettimeofday])dnl

# Provided by ctype.h
AC_CHECK_FUNCS([isascii])dnl

# Provided by wctype.h
AC_CHECK_FUNCS([iswprint])dnl

# Provided by types.h
AC_CHECK_FUNCS([mkdir])dnl

# Provided by mman.h
AC_CHECK_FUNCS([munmap])dnl

# Provided by signal.h
AC_CHECK_FUNCS([strsignal])dnl

# Check of the libm (lib math). Macro provided by libtool.
save_LDFLAGS="${LDFLAGS}"
LT_LIB_M([])dnl

# Provided by math.h

LDFLAGS="${LDFLAGS} ${LIBM}"
AC_CHECK_FUNCS([ceil ceilf pow sqrt finite floor exp10 log10 round signbit])dnl

AC_CHECK_DECLS([finite, round, signbit])dnl

### If isinf exists or not (used to not be the case under Solaris)
### See bug #4164
AC_CHECK_FUNC([isinf],[],[
        AC_DEFINE([isinf(x)],[(!finite(x) && x==x)],
                  [Provide a macro to do isinf])
])
LIBS="${LIBS} ${LIBM}"
LDFLAGS="${save_LDFLAGS}"

# Provided by regex.h
AC_CHECK_FUNCS([re_comp])dnl

# Provided by socket.h
AC_CHECK_FUNCS([socket])dnl

# Provided by utsname.h
AC_CHECK_FUNCS([uname])dnl

# Provided by wtloop.c
# (really? ".c" instead of ".h"? just going with it for now...)
AC_CHECK_FUNCS([setlocale])dnl

# Function memcmp used in modules/fileio/src/c/xls.c
AC_FUNC_MEMCMP

# function stat used in modules/core/src/c/link_std.c
AC_FUNC_STAT

# function strtod used in modules/core/src/c/getval.c
AC_FUNC_STRTOD

# other funcs (most are from autoscan warnings)
AC_FUNC_ALLOCA
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_MBRTOWC
AC_FUNC_MALLOC
XORG_CHECK_MALLOC_ZERO dnl# from m4/xorg-macros.m4
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_FUNC_SETVBUF_REVERSED
AC_CHECK_FUNCS([__argz_count __argz_next __argz_stringify dlopen \
dyld_stub_binding_helper freopen localeconv lt_dlopen mblen mbrlen memchr \
mempcpy nl_langinfo realpath stpcpy strcspn strncasecmp strspn strtoul \
vsnprintf wcwidth])dnl

AC_CHECK_DECLS([vsnprintf])dnl

########################
## test for header files
########################

AC_HEADER_MAJOR

AC_CHECK_HEADERS([limits.h values.h])dnl

AC_CHECK_HEADERS([argz.h ctype.h dl.h dlfcn.h fcntl.h float.h \
iconv.h io.h jni.h langinfo.h libintl.h locale.h ltdl.h mach-o/dyld.h \
mach-o/getsect.h machine.h malloc.h malloc/malloc.h math.h mman.h netdb.h \
netinet/in.h nlist.h param.h pwd.h regex.h select.h sgtty.h \
signal.h socket.h stddef.h stdio.h stdio_ext.h sys/file.h \
sys/ioctl.h sys/param.h sys/socket.h sys/time.h sys/timeb.h \
sys/utsname.h syslog.h term.h termcap.h termio.h termios.h tgmath.h \
time.h types.h utime.h utsname.h wchar.h wctype.h winbase.h windows.h \
wtloop.c xlocale.h])dnl

# check header dirent
AC_HEADER_DIRENT

# static struct timeval defined or not | used in modules/core/src/c/timer.c
AC_HEADER_TIME

# check if the specific header is available or not | used in modules/core/src/c/link_SYSV.c
AC_HEADER_SYS_WAIT

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
if test "x${ac_cv_type_intptr_t}" = "x"; then
  test -z "${ac_cv_type_intptr_t}"
  AC_TYPE_INTPTR_T
fi
AC_TYPE_SSIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
if test "x${ac_cv_type_uintptr_t}" = "x"; then
  test -z "${ac_cv_type_uintptr_t}"
  AC_TYPE_UINTPTR_T
fi
AC_CHECK_TYPES([ptrdiff_t])
AC_CHECK_TYPES([lt_dlsymlist])dnl

#########################
## Test for structures ##
#########################
AC_CHECK_MEMBERS([struct stat.st_blksize])
AC_CHECK_MEMBERS([struct stat.st_rdev])
AC_CHECK_MEMBERS([struct stat.st_size])dnl

#######################
## MISC Test
#######################

# gettext.  See http://www.gnu.org/software/hello/manual/gettext/AM_005fGNU_005fGETTEXT.html
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.18.3]) dnl# 0.18.3 fixes bugs in the po subdir that were in 0.18.2

# function closedir used in modules/metanet/src/c/files.c
AC_FUNC_CLOSEDIR_VOID

# Signals used in modules/core/src/c/realmain.c
dnl# Begin what used to be AC\_TYPE\_SIGNAL
AC_CACHE_CHECK([return type of signal handlers],[ac_cv_type_signal],[
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
#include <sys/types.h>
#include <signal.h>
]],[[
return *(signal (0, 0)) (0) == 1;
]])],[ac_cv_type_signal=int],[ac_cv_type_signal=void])dnl
])dnl
  ## corresponding define:
AC_DEFINE_UNQUOTED([RETSIGTYPE],[${ac_cv_type_signal}],
         [Define as the return type of signal handlers (`int' or `void').])
dnl# End what used to be AC\_TYPE\_SIGNAL

# struct tm used in modules/core/src/c/history.c
AC_STRUCT_TM

# st_blocks in the struct in modules/io/sci_gateway/c/intfilestat.c
AC_STRUCT_ST_BLOCKS

##################
## termcap library
##################

# some systems may have a system curses implementation as well as ncurses
# installed.  We need to be consistent in making sure we get the correct
# library to go with the correct header and also provide a way for the user
# to have some control over which is picked when both are available.
#
# For now, just check for -lcurses and then -lncurses.  The user control
# may need to be revisited

TERMCAP_LIB=no

# Various observations:
#
#  ncurses
#    - installs ncurses.h and possibly curses.h as a link to ncurses.h
#    - installs -lncurses.
#    - need to include term.h for tgetent() but tgetent() is in -lncurses.a
#
# curses as found in NetBSD-4 and NetBSD-5
#    - installs curses.h
#    - need to include termcap.h and link with -ltermcap for tgetent()
#

AC_CHECK_LIB([curses],[main])
if test "x${ac_cv_lib_curses_main}" = "xno"; then
    AC_CHECK_LIB([ncurses],[main])
fi

# make sure we have what we need for tgetent
AC_SEARCH_LIBS([tgetent],[termcap tinfo curses ncurses])dnl

AC_CHECK_HEADERS([ncurses.h curses.h])dnl

if test "x${ac_cv_lib_curses_main}" = "xyes" -o "x${ac_cv_lib_ncurses_main}" = "xyes"; then
  AC_DEFINE([HAVE_TERMCAP],[],[Have Term Cap])
else
 AC_MSG_ERROR([No termcap library detected. Please install ncurses dev library (or termcap library)])
fi

##################
## other libraries
##################

AC_CHECK_LIB([c],[printf])
AC_SEARCH_LIBS([dlopen],[dl xpdl dlcompat dyld ltdl zrldsrl])
AC_CHECK_LIB([dl],[dlsym])
AC_CHECK_LIB([iconv],[iconv],[:],[
  AC_CHECK_LIB([iconv],[libiconv],[:],[
    AC_CHECK_LIB([libiconv],[iconv],[:],[
      AC_CHECK_LIB([libiconv],[libiconv])
    ])dnl
  ])dnl
])dnl
AC_CHECK_LIB([intl],[gettext],[:],[
  AC_CHECK_LIB([intl],[libintl_gettext])
])dnl
AC_CHECK_LIB([ltdl],[lt_dlopen])
AC_SEARCH_LIBS([sqrt],[m c])
AC_CHECK_LIB([m],[cos])
AC_CHECK_LIB([pthread],[pthread_create])
AC_SEARCH_LIBS([pthread_join],[pthread c])
AC_CHECK_LIB([stdc++],[__cxa_atexit])
AC_CHECK_LIB([z],[gzread])dnl

#################
## FFTW
#################

AC_ARG_WITH([fftw],
    [AS_HELP_STRING([--without-fftw],
                    [Disable the interface to the FFTW 3 library])])dnl

FFTW_ENABLE=no
if test "x${with_fftw}" != "xno"; then
   AC_FFTW([]) dnl# from m4/fftw.m4
   FFTW_ENABLE=yes
else
   AC_MSG_NOTICE([skipping checks for fftw])
fi

AC_SUBST([FFTW_ENABLE])
AM_CONDITIONAL([FFTW],[test "x${with_fftw}" != "xno"])dnl

#################
## OpenMP
#################

AC_ARG_WITH([openmp],
    [AS_HELP_STRING([--without-openmp],
                    [Disable the usage of OpenMP (parallelization of some algoritms)])])dnl

OPENMP_ENABLE=no
if test "x${with_openmp}" != "xno"; then
    AC_OPENMP
    OPENMP_CFLAGS="-fopenmp"
    OPENMP_CXXFLAGS="-fopenmp"
    OPENMP_LIBS="-lgomp"

    AC_CHECK_HEADERS([omp.h],[],
     [AC_MSG_ERROR([Could not find omp.h; try disabling OpenMP with --without-openmp])])dnl

    OPENMP_ENABLE=yes
else
    AC_MSG_NOTICE([skipping checks for openmp])
fi
AC_SUBST([OPENMP_ENABLE])dnl
AC_SUBST([OPENMP_CFLAGS])dnl
AC_SUBST([OPENMP_CXXFLAGS])dnl
AC_SUBST([OPENMP_LIBS])dnl

AM_CONDITIONAL([OPENMP],[test "x${with_openmp}" != "xno"])dnl


#######################
## Test for libxml
#######################

AC_LIBXML2([]) dnl# from m4/libxml2.m4

#######################
## Test for gettext
#######################

ALL_LINGUAS="en_US fr_FR zh_CN zh_TW ru_RU ca_ES de_DE es_ES pt_BR ja_JP it_IT uk_UA pl_PL cs_CZ"
ALL_LINGUAS_DOC="en_US fr_FR pt_BR ja_JP ru_RU"

AC_ARG_ENABLE([build-localization],
        [AS_HELP_STRING([--disable-build-localization],
                        [Disable the localization build])
        ])
BUILD_LOCALIZATION_ENABLE=no

if test "x${enable_build_localization}" != "xno"; then
   test ! -z "${LANG}" && test ! -z "${LC_ALL}"
   AC_SUBST([ALL_LINGUAS])dnl
   AC_SUBST([ALL_LINGUAS_DOC])dnl
   AC_CHECK_FUNCS([bind_textdomain_codeset])dnl

   if test -z "${MSGFMT}"; then
      AC_PATH_PROG([MSGFMT],[msgfmt],[no])
   fi
   AC_PATH_PROG([MSGCAT],[msgcat],[no])
   # the main gettext macro used farther above already checks for msgfmt and
   # xgettext, so we can remove the checks for them here

   if test "x${MSGFMT}" = "xno"; then
      AC_MSG_ERROR([The msgfmt command is required to build Scilab. If it is installed on your system, ensure that it is in your path. If it is not, install GNU gettext to continue or use the option --disable-build-localization])
   fi
   if test "x${MSGCAT}" = "xno"; then
      AC_MSG_ERROR([The msgcat command is required to build Scilab. If it is installed on your system, ensure that it is in your path. If it is not, install GNU gettext to continue or use the option --disable-build-localization])
   fi
   BUILD_LOCALIZATION_ENABLE=yes
else
    AC_MSG_NOTICE([skipping checks required for building localizations])
fi
AM_CONDITIONAL([GENERATE_LOCALIZATION_FILES],
               [test "x${BUILD_LOCALIZATION_ENABLE}" = "xyes"])
AM_CONDITIONAL([BUILD_MACROS],
               [test "x${BUILD_LOCALIZATION_ENABLE}" = "xyes"])dnl

#######################
## Test for blas/Atlas and lapack
#######################

case "$host_os" in
	*Darwin* | *darwin*)
	  if test ! -z "${BLAS_LIBS}"; then
	  	BLAS_LIBS="${BLAS_LIBS} -Wl,-framework,Accelerate"
	  fi
	  if test ! -z "${CPPFLAGS}"; then
	  	CPPFLAGS="${CPPFLAGS} -Wp,-I/System/Library/Frameworks/Accelerate.framework/Headers"
	  fi
	  if test ! -z "${CXXFLAGS}"; then
	  	CXXFLAGS="${CXXFLAGS} -Wp,-I/System/Library/Frameworks/Accelerate.framework/Headers"
	  fi
	;;
esac

AC_MSG_CHECKING([if BLAS, ATLAS or MKL is available])
echo ""
dnl# these are mostly from m4/libsmath.m4
ACX_BLAS([AC_MSG_RESULT([$BLAS_TYPE found])],
        [AC_MSG_ERROR([Impossible to find a BLAS compatible library (see BLAS or ATLAS).])
        ])dnl

AC_MSG_CHECKING([if LAPACK is available])
echo ""
AC_CHECK_LIB([lapack],[clapack_sgesv])
ACX_LAPACK([AC_MSG_RESULT([$LAPACK_TYPE found])],
        [AC_MSG_ERROR([Impossible to find the LAPACK library.])
        ])dnl

AC_ARG_WITH([arpack-ng],
    [AS_HELP_STRING([--without-arpack-ng],
                    [Disable the interface to ARPACK-NG])])dnl

ARPACK_NG=no
if test "x${with_arpack_ng}" != "xno"; then
   ARPACK_NG=yes
   AC_MSG_CHECKING([if ARPACK-NG is available])
echo ""
ACX_ARPACK([AC_MSG_RESULT([ARPACK-NG library found])],
        [AC_MSG_ERROR([Impossible to find the ARPACK library. Please note that arpack was bundled with version prior to 5.4.0 and Scilab requires arpack-ng ( http://forge.scilab.org/index.php/p/arpack-ng/ ). Use the --without-arpack-ng flag to disable this error.])
        ])dnl

CHECK_ARPACK_OK([AC_MSG_RESULT([Working ARPACK-NG library found (probably ARPACK-NG or a patched version of ARPACK)])],
[AC_MSG_ERROR([ARPACK library found, but seems not to work properly. Please make sure you are using arpack-ng, or use the --without-arpack-ng flag to disable this error.])
])
else
   AC_MSG_CHECKING([... actually nope, not checking this (skip ARPACK-NG detection)])
   AC_MSG_RESULT([ ])
fi

AM_CONDITIONAL([ARPACK_NG],[test "x${ARPACK_NG}" != "xno"])dnl

#################
## UMFPACK
#################

AC_ARG_WITH([umfpack],
    [AS_HELP_STRING([--without-umfpack],
                    [Disable the interface to the UMFPACK library])])dnl

UMFPACK_ENABLE=no
if test "x${with_umfpack}" != "xno"; then
   AC_UMFPACK([${BLAS_LIBS}]) dnl# from m4/umfpack.m4
   UMFPACK_ENABLE=yes
else
   AC_MSG_NOTICE([skipping checks for umfpack])
fi

AC_SUBST([UMFPACK_ENABLE])dnl
AM_CONDITIONAL([UMFPACK],[test "x${with_umfpack}" != "xno"])dnl

#######################
## Test for PCRE
#######################

AC_PCRE([]) dnl# from m4/pcre.m4

#################
## Tcl/Tk library
#################

AC_DEFUN([XORG_REQUIRE_DEFAULT_OPTIONS],[
  AC_REQUIRE([XORG_DEFAULT_OPTIONS])dnl# from m4/xorg-macros.m4
])dnl

WITH_TKSCI=no
if test "x${with_tk}" != "xno"; then
   if test "$MACOSX" = "1"; then
      AC_MSG_WARN([Due to technical constraints, Tcl/Tk ought to be disabled under Mac OS X (--without-tk)])
      AC_MSG_NOTICE([(this ought to be an error, but continuing anyways just for fun)])
      if test "x${enable_debug_linker}" = "xyes"; then
        m_d_treatment="warning"
      else
        m_d_treatment="suppress"
      fi
      if test "x${enable_stop_on_warning}" != "xyes"; then
        if test "x${TCL_LDFLAGS}" = "x"; then
          test -z "${TCL_LDFLAGS}" && export TCL_LDFLAGS="-Wl,-multiply_defined,${m_d_treatment}"
        else
          test -n "${TCL_LDFLAGS}" && export TCL_LDFLAGS="${TCL_LDFLAGS} -Wl,-multiply_defined,${m_d_treatment}"
        fi
      else
        AC_MSG_WARN([will probably error out when linking])
      fi
      AC_SUBST([TCL_LDFLAGS])
   fi

    # check user arguments
    USER_TCL_LIB_PATH=""
    USER_TCL_INC_PATH=""
    AC_ARG_WITH([tcl-library],
        [AS_HELP_STRING([--with-tcl-library=DIR],
                        [Set the path to the TCL library])],
        [USER_TCL_LIB_PATH=${withval}
    ])
    AC_ARG_WITH([tcl-include],
        [AS_HELP_STRING([--with-tcl-include=DIR],
                        [Set the path to the TCL headers])],
        [USER_TCL_INC_PATH=${withval}
    ])dnl

    USER_TK_LIB_PATH=${USER_TCL_LIB_PATH}
    USER_TK_INC_PATH=${USER_TCL_INC_PATH}

    AC_ARG_WITH([tk-library],
        [AS_HELP_STRING([--with-tk-library=DIR],
                        [Set the path to the TK library])],
        [USER_TK_LIB_PATH=${withval}
    ])dnl

    AC_ARG_WITH([tk-include],
        [AS_HELP_STRING([--with-tk-include=DIR],
                        [Set the path to the TK headers])],
        [USER_TK_INC_PATH=${withval}
    ])dnl

    ###########################
    ########## X11 checks
    ###########################
    ## This check is mandatory since tk needs Xlib headers and libs
    AC_PATH_XTRA
    AC_CHECK_LIB([Xlib],[_Xmblen])dnl
    AC_CHECK_HEADERS_ONCE([X.h Xlib.h X11/X.h])dnl
    ##

    if test -z "${SELECTIVE_WERROR}"; then
      XORG_REQUIRE_DEFAULT_OPTIONS dnl# from above
    fi

    saved_cflags="${CFLAGS}"
    saved_ldflags="${LDFLAGS}"
    saved_cppflags="${CXXFLAGS}"

    AC_CHECK_LIB([dl],[main],[TCLTK_LIBS=" -ldl"])
    AC_CHECK_TCLTK dnl# from m4/tcltk.m4

    # set variables
    if test "x${WITH_TKSCI}" = "xyes"; then
        AC_DEFINE([WITH_TK],[],[With TK])
    else
        AC_MSG_ERROR([TCL/TK not found. Use --without-tk or specify the librairies and include paths manually])
    fi
    AC_SUBST([TCLTK_LIBS])dnl
    AC_SUBST([TCL_INC_PATH])dnl
    AC_SUBST([TK_INC_PATH])dnl
    ## TK = OK
else
    AC_MSG_NOTICE([skipping checks for tk])
fi
AC_SUBST([WITH_TKSCI])
AM_CONDITIONAL([TCLTK],[test "x${WITH_TKSCI}" = "xyes"])dnl

#################
## MATIO LIBRARY (MAT File I/O Library)
#################

AC_ARG_WITH([matio],
    [AS_HELP_STRING([--without-matio],
                    [Disable interface to Matio (MAT File I/O library)])])dnl

AC_ARG_WITH([matio_include],
        [AS_HELP_STRING([--with-matio-include=DIR],
                        [Set the path to the MATIO headers])],
        [with_matio_include="-Wp,-I${withval}"],[])dnl

AC_ARG_WITH([matio_library],
        [AS_HELP_STRING([--with-matio-library=DIR],
                        [Set the path to the MATIO libraries])],
        [with_matio_library="-L${withval}"],[])dnl

MATIO_ENABLE=no

if test "x${with_matio}" != "xno"; then
   if test -n "${with_matio_include}" -o -n "${with_matio_library}"; then
      MATIO_CFLAGS="${with_matio_include}"
      MATIO_LIBS="${with_matio_library} -lm -lz -lmatio"
   else
      PKG_CHECK_MODULES([MATIO],[matio >= 1.3.3])
   fi

   save_CFLAGS="${CFLAGS}"
   save_LIBS="${LIBS}"

   CFLAGS="${CFLAGS} ${MATIO_CFLAGS}"
   LIBS="${LIBS} ${MATIO_LIBS}"

   AC_CHECK_HEADERS([matio.h matioConfig.h],[],
     [AC_CHECK_HEADERS([matio_pubconf.h],[],
        [AC_MSG_ERROR([Invalid MATIO_CFLAGS returned by pkg-config. Try to define MATIO_CFLAGS, or use --without-matio to disable Matio interface.])
     ])
   ])
   AC_CHECK_LIB([matio],[Mat_Open],[],
     [AC_MSG_ERROR([Invalid MATIO_LIBS returned by pkg-config. Try to define MATIO_LIBS, or use --without-matio to disable Matio interface.])])dnl

   AC_CHECK_TYPES([mat_t],[],[],[
#ifdef HAVE_MATIO_H
# include <matio.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for mat_t expects <matio.h> to be included."
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_MATIO_H */
   ])dnl

   AC_CHECK_MEMBERS([struct _mat_t.filename],[],[],[
#ifdef HAVE_MATIO_H
# include <matio.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for struct _mat_t.filename wants to include <matio.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_MATIO_H */
   ])dnl

   LIBS="${save_LIBS}"
   CFLAGS="${save_CFLAGS}"

   AC_DEFINE([WITH_MATIO],[],[With the MATIO library])
   MATIO_ENABLE=yes
else
   AC_MSG_NOTICE([skipping checks for matio])
fi

AC_SUBST([MATIO_ENABLE])
AM_CONDITIONAL([MATIO],[test "x${with_matio}" != "xno"])dnl

#############################
## Documentation management #
#############################

HELP_ENABLE=yes

AC_ARG_ENABLE([build-help],
        [AS_HELP_STRING([--disable-build-help],[Disable the help build])
        ])dnl

if test "x${enable_build_help}" != "xno"; then
    AC_DOCBOOK([])     dnl# from m4/docbook.m4
    XORG_CHECK_DOCBOOK dnl# from m4/xorg-macros.m4
else
    dnl# make sure that the conditionals from XORG_CHECK_DOCBOOK still get
    dnl# defined:
    unset XSL_STYLESHEET
    HELP_ENABLE=no
    BUILD_TXTDOC=no
    BUILD_PDFDOC=no
    BUILD_PSDOC=no
    BUILD_HTMLDOC=no
fi

if test "x${JAVA_ENABLE}" = "xno"; then
    dnl# Java is needed to build help
    HELP_ENABLE=no
fi

AC_SUBST([HELP_ENABLE])dnl

AM_CONDITIONAL([BUILD_HELP],[test "x${HELP_ENABLE}" = "xyes"])
dnl# These are in case XORG_CHECK_DOCBOOK never gets run
AM_CONDITIONAL([HAVE_STYLESHEETS],[test "x${XSL_STYLESHEET}" != "x"])
AM_CONDITIONAL([BUILD_TXTDOC],[test "x${BUILDTXTDOC}" = "xyes"])
AM_CONDITIONAL([BUILD_PDFDOC],[test "x${BUILDPDFDOC}" = "xyes"])
AM_CONDITIONAL([BUILD_PSDOC],[test "x${BUILDPSDOC}" = "xyes"])
AM_CONDITIONAL([BUILD_HTMLDOC],[test "x${BUILDHTMLDOC}" = "xyes"])dnl

## Install XML help files ###

AC_ARG_WITH([install-help-xml],
        [AS_HELP_STRING([--with-install-help-xml],
                        [make install will install XML files])
        ])
HELP_INSTALL_ENABLE=no
if test "x${with_install_help_xml}" != "xno" -a "x${with_install_help_xml}" != "x"; then
   AC_PATH_PROG([XMLINDENT],[xmlindent],[no])
   HELP_INSTALL_ENABLE=yes
else
   test -z "${XMLINDENT}"
   AM_MISSING_PROG([XMLINDENT],[xmlindent])
fi
AM_CONDITIONAL([INSTALL_HELP_XML],
               [test "x${HELP_INSTALL_ENABLE}" != "x"])dnl

## Doxygen help generation
AC_ARG_ENABLE([build-doxygen],
    [AS_HELP_STRING([--enable-build-doxygen],
                    [Generate doxygen C/C++ documentation])])dnl

DOXYGEN_ENABLE=yes
if test "x${enable_build_doxygen}" != "xno" -a "x${enable_build_doxygen}" != "x"; then
    XORG_WITH_DOXYGEN dnl# from m4/xorg-macros.m4
    AM_MISSING_PROG([DOXYGEN_PROG],[doxygen])
    dnl# ${have_doxygen} comes from the xorg macro for it:
    if test "x${have_doxygen}" = "xyes"; then
        DOXYGEN_ENABLE=yes
    else
        DOXYGEN_ENABLE="FIXME"
    fi
else
    DOXYGEN_ENABLE=no
fi
AM_CONDITIONAL([DOXYGEN],[test "x${DOXYGEN_ENABLE}" = "xyes"])dnl

##############################################################
## Javasci module
##############################################################

JAVASCI_ENABLE=yes

if test "x${JAVA_ENABLE}" = "xno" -o "x${JAVASCI}" = "xno"; then
   JAVASCI_ENABLE=no
fi

AC_SUBST([JAVASCI_ENABLE])dnl

##############################################################
## Enable test a compilation time
##############################################################

COMPILATION_TESTS=no
if test "x${enable_compilation_tests}" != "xno" -a "x${enable_compilation_tests}" != "x"; then
   COMPILATION_TESTS=yes
fi

AC_DEFUN([XORG_REQUIRE_TESTS],[
   AC_REQUIRE([XORG_ENABLE_UNIT_TESTS])dnl# from m4/xorg-macros.m4
   AC_REQUIRE([XORG_ENABLE_INTEGRATION_TESTS])dnl# from m4/xorg-macros.m4
])dnl

if test "x${COMPILATION_TESTS}" = "xyes"; then
    XORG_REQUIRE_TESTS dnl# from above
fi

if test "x${COMPILATION_TESTS}" = "xyes" -a "x${JUNIT4}" = "x"; then
   test -z "${JUNIT4}"
   AC_MSG_WARN([--enable-compilation-tests deactivated: Could not find Junit4.])
   COMPILATION_TESTS=no
fi

AM_CONDITIONAL([COMPILATION_TESTS],[test "x${COMPILATION_TESTS}" != "xno"])dnl

##############################################################
## Enable the global force link
##############################################################

AC_ARG_ENABLE([force-full-link],
    [AS_HELP_STRING([--enable-force-full-link],
                    [Forces the explicit link between libscilab and some "on-the-fly" loaded libraries. DO NOT USE IN PRODUCTION.])])dnl

FORCE_FULL_LINK="no"
if test "x${enable_force_full_link}" == "xyes"; then
    FORCE_FULL_LINK="yes"
fi

AM_CONDITIONAL([FORCE_LINK],[test "x${FORCE_FULL_LINK}" == "xyes"])dnl

##############################################################
## demo_tools module
##############################################################

DEMOTOOLS_ENABLE=yes

if test "x${GUI_ENABLE}" = "xno"; then
   DEMOTOOLS_ENABLE=no
fi

AC_SUBST([DEMOTOOLS_ENABLE])dnl

##############################################################
## graphics/renderer/graphic_export module
##############################################################

GRAPHICS_ENABLE=yes

if test "x${GUI_ENABLE}" = "xno"; then
   GRAPHICS_ENABLE=no
fi

AC_SUBST([GRAPHICS_ENABLE])dnl

#########################
## libtool
#########################

AC_DISABLE_STATIC([])
LT_PREREQ([2.2.7])
LT_INIT([shared dlopen win32-dll])
LT_LANG([C])   dnl# default
LT_LANG([C++]) dnl# also a default
LT_LANG([Java])
LT_LANG([Fortran 77])
LT_LANG([Fortran])
LT_LANG([Windows Resource])
dnl# all of the above "LT_LANG"s (besides the defaults) add additional checks

# Avoid to link all the dep from others libraries (*.la included by LIBADD)
link_all_deplibs=no

# Check to see if building shared libraries
libtool_build_shared_libs=no
if test "x${enable_shared}" = "xyes"; then
  libtool_build_shared_libs=yes
fi

# Check to see if building static libraries
libtool_build_static_libs=no
if test "x${enable_static}" = "xyes"; then
  libtool_build_static_libs=yes
fi

# Fake to disable the static build; replace "xxxx" with "yes" to un-fake:
AM_CONDITIONAL([ENABLE_STATIC],[test "$libtool_build_static_libs" = xxxx])dnl

XORG_LD_WRAP dnl# from m4/xorg-macros.m4

dnl# libtool should have already found ranlib, but autoscan will still
dnl# complain about it, and I am more okay with libtoolize warnings than
dnl# I am with autoscan warnings
dnl# see: https://savannah.gnu.org/support/?108503
if test "x${RANLIB}" = "x"; then
	test -z "${RANLIB}"
	AC_PROG_RANLIB
else
	test ! -z "${RANLIB}" && export RANLIB
	AC_SUBST([RANLIB])
fi

# Other compiler characteristics
AC_C_CHAR_UNSIGNED
AC_C_BIGENDIAN dnl# For Apple universal builds
AC_C__GENERIC
AC_C_CONST([])
AC_C_INLINE([])
AC_C_RESTRICT
AC_C_VOLATILE
AC_C_STRINGIZE
AC_C_FLEXIBLE_ARRAY_MEMBER
AC_C_PROTOTYPES dnl# Kinda pointless as most current compilers support this,
                dnl# but there is no harm in adding it, and I like including it

AC_C_TYPEOF

AC_BACKTRACE([]) dnl# from m4/backtrace.m4

##########
##### Code quality
##########
AC_PATH_PROG([SPLINT],[splint],[no])
AC_PATH_PROG([ASTYLE],[astyle],[no])
AC_PATH_PROGS([GNU_INDENT],[indent gindent],[no])
AC_PATH_PROG([CPPI],[cppi],[no])
XORG_WITH_LINT([]) dnl# from m4/xorg-macros.m4

##########
##### Detect ccache and use it by default if available
##########

AC_ARG_ENABLE([ccache],
        [AS_HELP_STRING([--disable-ccache],[Disable the use of ccache])
        ])
AC_PATH_PROG([CCACHE],[ccache])
dnl# FIXME: ensure that CC and CXX do not already contain CCACHE before
dnl# prepending it to them again:
if test x"${CCACHE}" != x"" -a "x${enable_ccache}" != "xno"; then
  if test -x "${CCACHE}"; then
    AC_MSG_NOTICE([prepending CCACHE to compile commands])
    CC="${CCACHE} ${CC}"
    CXX="${CCACHE} ${CXX}"
  fi
fi

#######################
###### Creation of the header file (machine.h)
#######################

AC_DEFINE_UNQUOTED([PATH_SEPARATOR],["$PATH_SEPARATOR"],
                   [The default path separator character.])dnl

AH_TOP([#ifndef MACHINE_H
#define MACHINE_H
/* This file defines global element configuration of the build host */
])dnl

AH_BOTTOM([

#ifdef DIR_SEPARATOR
       #undef DIR_SEPARATOR
#endif
#define DIR_SEPARATOR "/"

#if (defined(__GNUC__) && defined(__GNUC_MINOR__) && (__GNUC__ >= 3)) && \
    !defined(FLEX_SCANNER) && !defined(AVOID_POISONING)
# ifdef sprintf
#  undef sprintf
# endif /* sprintf */
# pragma GCC poison sprintf
#endif /* __GNUC__ && !AVOID_POISONING */

#endif /* MACHINE_H  */
])dnl

# Define the standard extension of a dynamic library
AC_DEFINE_UNQUOTED([SHARED_LIB_EXT],["$shrext_cmds"],
                   [Extension of a shared library])dnl

#################
## stop on warning
#################

# Stop to compile scilab when a warning is found ...
# This stuff is at the end of the configure.ac because it causes some
# problem with AC_COMPILE (the -Werror is added to the test)
#
dnl# @TODO : -O0 is only to bypass stack stercus... Must be removed.
if test "x${enable_stop_on_warning}" = "xyes"; then
    if test "x${enable_debug}" = "xyes"; then
        sowsaved_CFLAGS="${CFLAGS}"
        CFLAGS="${CFLAGS} -Wformat"
        CHECK_COMPILER_ARG([C],[-Werror=format-security],[CFLAGS],
                           [WERROR_CFLAGS])
        CFLAGS="${sowsaved_CFLAGS}"
        WARNING_CFLAGS="-Werror=implicit-function-declaration -O0 ${WERROR_CFLAGS}"
        sowsaved_CXXFLAGS="${CXXFLAGS}"
        CXXFLAGS="${CXXFLAGS} -Wformat"
        CHECK_COMPILER_ARG([C++],[-Werror=format-security],[CXXFLAGS],
                           [WERROR_CXXFLAGS])
        CXXFLAGS="${sowsaved_CXXFLAGS}"
        WARNING_CXXFLAGS="-Werror=implicit-function-declaration -O0 ${WERROR_CXXFLAGS}"
    else
        WERROR_CFLAGS=""
        WARNING_CFLAGS="-Werror=implicit-function-declaration -O0"
        WERROR_CXXFLAGS=""
        WARNING_CXXFLAGS="-Werror=implicit-function-declaration -O0"
    fi
fi

AC_SUBST([WARNING_CFLAGS])dnl
AC_SUBST([WARNING_CXXFLAGS])dnl
AC_SUBST([WERROR_CFLAGS])dnl
AC_SUBST([WERROR_CXXFLAGS])dnl

# SCI_*FLAGS contains all defaults values detected on configure.
# The point of all the calls to echo here is to strip excess spaces between
# the flags, so leave the set of variables unquoted:
SCI_CFLAGS=$(echo ${LARGEFILE_CFLAGS} ${CODECOVERAGE_CFLAGS} ${DEBUG_CFLAGS} ${ARCH_CFLAGS} ${COMPILER_CFLAGS} ${SCILIBS_CFLAGS} ${SSE_CFLAGS} ${BACKTRACE_CFLAGS} ${WARNING_CFLAGS} ${BASE_CFLAGS})
SCI_CXXFLAGS=$(echo ${LARGEFILE_CXXFLAGS} ${CODECOVERAGE_CXXFLAGS} ${DEBUG_CXXFLAGS} ${ARCH_CXXFLAGS} ${COMPILER_CXXFLAGS} ${SCILIBS_CXXFLAGS} ${SSE_CXXFLAGS} ${BACKTRACE_CXXFLAGS} ${WARNING_CXXFLAGS} ${BASE_CXXFLAGS})
SCI_FFLAGS=$(echo ${LARGEFILE_FFLAGS} ${CODECOVERAGE_FFLAGS} ${DEBUG_FFLAGS} ${ARCH_FFLAGS} ${COMPILER_FFLAGS} ${SCILIBS_FFLAGS} ${SSE_FFLAGS} ${BACKTRACE_FFLAGS} ${WARNING_FFLAGS})
SCI_LDFLAGS=$(echo ${LARGEFILE_LDFLAGS} ${CODECOVERAGE_LDFLAGS} ${DEBUG_LDFLAGS} ${ARCH_LDFLAGS} ${COMPILER_LDFLAGS} ${SCILIBS_LDFLAGS} ${SSE_LDFLAGS} ${BACKTRACE_LDFLAGS} ${WARNING_LDFLAGS})
AC_SUBST([SCI_CFLAGS])dnl
AC_SUBST([SCI_CXXFLAGS])dnl
AC_SUBST([SCI_FFLAGS])dnl
AC_SUBST([SCI_LDFLAGS])dnl

# extra space is so the pipe thru sed works correctly:
CPPFLAGS=$(echo " ${CPPFLAGS}" | ${SED} "s/ -I/ -Wp,-I/g")

dnl# make sure that the conditionals from XORG_WITH_FOP still get defined,
dnl# in case that macro never got run
if test -z "${HAVE_FOP}"; then
	HAVE_FOP=no
	AC_SUBST([HAVE_FOP])
else
	test ! -z "${HAVE_FOP}" && export HAVE_FOP
fi
AM_CONDITIONAL([HAVE_FOP],
               [test ! -z "${HAVE_FOP}" -a "x${HAVE_FOP}" != "xno"])dnl

AC_CONFIG_FILES([
contrib/Makefile
desktop/images/icons/Makefile
desktop/Makefile
libs/Makefile
libs/doublylinkedlist/Makefile
libs/dynamiclibrary/Makefile
libs/hashtable/Makefile
libs/libst/Makefile
libs/MALLOC/Makefile
modules/Makefile
modules/action_binding/Makefile
modules/api_scilab/Makefile
modules/arnoldi/Makefile
modules/atoms/Makefile
modules/boolean/Makefile
modules/cacsd/Makefile
modules/call_scilab/Makefile
modules/commons/Makefile
modules/compatibility_functions/Makefile
modules/completion/Makefile
modules/console/Makefile
modules/core/Makefile
modules/data_structures/Makefile
modules/demo_tools/Makefile
modules/development_tools/Makefile
modules/differential_equations/Makefile
modules/double/Makefile
modules/dynamic_link/Makefile
modules/elementary_functions/Makefile
modules/external_objects/Makefile
modules/fftw/Makefile
modules/fileio/Makefile
modules/functions/Makefile
modules/genetic_algorithms/Makefile
modules/graph/Makefile
modules/graphic_export/Makefile
modules/graphic_objects/Makefile
modules/graphics/Makefile
modules/gui/Makefile
modules/hdf5/Makefile
modules/helptools/Makefile
modules/history_browser/Makefile
modules/history_manager/Makefile
modules/integer/Makefile
modules/interpolation/Makefile
modules/intersci/Makefile
modules/io/Makefile
modules/javasci/Makefile
modules/jvm/Makefile
modules/linear_algebra/Makefile
modules/localization/Makefile
modules/m2sci/Makefile
modules/matio/Makefile
modules/mexlib/Makefile
modules/modules_manager/Makefile
modules/optimization/Makefile
modules/output_stream/Makefile
modules/overloading/Makefile
modules/parallel/Makefile
modules/parameters/Makefile
modules/polynomials/Makefile
modules/prebuildjava/Makefile
modules/preferences/Makefile
modules/randlib/Makefile
modules/renderer/Makefile
modules/scicos/Makefile
modules/scicos_blocks/Makefile
modules/scinotes/Makefile
modules/signal_processing/Makefile
modules/simulated_annealing/Makefile
modules/sound/Makefile
modules/sparse/Makefile
modules/special_functions/Makefile
modules/spreadsheet/Makefile
modules/statistics/Makefile
modules/string/Makefile
modules/symbolic/Makefile
modules/tclsci/Makefile
modules/time/Makefile
modules/types/Makefile
modules/ui_data/Makefile
modules/umfpack/Makefile
modules/windows_tools/Makefile
modules/xcos/Makefile
modules/xml/Makefile
Makefile
po/Makefile.in
po/Makefile
po/Makevars
po/POTFILES
scilab.pc
etc/modules.xml
etc/classpath.xml
etc/Info.plist
etc/logging.properties
scilab.properties
scilab-lib.properties
scilab-lib-doc.properties
modules/helptools/etc/SciDocConf.xml
modules/core/includes/version.h
])dnl

# Detection of the module for the future version of Scilab 6
# ie we detect module which ends with _yasp

if test "x${enable_yasp}" = "xyes"; then
   AC_CONFIG_FILES([
   modules/development_tools/src/fake/Makefile
  ])
fi

# This script is used by Xcos in order to regenerate the function/block list
AC_CONFIG_COMMANDS_POST([chmod +x ${SCI_SRCDIR_FULL}/modules/dynamic_link/src/scripts/scicompile.sh ${SCI_SRCDIR_FULL}/modules/dynamic_link/src/scripts/compilerDetection.sh ${SCI_SRCDIR_FULL}/modules/dynamic_link/src/scripts/configure])dnl

# MAN_FR MAN_ENG
# modules/mpi/Makefile
for top_builddir in . .. ../.. ${ac_auxdir} ${ac_auxdir}/..; do
  test -f ${top_builddir}/configure && break
done

# Generate stack.h
if test "${IS_64_BITS_CPU}" = true -o "${MACOSX}" = "1"; then
   stack_h_cpp_flags=-DUSE_DYNAMIC_STACK
else
   stack_h_cpp_flags=""
fi

AC_CONFIG_COMMANDS([modules/core/includes/stack.h],
  [if ! ${CPP} ${stack_h_cpp_flags} - < ${srcdir}/modules/core/includes/stack.h.in |\
              ${GREP} -v '^#' > ${srcdir}/modules/core/includes/stack.h; then
     AC_MSG_ERROR([stack.h generation failed])
   fi],
  [CPP="${CPP}"
   GREP="${GREP}"
   stack_h_cpp_flags="${stack_h_cpp_flags}"
  ])dnl

AC_OUTPUT
# No more autoconf macros may be used after this point

# To distribution packager, you can uncomment this stuff is you want to
# disable the rpath issue
# However, you will have to set all the LD_LIBRARY_PATH to .libs/ directory
# since scilab is compiling macros and help into the source tree (ie before
# the "make install")
# You should consider using chrpath:
# http://directory.fsf.org/project/chrpath/
# to remove it before the make install

case ${host} in
  *-pc-linux-gnu)
    AC_MSG_RESULT([Fixing libtool for -rpath problems.])
    sed < libtool > libtool-2 \
    's/^hardcode_libdir_flag_spec.*$/hardcode_libdir_flag_spec=" -D__LIBTOOL_IS_A_FOOL__ "/'
    mv libtool-2 libtool
    chmod 755 libtool
  ;;
esac

echo ""

echo "Scilab is configured as follows. Please verify that this configuration"
echo "matches your expectations."
echo ""
echo "Host system type : $host"
echo ""
echo "                  Option                        Value"
echo "-------------------------------------------------------------------------"
echo "Shared libraries.......      --enable-shared=$libtool_build_shared_libs"
echo "Static libraries.......      --enable-static=$libtool_build_static_libs"
echo "GNU ld.................      --with-gnu-ld=$with_gnu_ld"
echo "Enable debug ..........      --enable-debug=$enable_debug"
echo "Enable debug C.........      --enable-debug-C=$enable_debug_C"
echo "Enable debug C++.......      --enable-debug-CXX=$enable_debug_CXX"
echo "Enable debug Java......      --enable-debug-java=$enable_debug_java"
echo "Enable debug Fortran...      --enable-debug-fortran=$enable_debug_fortran"
echo "Enable stop on warning.      --enable-stop-on-warning=$enable_stop_on_warning"

echo ""
echo "Compiler Configuration:"
echo "  Intel (--with-intelcompilers) .... =        $with_intelcompilers"
echo "  GNU gcc (--with-gcc) ............. =        $with_gcc"
echo "  GNU Fortran 95 (--with-gfortran) . =        $with_gfortran"
echo ""
echo "Options:"
echo "  Do not use TCL/TK (--without-tk) ................. = $with_tk"
echo "  TCL include (--with-tcl-include) ................. = $USER_TCL_INC_PATH"
echo "  TCL library (--with-tcl-library) ................. = $USER_TCL_LIB_PATH"
echo "  TK include (--with-tk-include) ................... = $USER_TK_INC_PATH"
echo "  TK library (--with-tk-library) ................... = $USER_TK_LIB_PATH"
echo "  Install XML Help (--with-install-help-xml) ....... = $with_install_help_xml"
echo "  Compilation tests (--enable-compilation-tests) ... = $COMPILATION_TESTS"
echo "  Make the package relocatable (--enable-relocatable)= $RELOCATABLE"
echo "  Use FFTW (--without-fftw) ........................ = $with_fftw"
echo "  Use MATIO (--without-matio) ...................... = $with_matio"

echo ""
if test "x${with_gui}" = "xno"; then
   echo "Not using Xcos because of the option --without-gui"
elif test "x${XCOS_ENABLE}" = "xyes"; then
   echo "Xcos enable"
   echo "Build modelica compiler (--without-modelica) ....... = $with_modelica"
   echo ""
   if test "x${with_ocaml}" != "xno" -a "x${OCAMLC}" != "xno" -a "x${OCAMLOPT}" != "xno"; then
     echo "Ocaml Configuration (for Modelica compiler):"
     echo "  OCAMLC ............. = $OCAMLC"
     echo "  OCAMLOPT ........... = $OCAMLOPT"
     echo "  OCAMLDEP ........... = $OCAMLDEP"
   else
     echo "Will not build Modelica compiler"
   fi
else
   echo "Not using Xcos"
fi

echo ""
if test "x${enable_code_coverage}" = "xyes";  then
   echo "Code coverage configuration:"
   echo "  LCOV .............. = $LCOV"
   echo "  GENHTML ........... = $GENHTML"
else
   echo "Not using code coverage"
fi

echo ""
if test "x${OPENMP_ENABLE}" = "xyes"; then
   echo "OpenMP Configuration:"
   echo "OpenMP CFLAGS ...... = $OPENMP_CFLAGS"
   echo "OpenMP CXXFLAGS .... = $OPENMP_CXXFLAGS"
   echo "OpenMP LIBS ........ = $OPENMP_LIBS"
   echo "OpenMP FFLAGS ...... = $OPENMP_LDFLAGS"
else
   echo "Not using OpenMP"
fi

echo ""
if test "x${FFTW_ENABLE}" = "xyes";  then
   echo "FFTW Configuration:"
   echo "  FFTW LIBS .......... = $FFTW3_LIB"
   echo "  FFTW CFLAGS ........ = $FFTW3_CFLAGS"
else
   echo "Not using FFTW"
fi

echo ""
if test "x${MATIO_ENABLE}" = "xyes";  then
   echo "MATIO Configuration:"
   echo "  MATIO LIBS .......... = $MATIO_LIBS"
   echo "  MATIO CFLAGS ........ = $MATIO_CFLAGS"
else
   echo "Not using MATIO"
fi

echo ""
if test "x${UMFPACK_ENABLE}" = "xyes";  then
   echo "UMFPACK Configuration:"
   echo "  UMFPACK LIBS ....... = $UMFPACK_LIB"
   echo "  UMFPACK CFLAGS ..... = $UMFPACK_CFLAGS"
   if test "x${SUITESPARSE}" = "xyes"; then
      echo "  UMFPACK SUITESPARSE  = Yes"
   else
      echo "  UMFPACK SUITESPARSE  = No"
   fi
else
   echo "Not using UMFPACK"
fi

echo ""
echo "BLAS/LAPACK/ATLAS Configuration:"
echo "  BLAS LIBS ............. = $BLAS_LIBS"
echo "  BLAS TYPE ............. = $BLAS_TYPE"
echo "  LAPACK LIBS ........... = $LAPACK_LIBS"
echo "  LAPACK TYPE ........... = $LAPACK_TYPE"
echo "  ARPACK LIBS ........... = $ARPACK_LIBS"
echo ""

if test "x${with_mpi}" = "xyes"; then
   echo "MPI Configuration:"
   echo "  MPI LIBS ........... = $MPILIBS"
   echo "  MPI C Compiler ..... = $MPICC"
   echo "  MPI C++ Compiler ... = $MPICXX"
   echo "  MPI F77 Compiler ... = $MPIF77"
else
   echo "Not using MPI"
fi

echo ""
if test "x${with_openmpi}" != "xno"; then
   echo "OpenMPI Configuration:"
   echo "  OpenMPI LIBS ........... = $OPENMPI_LIBS"
   echo "  OpenMPI C Compiler ..... = $OPENMPI_CC"
   echo "  OpenMPI F77 Compiler ... = $MPIF77"
else
   echo "Not using MPI"
fi

echo ""
if test "x${BUILD_LOCALIZATION_ENABLE}" != "xno"; then
   echo "Gettext/localization configuration:"
   echo "  xgettext ............... = $XGETTEXT"
   echo "  msgfmt  ................ = $MSGFMT"
   echo "  msgfmt_opts ............ = $MSGFMT_OPTS"
   echo "  msgcat  ................ = $MSGCAT"
else
   echo "Will not generate localization files"
fi

echo ""
if test "x${HELP_ENABLE}" = "xyes"; then
   echo "Documentation building configuration:"
   echo "  Docbook XSL path ....... = $DOCBOOK_ROOT"
   echo "  Saxon XSLT ............. = $SAXON"
   echo "  XML commons external ... = $XML_APIS_EXT"
else
   echo "No documentation generated"
fi

echo ""
echo "Java Configuration:"
if test ! -z "$JAVAC"; then
	echo "  JAVA_HOME ........... = $JAVA_HOME"
	echo "  JAVAC ............... = $JAVAC"
	echo "  JAVA_CLASSPATH ...... = $JAVA_CLASSPATH"
	echo "  JAVA_VERSION ........ = $JAVA_VERSION"
	echo "  JAVAC_FLAGS ......... = $JAVAC_FLAGS"
	echo "  JAVA_JNI_INCLUDE .... = $JAVA_JNI_INCLUDE"
	echo "  JAVA_JNI_LIBS ....... = $JAVA_JNI_LIBS"
	echo "  JAVA_JNI_LIBS_PRELOAD = $JAVA_JNI_LIBS_PRELOAD"
	echo "  JAVA ................ = $JAVA"
	echo "  JAVADOC ............. = $JAVADOC"
	echo "  JAR ................. = $JAR"
	echo "  ANT ................. = $ANT"
else
	echo "  JAVA disabled"
fi

echo ""
echo "Java dependencies:"
if test ! -z "$JAVAC"; then
	echo "  Flexdock ............ = $FLEXDOCK"
	echo "  JOGL 2............... = $JOGL2"
	echo "  JOGL 2 LIBS (JNI) ... = $JOGL2_LIBS"
	echo "  Gluegen 2 ........... = $GLUEGEN2_RT"
	echo "  Gluegen 2 LIBS (JNI)  = $GLUEGEN2_RT_LIBS"
	echo "  Jeuclid (MathML) .... = $JEUCLID_CORE"
	echo "  Jhall  .............. = $JHALL"
	echo "  Jrosetta (API) ...... = $JROSETTA_API"
	echo "  Jrosetta (Engine) ... = $JROSETTA_ENGINE"
	echo "  Commons Logging ..... = $COMMONS_LOGGING"
	echo "  JGraph X ............ = $JGRAPHX"
	echo "  SciRenderer ......... = $SCIRENDERER"
	echo "  JLaTeXMath .......... = $JLATEXMATH"
else
	echo "  JAVA disabled"
fi

echo ""
echo "Java documentation, graphic export:"
if test ! -z "$JAVAC"; then
	echo "  FOP (XML => PDF) .... = $FOP"
	echo "  JLaTeXMath Fop ...... = $JLATEXMATH_FOP"
	echo "  Batik (SVG) ......... = $BATIK"
	echo "  Avalon Framework .... = $AVALON_FRAMEWORK"
	echo "  Commons I/O ......... = $COMMONS_IO"
	echo "  XML graphics commons  = $XMLGRAPHICS_COMMONS"
else
	echo "  JAVA disabled, so documentation disabled as well"
fi

echo ""
echo "Code quality (optional):"
echo "  Checkstyle .......... = $CHECKSTYLE"
echo "  Commons-beanutils ... = $COMMONS_BEANUTILS"
echo "  Antlr ............... = $ANTLR"
echo "  Junit4 .............. = $JUNIT4"
echo "  Cobertura ........... = $COBERTURA"
echo "  astyle .............. = $ASTYLE"
echo "  splint .............. = $SPLINT"

echo ""
echo "TCL/TK configuration:"
echo "  TK_INC_PATH ........ = $TK_INC_PATH"
echo "  TCL_INC_PATH ....... = $TCL_INC_PATH"
echo "  TCLTK_LIBS ......... = $TCLTK_LIBS"
echo "  TCL_SERIAL_VERSION . = $TCL_SERIAL_VERSION"
echo "  TK_SERIAL_VERSION .. = $TK_SERIAL_VERSION"

echo ""
echo "XML configuration:"
echo "  XML_FLAGS .......... = $XML_FLAGS"
echo "  XML_LIBS ........... = $XML_LIBS"
echo "  XML_VERSION ........ = $XML_VERSION"

echo ""
echo "HDF5 configuration:"
echo "  HDF5 CFLAGS ......... = $HDF5_CFLAGS"
echo "  HDF5 LIBS ........... = $HDF5_LIBS"

echo ""
echo "PCRE configuration:"
echo "  PCRE_CFLAGS ........ = $PCRE_CFLAGS"
echo "  PCRE_LIBS .......... = $PCRE_LIBS"
echo "  PCRE_VERSION ....... = $PCRE_VERSION"


echo ""
echo "SWIG Configuration:"
if test ! -z "$SWIG_BIN"; then
	echo "  SWIG_BIN ........... = $SWIG_BIN"
	echo "  SWIG_JAVA .......... = $SWIG_JAVA"
	echo "  SWIG_CXX ........... = $SWIG_CXX"
else
	echo "  SWIG generation disabled"
fi

echo ""
echo "GIWS Configuration:"
if test ! -z "$GIWS_BIN"; then
	echo "  GIWS_BIN ........... = $GIWS_BIN"
else
	echo "  GIWS generation disabled"
fi

echo ""
echo "Libtool config:"
echo "  objext .............. = $objext"
echo "  libext (static) ..... = $libext"
echo "  shrext_cmds ......... = $shrext_cmds"
echo "  exeext .............. = $exeext"

echo ""

echo "Compilation paths:"
echo "  srcdir .............. = $SCI_SRCDIR"
echo "  srcdir_full ......... = $SCI_SRCDIR_FULL"
echo "  builddir ............ = $SCI_BUILDDIR"
if test "x${SCI_SRCDIR_FULL}" != "x${SCI_BUILDDIR}"; then
	echo "  VPATH build ......... = Activated"
fi

echo ""
echo "Platform informations:"
echo "  host ........... = $host"
echo "  host_cpu ....... = $host_cpu"
echo "  host_vendor .... = $host_vendor"
echo "  host_os ... .... = $host_os"
echo "  hostname ....... = $ac_hostname"
echo "  CPU 64 bits .... = $IS_64_BITS_CPU"
if test -n "${MAC_DETECTED_ARCH}"; then
	echo "  Mac OS X arch .. = $MAC_DETECTED_ARCH"
	echo "  Mac OS X version = $macosx_version"
fi

echo ""
echo "Options used to compile and link:"
echo "  prefix ......... = $prefix"
echo "  localedir ...... = $localedir"
echo "  VERSION ........ = $PACKAGE_VERSION"
echo "  CC ............. = $CC"
echo "  CFLAGS ......... = $CFLAGS"
echo "  SCI_CFLAGS ..... = $SCI_CFLAGS"
echo "  CPPFLAGS ....... = $CPPFLAGS"
echo "  DEFS ........... = $DEFS"
echo "  LD ............. = $LD"
echo "  LDFLAGS ........ = $LDFLAGS"
echo "  SCI_LDFLAGS .... = $SCI_LDFLAGS"
echo "  LIBS ........... = $LIBS"
echo "  CXX ............ = $CXX"
echo "  CXXFLAGS ....... = $CXXFLAGS"
echo "  SCI_CXXFLAGS ... = $SCI_CXXFLAGS"
echo "  F77 ............ = $F77"
echo "  FFLAGS ......... = $FFLAGS"
echo "  SCI_FFLAGS ..... = $SCI_FFLAGS"
echo "  F77_LDFLAGS .... = $F77_LDFLAGS"
echo "  TERMCAP_LIB .... = $TERMCAP_LIB"
echo ""
