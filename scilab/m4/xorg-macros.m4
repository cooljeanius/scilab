dnl# xorg-macros.m4 serial 115
dnl# Originally generated from xorg-macros.m4.in xorgversion.m4 by configure.
dnl#
dnl# Copyright (c) 2005-2006, Oracle and/or its affiliates. All rights reserved.
dnl#
dnl# Permission is hereby granted, free of charge, to any person obtaining a
dnl# copy of this software and associated documentation files (the "Software"),
dnl# to deal in the Software without restriction, including without limitation
dnl# the rights to use, copy, modify, merge, publish, distribute, sublicense,
dnl# and/or sell copies of the Software, and to permit persons to whom the
dnl# Software is furnished to do so, subject to the following conditions:
dnl#
dnl# The above copyright notice and this permission notice (including the next
dnl# paragraph) shall be included in all copies or substantial portions of the
dnl# Software.
dnl#
dnl# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
dnl# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
dnl# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
dnl# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
dnl# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
dnl# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
dnl# DEALINGS IN THE SOFTWARE.

# XORG_MACROS_VERSION(required-version)
# -------------------------------------
# Minimum version: 1.1.0
#
# If you are using a macro added in Version 1.1 or newer, include this in
# your configure.ac with the minimum required version, such as:
# XORG_MACROS_VERSION(1.1)
#
# To ensure that this macro is defined, also add:
# m4_ifndef([XORG_MACROS_VERSION],
#     [m4_fatal([must install xorg-macros 1.1 or later before running autoconf/autogen])])
#
#
# See the "minimum version" comment for each macro you use to see what 
# version you require.
m4_defun([XORG_MACROS_VERSION],[
m4_define([vers_have], [1.17])
m4_define([maj_have], m4_substr(vers_have, 0, m4_index(vers_have, [.])))
m4_define([maj_needed], m4_substr([$1], 0, m4_index([$1], [.])))
m4_if(m4_cmp(maj_have, maj_needed), 0,,
    [m4_fatal([xorg-macros major version ]maj_needed[ is required but ]vers_have[ found])])
m4_if(m4_version_compare(vers_have, [$1]), -1,
    [m4_fatal([xorg-macros version $1 or higher is required but ]vers_have[ found])])
m4_undefine([vers_have])
m4_undefine([maj_have])
m4_undefine([maj_needed])
])dnl# XORG_MACROS_VERSION

# XORG_PROG_RAWCPP()
# ------------------
# Minimum version: 1.0.0
#
# Find cpp program and necessary flags for use in pre-processing text files
# such as man pages and config files
AC_DEFUN([XORG_PROG_RAWCPP],[
AC_REQUIRE([AC_PROG_CPP])
AC_PATH_PROGS([RAWCPP],[cpp],[${CPP}], 
   [$PATH:/bin:/usr/bin:/usr/lib:/usr/libexec:/usr/ccs/lib:/usr/ccs/lbin:/lib])

# Check for flag to avoid builtin definitions - assumes unix is predefined,
# which is not the best choice for supporting other OS'es, but covers most
# of the ones we need for now.
AC_MSG_CHECKING([if $RAWCPP requires -undef])
AC_LANG_CONFTEST([AC_LANG_SOURCE([[Does cpp redefine unix ?]])])
if test `${RAWCPP} < conftest.$ac_ext | grep -c 'unix'` -eq 1 ; then
	AC_MSG_RESULT([no])
else
	if test `${RAWCPP} -undef < conftest.$ac_ext | grep -c 'unix'` -eq 1 ; then
		RAWCPPFLAGS=-undef
		AC_MSG_RESULT([yes])
	# under Cygwin unix is still defined even with -undef
	elif test `${RAWCPP} -undef -ansi < conftest.$ac_ext | grep -c 'unix'` -eq 1 ; then
		RAWCPPFLAGS="-undef -ansi"
		AC_MSG_RESULT([yes, with -ansi])
	else
		AC_MSG_ERROR([${RAWCPP} defines unix with or without -undef; dunno what to do.])
	fi
fi
rm -f conftest.$ac_ext

AC_MSG_CHECKING([if $RAWCPP requires -traditional])
AC_LANG_CONFTEST([AC_LANG_SOURCE([[Does cpp preserve   "whitespace"?]])])
if test `${RAWCPP} < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
	AC_MSG_RESULT([no])
else
	if test `${RAWCPP} -traditional < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
		RAWCPPFLAGS="${RAWCPPFLAGS} -traditional"
		AC_MSG_RESULT([yes])
	else
		AC_MSG_ERROR([${RAWCPP} does not preserve whitespace with or without -traditional; dunno what to do.])
	fi
fi
rm -f conftest.$ac_ext
AC_SUBST([RAWCPPFLAGS])
])dnl# XORG_PROG_RAWCPP

# XORG_MANPAGE_SECTIONS()
# -----------------------
# Minimum version: 1.0.0
#
# Determine which sections man pages go in for the different man page types
# on this OS - replaces *ManSuffix settings in old Imake *.cf per-os files.
# Not sure if there's any better way than just hardcoding by OS name.
# Override default settings by setting environment variables
# Added MAN_SUBSTS in version 1.8
# Added AC_PROG_SED in version 1.8

AC_DEFUN([XORG_MANPAGE_SECTIONS],[
AC_REQUIRE([AC_CANONICAL_HOST])
AC_REQUIRE([AC_PROG_SED])

if test x$APP_MAN_SUFFIX = x    ; then
    APP_MAN_SUFFIX=1
fi
if test x$APP_MAN_DIR = x    ; then
    APP_MAN_DIR='$(mandir)/man$(APP_MAN_SUFFIX)'
fi

if test x$LIB_MAN_SUFFIX = x    ; then
    LIB_MAN_SUFFIX=3
fi
if test x$LIB_MAN_DIR = x    ; then
    LIB_MAN_DIR='$(mandir)/man$(LIB_MAN_SUFFIX)'
fi

if test x$FILE_MAN_SUFFIX = x    ; then
    case $host_os in
	solaris*)	FILE_MAN_SUFFIX=4  ;;
	*)		FILE_MAN_SUFFIX=5  ;;
    esac
fi
if test x$FILE_MAN_DIR = x    ; then
    FILE_MAN_DIR='$(mandir)/man$(FILE_MAN_SUFFIX)'
fi

if test x$MISC_MAN_SUFFIX = x    ; then
    case $host_os in
	solaris*)	MISC_MAN_SUFFIX=5  ;;
	*)		MISC_MAN_SUFFIX=7  ;;
    esac
fi
if test x$MISC_MAN_DIR = x    ; then
    MISC_MAN_DIR='$(mandir)/man$(MISC_MAN_SUFFIX)'
fi

if test x$DRIVER_MAN_SUFFIX = x    ; then
    case $host_os in
	solaris*)	DRIVER_MAN_SUFFIX=7  ;;
	*)		DRIVER_MAN_SUFFIX=4  ;;
    esac
fi
if test x$DRIVER_MAN_DIR = x    ; then
    DRIVER_MAN_DIR='$(mandir)/man$(DRIVER_MAN_SUFFIX)'
fi

if test x$ADMIN_MAN_SUFFIX = x    ; then
    case $host_os in
	solaris*)	ADMIN_MAN_SUFFIX=1m ;;
	*)		ADMIN_MAN_SUFFIX=8  ;;
    esac
fi
if test x$ADMIN_MAN_DIR = x    ; then
    ADMIN_MAN_DIR='$(mandir)/man$(ADMIN_MAN_SUFFIX)'
fi


AC_SUBST([APP_MAN_SUFFIX])
AC_SUBST([LIB_MAN_SUFFIX])
AC_SUBST([FILE_MAN_SUFFIX])
AC_SUBST([MISC_MAN_SUFFIX])
AC_SUBST([DRIVER_MAN_SUFFIX])
AC_SUBST([ADMIN_MAN_SUFFIX])
AC_SUBST([APP_MAN_DIR])
AC_SUBST([LIB_MAN_DIR])
AC_SUBST([FILE_MAN_DIR])
AC_SUBST([MISC_MAN_DIR])
AC_SUBST([DRIVER_MAN_DIR])
AC_SUBST([ADMIN_MAN_DIR])

XORG_MAN_PAGE="X Version 11"
AC_SUBST([XORG_MAN_PAGE])
MAN_SUBSTS="\
	-e 's|__vendorversion__|\"\$(PACKAGE_STRING)\" \"\$(XORG_MAN_PAGE)\"|' \
	-e 's|__xorgversion__|\"\$(PACKAGE_STRING)\" \"\$(XORG_MAN_PAGE)\"|' \
	-e 's|__xservername__|Xorg|g' \
	-e 's|__xconfigfile__|xorg.conf|g' \
	-e 's|__projectroot__|\$(prefix)|g' \
	-e 's|__apploaddir__|\$(appdefaultdir)|g' \
	-e 's|__appmansuffix__|\$(APP_MAN_SUFFIX)|g' \
	-e 's|__drivermansuffix__|\$(DRIVER_MAN_SUFFIX)|g' \
	-e 's|__adminmansuffix__|\$(ADMIN_MAN_SUFFIX)|g' \
	-e 's|__libmansuffix__|\$(LIB_MAN_SUFFIX)|g' \
	-e 's|__miscmansuffix__|\$(MISC_MAN_SUFFIX)|g' \
	-e 's|__filemansuffix__|\$(FILE_MAN_SUFFIX)|g'"
AC_SUBST([MAN_SUBSTS])

])dnl# XORG_MANPAGE_SECTIONS

# XORG_CHECK_SGML_DOCTOOLS([MIN-VERSION])
# ------------------------
# Minimum version: 1.7.0
#
# Defines the variable XORG_SGML_PATH containing the location of X11/defs.ent
# provided by xorg-sgml-doctools, if installed.
AC_DEFUN([XORG_CHECK_SGML_DOCTOOLS],[
AC_MSG_CHECKING([for X.Org SGML entities m4_ifval([$1],[>= $1])])
XORG_SGML_PATH=
PKG_CHECK_EXISTS([xorg-sgml-doctools m4_ifval([$1],[>= $1])],
    [XORG_SGML_PATH=`$PKG_CONFIG --variable=sgmlrootdir xorg-sgml-doctools`],
    [m4_ifval([$1],[:],
        [if test x"$cross_compiling" != x"yes" ; then
            AC_CHECK_FILE([$prefix/share/sgml/X11/defs.ent],
                          [XORG_SGML_PATH=$prefix/share/sgml])
         fi])
    ])

# Define variables STYLESHEET_SRCDIR and XSL_STYLESHEET containing
# the path and the name of the doc stylesheet
if test "x$XORG_SGML_PATH" != "x" ; then
   AC_MSG_RESULT([$XORG_SGML_PATH])
   STYLESHEET_SRCDIR=$XORG_SGML_PATH/X11
   XSL_STYLESHEET=$STYLESHEET_SRCDIR/xorg.xsl
else
   AC_MSG_RESULT([no])
fi

AC_SUBST(XORG_SGML_PATH)
AC_SUBST(STYLESHEET_SRCDIR)
AC_SUBST(XSL_STYLESHEET)
AM_CONDITIONAL([HAVE_STYLESHEETS], [test "x$XSL_STYLESHEET" != "x"])
])dnl# XORG_CHECK_SGML_DOCTOOLS

# XORG_CHECK_LINUXDOC
# -------------------
# Minimum version: 1.0.0
#
# Defines the variable MAKE_TEXT if the necessary tools and
# files are found. $(MAKE_TEXT) blah.sgml will then produce blah.txt.
# Whether or not the necessary tools and files are found can be checked
# with the AM_CONDITIONAL "BUILD_LINUXDOC"
AC_DEFUN([XORG_CHECK_LINUXDOC],[
AC_REQUIRE([XORG_CHECK_SGML_DOCTOOLS])
AC_REQUIRE([XORG_WITH_PS2PDF])

AC_PATH_PROG(LINUXDOC, linuxdoc)

AC_MSG_CHECKING([whether to build documentation])

if test x$XORG_SGML_PATH != x && test x$LINUXDOC != x ; then
   BUILDDOC=yes
else
   BUILDDOC=no
fi

AM_CONDITIONAL(BUILD_LINUXDOC, [test x$BUILDDOC = xyes])

AC_MSG_RESULT([$BUILDDOC])

AC_MSG_CHECKING([whether to build pdf documentation])

if test x$have_ps2pdf != xno && test x$BUILD_PDFDOC != xno; then
   BUILDPDFDOC=yes
else
   BUILDPDFDOC=no
fi

AM_CONDITIONAL(BUILD_PDFDOC, [test x$BUILDPDFDOC = xyes])

AC_MSG_RESULT([$BUILDPDFDOC])

MAKE_TEXT="SGML_SEARCH_PATH=$XORG_SGML_PATH GROFF_NO_SGR=y $LINUXDOC -B txt -f"
MAKE_PS="SGML_SEARCH_PATH=$XORG_SGML_PATH $LINUXDOC -B latex --papersize=letter --output=ps"
MAKE_PDF="$PS2PDF"
MAKE_HTML="SGML_SEARCH_PATH=$XORG_SGML_PATH $LINUXDOC  -B html --split=0"

AC_SUBST(MAKE_TEXT)
AC_SUBST(MAKE_PS)
AC_SUBST(MAKE_PDF)
AC_SUBST(MAKE_HTML)
])dnl# XORG_CHECK_LINUXDOC

# XORG_CHECK_DOCBOOK
# -------------------
# Minimum version: 1.0.0
#
# Checks for the ability to build output formats from SGML DocBook source.
# For XXX in {TXT, PDF, PS, HTML}, the AM_CONDITIONAL "BUILD_XXXDOC"
# indicates whether the necessary tools and files are found and, if set,
# $(MAKE_XXX) blah.sgml will produce blah.xxx.
AC_DEFUN([XORG_CHECK_DOCBOOK],[
AC_REQUIRE([XORG_CHECK_SGML_DOCTOOLS])

BUILDTXTDOC=no
BUILDPDFDOC=no
BUILDPSDOC=no
BUILDHTMLDOC=no

AC_PATH_PROG(DOCBOOKPS, docbook2ps)
AC_PATH_PROG(DOCBOOKPDF, docbook2pdf)
AC_PATH_PROG(DOCBOOKHTML, docbook2html)
AC_PATH_PROG(DOCBOOKTXT, docbook2txt)

AC_MSG_CHECKING([whether to build text documentation])
if test x$XORG_SGML_PATH != x && test x$DOCBOOKTXT != x &&
   test x$BUILD_TXTDOC != xno; then
	BUILDTXTDOC=yes
fi
AM_CONDITIONAL(BUILD_TXTDOC, [test x$BUILDTXTDOC = xyes])
AC_MSG_RESULT([$BUILDTXTDOC])

AC_MSG_CHECKING([whether to build PDF documentation])
if test x$XORG_SGML_PATH != x && test x$DOCBOOKPDF != x &&
   test x$BUILD_PDFDOC != xno; then
	BUILDPDFDOC=yes
fi
AM_CONDITIONAL(BUILD_PDFDOC, [test x$BUILDPDFDOC = xyes])
AC_MSG_RESULT([$BUILDPDFDOC])

AC_MSG_CHECKING([whether to build PostScript documentation])
if test x$XORG_SGML_PATH != x && test x$DOCBOOKPS != x &&
   test x$BUILD_PSDOC != xno; then
	BUILDPSDOC=yes
fi
AM_CONDITIONAL(BUILD_PSDOC, [test x$BUILDPSDOC = xyes])
AC_MSG_RESULT([$BUILDPSDOC])

AC_MSG_CHECKING([whether to build HTML documentation])
if test x$XORG_SGML_PATH != x && test x$DOCBOOKHTML != x &&
   test x$BUILD_HTMLDOC != xno; then
	BUILDHTMLDOC=yes
fi
AM_CONDITIONAL(BUILD_HTMLDOC, [test x$BUILDHTMLDOC = xyes])
AC_MSG_RESULT([$BUILDHTMLDOC])

MAKE_TEXT="SGML_SEARCH_PATH=$XORG_SGML_PATH $DOCBOOKTXT"
MAKE_PS="SGML_SEARCH_PATH=$XORG_SGML_PATH $DOCBOOKPS"
MAKE_PDF="SGML_SEARCH_PATH=$XORG_SGML_PATH $DOCBOOKPDF"
MAKE_HTML="SGML_SEARCH_PATH=$XORG_SGML_PATH $DOCBOOKHTML"

AC_SUBST(MAKE_TEXT)
AC_SUBST(MAKE_PS)
AC_SUBST(MAKE_PDF)
AC_SUBST(MAKE_HTML)
])dnl# XORG_CHECK_DOCBOOK

# XORG_WITH_XMLTO([MIN-VERSION], [DEFAULT])
# ----------------
# Minimum version: 1.5.0
# Minimum version for optional DEFAULT argument: 1.11.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-xmlto option, it allows maximum flexibilty in making decisions
# as whether or not to use the xmlto package. When DEFAULT is not specified,
# --with-xmlto assumes 'auto'.
#
# Interface to module:
# HAVE_XMLTO: 	used in makefiles to conditionally generate documentation
# XMLTO:	returns the path of the xmlto program found
#		returns the path set by the user in the environment
# --with-xmlto:	'yes' user instructs the module to use xmlto
#		'no' user instructs the module not to use xmlto
#
# Added in version 1.10.0
# HAVE_XMLTO_TEXT: used in makefiles to conditionally generate text documentation
#                  xmlto for text output requires either lynx, links, or w3m browsers
#
# If the user sets the value of XMLTO, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_XMLTO],[
AC_ARG_VAR([XMLTO], [Path to xmlto command])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(xmlto,
	AS_HELP_STRING([--with-xmlto],
	   [Use xmlto to regenerate documentation (default: ]_defopt[)]),
	   [use_xmlto=$withval], [use_xmlto=]_defopt)
m4_undefine([_defopt])

if test "x$use_xmlto" = x"auto"; then
   AC_PATH_PROG([XMLTO], [xmlto])
   if test "x$XMLTO" = "x"; then
        AC_MSG_WARN([xmlto not found - documentation targets will be skipped])
	have_xmlto=no
   else
        have_xmlto=yes
   fi
elif test "x$use_xmlto" = x"yes" ; then
   AC_PATH_PROG([XMLTO], [xmlto])
   if test "x$XMLTO" = "x"; then
        AC_MSG_ERROR([--with-xmlto=yes specified but xmlto not found in PATH])
   fi
   have_xmlto=yes
elif test "x$use_xmlto" = x"no" ; then
   if test "x$XMLTO" != "x"; then
      AC_MSG_WARN([ignoring XMLTO environment variable since --with-xmlto=no was specified])
   fi
   have_xmlto=no
else
   AC_MSG_ERROR([--with-xmlto expects 'yes' or 'no'])
fi

# Test for a minimum version of xmlto, if provided.
m4_ifval([$1],
[if test "$have_xmlto" = yes; then
    # scrape the xmlto version
    AC_MSG_CHECKING([the xmlto version])
    xmlto_version=`$XMLTO --version 2>/dev/null | cut -d' ' -f3`
    AC_MSG_RESULT([$xmlto_version])
    AS_VERSION_COMPARE([$xmlto_version], [$1],
        [if test "x$use_xmlto" = xauto; then
            AC_MSG_WARN([xmlto version $xmlto_version found, but $1 needed])
            have_xmlto=no
        else
            AC_MSG_ERROR([xmlto version $xmlto_version found, but $1 needed])
        fi])
fi])

# Test for the ability of xmlto to generate a text target
have_xmlto_text=no
cat > conftest.xml << "EOF"
EOF
AS_IF([test "$have_xmlto" = yes],
      [AS_IF([$XMLTO --skip-validation txt conftest.xml >/dev/null 2>&1],
             [have_xmlto_text=yes],
             [AC_MSG_WARN([xmlto cannot generate text format, this format skipped])])])
rm -f conftest.xml
AM_CONDITIONAL([HAVE_XMLTO_TEXT], [test $have_xmlto_text = yes])
AM_CONDITIONAL([HAVE_XMLTO], [test "$have_xmlto" = yes])
])dnl# XORG_WITH_XMLTO

# XORG_WITH_XSLTPROC([MIN-VERSION], [DEFAULT])
# --------------------------------------------
# Minimum version: 1.12.0
# Minimum version for optional DEFAULT argument: 1.12.0
#
# XSLT (Extensible Stylesheet Language Transformations) is a declarative,
# XML-based language used for the transformation of XML documents.
# The xsltproc command line tool is for applying XSLT stylesheets to XML documents.
# It is used under the cover by xmlto to generate html files from DocBook/XML.
# The XSLT processor is often used as a standalone tool for transformations.
# It should not be assumed that this tool is used only to work with documnetation.
# When DEFAULT is not specified, --with-xsltproc assumes 'auto'.
#
# Interface to module:
# HAVE_XSLTPROC: used in makefiles to conditionally generate documentation
# XSLTPROC:	 returns the path of the xsltproc program found
#		 returns the path set by the user in the environment
# --with-xsltproc: 'yes' user instructs the module to use xsltproc
#		  'no' user instructs the module not to use xsltproc
# have_xsltproc: returns yes if xsltproc found in PATH or no
#
# If the user sets the value of XSLTPROC, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_XSLTPROC],[
AC_ARG_VAR([XSLTPROC], [Path to xsltproc command])
# Preserves the interface, should it be implemented later
m4_ifval([$1], [m4_warn([syntax], [Checking for xsltproc MIN-VERSION is not implemented])])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(xsltproc,
	AS_HELP_STRING([--with-xsltproc],
	   [Use xsltproc for the transformation of XML documents (default: ]_defopt[)]),
	   [use_xsltproc=$withval], [use_xsltproc=]_defopt)
m4_undefine([_defopt])

if test "x$use_xsltproc" = x"auto"; then
   AC_PATH_PROG([XSLTPROC], [xsltproc])
   if test "x$XSLTPROC" = "x"; then
        AC_MSG_WARN([xsltproc not found - cannot transform XML documents])
	have_xsltproc=no
   else
        have_xsltproc=yes
   fi
elif test "x$use_xsltproc" = x"yes" ; then
   AC_PATH_PROG([XSLTPROC], [xsltproc])
   if test "x$XSLTPROC" = "x"; then
        AC_MSG_ERROR([--with-xsltproc=yes specified but xsltproc not found in PATH])
   fi
   have_xsltproc=yes
elif test "x$use_xsltproc" = x"no" ; then
   if test "x$XSLTPROC" != "x"; then
      AC_MSG_WARN([ignoring XSLTPROC environment variable since --with-xsltproc=no was specified])
   fi
   have_xsltproc=no
else
   AC_MSG_ERROR([--with-xsltproc expects 'yes' or 'no'])
fi

AM_CONDITIONAL([HAVE_XSLTPROC], [test "$have_xsltproc" = yes])
])dnl# XORG_WITH_XSLTPROC

# XORG_WITH_PERL([MIN-VERSION], [DEFAULT])
# ----------------------------------------
# Minimum version: 1.15.0
#
# PERL (Practical Extraction and Report Language) is a language optimized for
# scanning arbitrary text files, extracting information from those text files,
# and printing reports based on that information.
#
# When DEFAULT is not specified, --with-perl assumes 'auto'.
#
# Interface to module:
# HAVE_PERL: used in makefiles to conditionally scan text files
# PERL:	     returns the path of the perl program found
#	     returns the path set by the user in the environment
# --with-perl: 'yes' user instructs the module to use perl
#	       'no' user instructs the module not to use perl
# have_perl: returns yes if perl found in PATH or no
#
# If the user sets the value of PERL, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_PERL],[
AC_ARG_VAR([PERL], [Path to perl command])
# Preserves the interface, should it be implemented later
m4_ifval([$1], [m4_warn([syntax], [Checking for perl MIN-VERSION is not implemented])])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(perl,
	AS_HELP_STRING([--with-perl],
	   [Use perl for extracting information from files (default: ]_defopt[)]),
	   [use_perl=$withval], [use_perl=]_defopt)
m4_undefine([_defopt])

if test "x$use_perl" = x"auto"; then
   AC_PATH_PROG([PERL], [perl])
   if test "x$PERL" = "x"; then
        AC_MSG_WARN([perl not found - cannot extract information and report])
	have_perl=no
   else
        have_perl=yes
   fi
elif test "x$use_perl" = x"yes" ; then
   AC_PATH_PROG([PERL], [perl])
   if test "x$PERL" = "x"; then
        AC_MSG_ERROR([--with-perl=yes specified but perl not found in PATH])
   fi
   have_perl=yes
elif test "x$use_perl" = x"no" ; then
   if test "x$PERL" != "x"; then
      AC_MSG_WARN([ignoring PERL environment variable since --with-perl=no was specified])
   fi
   have_perl=no
else
   AC_MSG_ERROR([--with-perl expects 'yes' or 'no'])
fi

AM_CONDITIONAL([HAVE_PERL], [test "$have_perl" = yes])
])dnl# XORG_WITH_PERL

# XORG_WITH_ASCIIDOC([MIN-VERSION], [DEFAULT])
# ----------------
# Minimum version: 1.5.0
# Minimum version for optional DEFAULT argument: 1.11.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-asciidoc option, it allows maximum flexibilty in making decisions
# as whether or not to use the asciidoc package. When DEFAULT is not specified,
# --with-asciidoc assumes 'auto'.
#
# Interface to module:
# HAVE_ASCIIDOC: used in makefiles to conditionally generate documentation
# ASCIIDOC:	 returns the path of the asciidoc program found
#		 returns the path set by the user in the environment
# --with-asciidoc: 'yes' user instructs the module to use asciidoc
#		  'no' user instructs the module not to use asciidoc
#
# If the user sets the value of ASCIIDOC, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_ASCIIDOC],[
AC_ARG_VAR([ASCIIDOC], [Path to asciidoc command])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(asciidoc,
	AS_HELP_STRING([--with-asciidoc],
	   [Use asciidoc to regenerate documentation (default: ]_defopt[)]),
	   [use_asciidoc=$withval], [use_asciidoc=]_defopt)
m4_undefine([_defopt])

if test "x$use_asciidoc" = x"auto"; then
   AC_PATH_PROG([ASCIIDOC], [asciidoc])
   if test "x$ASCIIDOC" = "x"; then
        AC_MSG_WARN([asciidoc not found - documentation targets will be skipped])
	have_asciidoc=no
   else
        have_asciidoc=yes
   fi
elif test "x$use_asciidoc" = x"yes" ; then
   AC_PATH_PROG([ASCIIDOC], [asciidoc])
   if test "x$ASCIIDOC" = "x"; then
        AC_MSG_ERROR([--with-asciidoc=yes specified but asciidoc not found in PATH])
   fi
   have_asciidoc=yes
elif test "x$use_asciidoc" = x"no" ; then
   if test "x$ASCIIDOC" != "x"; then
      AC_MSG_WARN([ignoring ASCIIDOC environment variable since --with-asciidoc=no was specified])
   fi
   have_asciidoc=no
else
   AC_MSG_ERROR([--with-asciidoc expects 'yes' or 'no'])
fi
m4_ifval([$1],
[if test "$have_asciidoc" = yes; then
    # scrape the asciidoc version
    AC_MSG_CHECKING([the asciidoc version])
    asciidoc_version=`$ASCIIDOC --version 2>/dev/null | cut -d' ' -f2`
    AC_MSG_RESULT([$asciidoc_version])
    AS_VERSION_COMPARE([$asciidoc_version], [$1],
        [if test "x$use_asciidoc" = xauto; then
            AC_MSG_WARN([asciidoc version $asciidoc_version found, but $1 needed])
            have_asciidoc=no
        else
            AC_MSG_ERROR([asciidoc version $asciidoc_version found, but $1 needed])
        fi])
fi])
AM_CONDITIONAL([HAVE_ASCIIDOC], [test "$have_asciidoc" = yes])
])dnl# XORG_WITH_ASCIIDOC

# XORG_WITH_DOXYGEN([MIN-VERSION], [DEFAULT])
# --------------------------------
# Minimum version: 1.5.0
# Minimum version for optional DEFAULT argument: 1.11.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-doxygen option, it allows maximum flexibilty in making decisions
# as whether or not to use the doxygen package. When DEFAULT is not specified,
# --with-doxygen assumes 'auto'.
#
# Interface to module:
# HAVE_DOXYGEN: used in makefiles to conditionally generate documentation
# DOXYGEN:	 returns the path of the doxygen program found
#		 returns the path set by the user in the environment
# --with-doxygen: 'yes' user instructs the module to use doxygen
#		  'no' user instructs the module not to use doxygen
#
# If the user sets the value of DOXYGEN, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_DOXYGEN],[
AC_ARG_VAR([DOXYGEN], [Path to doxygen command])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(doxygen,
	AS_HELP_STRING([--with-doxygen],
	   [Use doxygen to regenerate documentation (default: ]_defopt[)]),
	   [use_doxygen=$withval], [use_doxygen=]_defopt)
m4_undefine([_defopt])

if test "x$use_doxygen" = x"auto"; then
   AC_PATH_PROG([DOXYGEN], [doxygen])
   if test "x$DOXYGEN" = "x"; then
        AC_MSG_WARN([doxygen not found - documentation targets will be skipped])
	have_doxygen=no
   else
        have_doxygen=yes
   fi
elif test "x$use_doxygen" = x"yes" ; then
   AC_PATH_PROG([DOXYGEN], [doxygen])
   if test "x$DOXYGEN" = "x"; then
        AC_MSG_ERROR([--with-doxygen=yes specified but doxygen not found in PATH])
   fi
   have_doxygen=yes
elif test "x$use_doxygen" = x"no" ; then
   if test "x$DOXYGEN" != "x"; then
      AC_MSG_WARN([ignoring DOXYGEN environment variable since --with-doxygen=no was specified])
   fi
   have_doxygen=no
else
   AC_MSG_ERROR([--with-doxygen expects 'yes' or 'no'])
fi
m4_ifval([$1],
[if test "$have_doxygen" = yes; then
    # scrape the doxygen version
    AC_MSG_CHECKING([the doxygen version])
    doxygen_version=`$DOXYGEN --version 2>/dev/null`
    AC_MSG_RESULT([$doxygen_version])
    AS_VERSION_COMPARE([$doxygen_version], [$1],
        [if test "x$use_doxygen" = xauto; then
            AC_MSG_WARN([doxygen version $doxygen_version found, but $1 needed])
            have_doxygen=no
        else
            AC_MSG_ERROR([doxygen version $doxygen_version found, but $1 needed])
        fi])
fi])
AM_CONDITIONAL([HAVE_DOXYGEN], [test "$have_doxygen" = yes])
])dnl# XORG_WITH_DOXYGEN

# XORG_WITH_GROFF([DEFAULT])
# ----------------
# Minimum version: 1.6.0
# Minimum version for optional DEFAULT argument: 1.11.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-groff option, it allows maximum flexibilty in making decisions
# as whether or not to use the groff package. When DEFAULT is not specified,
# --with-groff assumes 'auto'.
#
# Interface to module:
# HAVE_GROFF:	 used in makefiles to conditionally generate documentation
# HAVE_GROFF_MM: the memorandum macros (-mm) package
# HAVE_GROFF_MS: the -ms macros package
# GROFF:	 returns the path of the groff program found
#		 returns the path set by the user in the environment
# --with-groff:	 'yes' user instructs the module to use groff
#		 'no' user instructs the module not to use groff
#
# Added in version 1.9.0:
# HAVE_GROFF_HTML: groff has dependencies to output HTML format:
#		   pnmcut pnmcrop pnmtopng pnmtops from the netpbm package.
#		   psselect from the psutils package.
#		   the ghostcript package. Refer to the grohtml man pages
#
# If the user sets the value of GROFF, AC_PATH_PROG skips testing the path.
#
# OS and distros often splits groff in a basic and full package, the former
# having the groff program and the later having devices, fonts and macros
# Checking for the groff executable is not enough.
#
# If macros are missing, we cannot assume that groff is useless, so we don't
# unset HAVE_GROFF or GROFF env variables.
# HAVE_GROFF_?? can never be true while HAVE_GROFF is false.
#
AC_DEFUN([XORG_WITH_GROFF],[
AC_ARG_VAR([GROFF], [Path to groff command])
m4_define([_defopt], m4_default([$1], [auto]))
AC_ARG_WITH(groff,
	AS_HELP_STRING([--with-groff],
	   [Use groff to regenerate documentation (default: ]_defopt[)]),
	   [use_groff=$withval], [use_groff=]_defopt)
m4_undefine([_defopt])

if test "x$use_groff" = x"auto"; then
   AC_PATH_PROG([GROFF], [groff])
   if test "x$GROFF" = "x"; then
        AC_MSG_WARN([groff not found - documentation targets will be skipped])
	have_groff=no
   else
        have_groff=yes
   fi
elif test "x$use_groff" = x"yes" ; then
   AC_PATH_PROG([GROFF], [groff])
   if test "x$GROFF" = "x"; then
        AC_MSG_ERROR([--with-groff=yes specified but groff not found in PATH])
   fi
   have_groff=yes
elif test "x$use_groff" = x"no" ; then
   if test "x$GROFF" != "x"; then
      AC_MSG_WARN([ignoring GROFF environment variable since --with-groff=no was specified])
   fi
   have_groff=no
else
   AC_MSG_ERROR([--with-groff expects 'yes' or 'no'])
fi

# We have groff, test for the presence of the macro packages
if test "x$have_groff" = x"yes"; then
    AC_MSG_CHECKING([for ${GROFF} -ms macros])
    if ${GROFF} -ms -I. /dev/null >/dev/null 2>&1 ; then
        groff_ms_works=yes
    else
        groff_ms_works=no
    fi
    AC_MSG_RESULT([$groff_ms_works])
    AC_MSG_CHECKING([for ${GROFF} -mm macros])
    if ${GROFF} -mm -I. /dev/null >/dev/null 2>&1 ; then
        groff_mm_works=yes
    else
        groff_mm_works=no
    fi
    AC_MSG_RESULT([$groff_mm_works])
fi

# We have groff, test for HTML dependencies, one command per package
if test "x$have_groff" = x"yes"; then
   AC_PATH_PROGS(GS_PATH, [gs gswin32c])
   AC_PATH_PROG(PNMTOPNG_PATH, [pnmtopng])
   AC_PATH_PROG(PSSELECT_PATH, [psselect])
   if test "x$GS_PATH" != "x" -a "x$PNMTOPNG_PATH" != "x" -a "x$PSSELECT_PATH" != "x"; then
      have_groff_html=yes
   else
      have_groff_html=no
      AC_MSG_WARN([grohtml dependencies not found - HTML Documentation skipped. Refer to grohtml man pages])
   fi
fi

# Set Automake conditionals for Makefiles
AM_CONDITIONAL([HAVE_GROFF], [test "$have_groff" = yes])
AM_CONDITIONAL([HAVE_GROFF_MS], [test "$groff_ms_works" = yes])
AM_CONDITIONAL([HAVE_GROFF_MM], [test "$groff_mm_works" = yes])
AM_CONDITIONAL([HAVE_GROFF_HTML], [test "$have_groff_html" = yes])
])dnl# XORG_WITH_GROFF

# XORG_WITH_FOP([MIN-VERSION], [DEFAULT])
# ---------------------------------------
# Minimum version: 1.6.0
# Minimum version for optional DEFAULT argument: 1.11.0
# Minimum version for optional MIN-VERSION argument: 1.15.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-fop option, it allows maximum flexibilty in making decisions
# as whether or not to use the fop package. When DEFAULT is not specified,
# --with-fop assumes 'auto'.
#
# Interface to module:
# HAVE_FOP: 	used in makefiles to conditionally generate documentation
# FOP:	 	returns the path of the fop program found
#		returns the path set by the user in the environment
# --with-fop: 	'yes' user instructs the module to use fop
#		'no' user instructs the module not to use fop
#
# If the user sets the value of FOP, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_FOP],[
AC_ARG_VAR([FOP], [Path to fop command])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(fop,
	AS_HELP_STRING([--with-fop],
	   [Use fop to regenerate documentation (default: ]_defopt[)]),
	   [use_fop=$withval], [use_fop=]_defopt)
m4_undefine([_defopt])

if test "x$use_fop" = x"auto"; then
   AC_PATH_PROG([FOP], [fop])
   if test "x$FOP" = "x"; then
        AC_MSG_WARN([fop not found - documentation targets will be skipped])
	have_fop=no
   else
        have_fop=yes
   fi
elif test "x$use_fop" = x"yes" ; then
   AC_PATH_PROG([FOP], [fop])
   if test "x$FOP" = "x"; then
        AC_MSG_ERROR([--with-fop=yes specified but fop not found in PATH])
   fi
   have_fop=yes
elif test "x$use_fop" = x"no" ; then
   if test "x$FOP" != "x"; then
      AC_MSG_WARN([ignoring FOP environment variable since --with-fop=no was specified])
   fi
   have_fop=no
else
   AC_MSG_ERROR([--with-fop expects 'yes' or 'no'])
fi

# Test for a minimum version of fop, if provided.
m4_ifval([$1],
[if test "$have_fop" = yes; then
    # scrape the fop version
    AC_MSG_CHECKING([for fop minimum version])
    fop_version=`$FOP -version 2>/dev/null | cut -d' ' -f3`
    AC_MSG_RESULT([$fop_version])
    AS_VERSION_COMPARE([$fop_version], [$1],
        [if test "x$use_fop" = xauto; then
            AC_MSG_WARN([fop version $fop_version found, but $1 needed])
            have_fop=no
        else
            AC_MSG_ERROR([fop version $fop_version found, but $1 needed])
        fi])
fi])
AM_CONDITIONAL([HAVE_FOP], [test "$have_fop" = yes])
])dnl# XORG_WITH_FOP

# XORG_WITH_PS2PDF([DEFAULT])
# ----------------
# Minimum version: 1.6.0
# Minimum version for optional DEFAULT argument: 1.11.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a module to test for the
# presence of the tool and obtain it's path in separate variables. Coupled with
# the --with-ps2pdf option, it allows maximum flexibilty in making decisions
# as whether or not to use the ps2pdf package. When DEFAULT is not specified,
# --with-ps2pdf assumes 'auto'.
#
# Interface to module:
# HAVE_PS2PDF: 	used in makefiles to conditionally generate documentation
# PS2PDF:	returns the path of the ps2pdf program found
#		returns the path set by the user in the environment
# --with-ps2pdf: 'yes' user instructs the module to use ps2pdf
#		 'no' user instructs the module not to use ps2pdf
#
# If the user sets the value of PS2PDF, AC_PATH_PROG skips testing the path.
#
AC_DEFUN([XORG_WITH_PS2PDF],[
AC_ARG_VAR([PS2PDF], [Path to ps2pdf command])
m4_define([_defopt], m4_default([$1], [auto]))
AC_ARG_WITH(ps2pdf,
	AS_HELP_STRING([--with-ps2pdf],
	   [Use ps2pdf to regenerate documentation (default: ]_defopt[)]),
	   [use_ps2pdf=$withval], [use_ps2pdf=]_defopt)
m4_undefine([_defopt])

if test "x$use_ps2pdf" = x"auto"; then
   AC_PATH_PROG([PS2PDF], [ps2pdf])
   if test "x$PS2PDF" = "x"; then
        AC_MSG_WARN([ps2pdf not found - documentation targets will be skipped])
	have_ps2pdf=no
   else
        have_ps2pdf=yes
   fi
elif test "x$use_ps2pdf" = x"yes" ; then
   AC_PATH_PROG([PS2PDF], [ps2pdf])
   if test "x$PS2PDF" = "x"; then
        AC_MSG_ERROR([--with-ps2pdf=yes specified but ps2pdf not found in PATH])
   fi
   have_ps2pdf=yes
elif test "x$use_ps2pdf" = x"no" ; then
   if test "x$PS2PDF" != "x"; then
      AC_MSG_WARN([ignoring PS2PDF environment variable since --with-ps2pdf=no was specified])
   fi
   have_ps2pdf=no
else
   AC_MSG_ERROR([--with-ps2pdf expects 'yes' or 'no'])
fi
AM_CONDITIONAL([HAVE_PS2PDF], [test "$have_ps2pdf" = yes])
])dnl# XORG_WITH_PS2PDF

# XORG_ENABLE_DOCS (enable_docs=yes)
# ----------------
# Minimum version: 1.6.0
#
# Documentation tools are not always available on all platforms and sometimes
# not at the appropriate level. This macro enables a builder to skip all
# documentation targets except traditional man pages.
# Combined with the specific tool checking macros XORG_WITH_*, it provides
# maximum flexibilty in controlling documentation building.
# Refer to:
# XORG_WITH_XMLTO         --with-xmlto
# XORG_WITH_ASCIIDOC      --with-asciidoc
# XORG_WITH_DOXYGEN       --with-doxygen
# XORG_WITH_FOP           --with-fop
# XORG_WITH_GROFF         --with-groff
# XORG_WITH_PS2PDF        --with-ps2pdf
#
# Interface to module:
# ENABLE_DOCS: 	  used in makefiles to conditionally generate documentation
# --enable-docs: 'yes' user instructs the module to generate docs
#		 'no' user instructs the module not to generate docs
# parm1:	specify the default value, yes or no.
#
AC_DEFUN([XORG_ENABLE_DOCS],[
m4_define([docs_default], m4_default([$1], [yes]))
AC_ARG_ENABLE(docs,
	AS_HELP_STRING([--enable-docs],
	   [Enable building the documentation (default: ]docs_default[)]),
	   [build_docs=$enableval], [build_docs=]docs_default)
m4_undefine([docs_default])
AM_CONDITIONAL(ENABLE_DOCS, [test x$build_docs = xyes])
AC_MSG_CHECKING([whether to build documentation])
AC_MSG_RESULT([$build_docs])
])dnl# XORG_ENABLE_DOCS

# XORG_ENABLE_DEVEL_DOCS (enable_devel_docs=yes)
# ----------------
# Minimum version: 1.6.0
#
# This macro enables a builder to skip all developer documentation.
# Combined with the specific tool checking macros XORG_WITH_*, it provides
# maximum flexibilty in controlling documentation building.
# Refer to:
# XORG_WITH_XMLTO         --with-xmlto
# XORG_WITH_ASCIIDOC      --with-asciidoc
# XORG_WITH_DOXYGEN       --with-doxygen
# XORG_WITH_FOP           --with-fop
# XORG_WITH_GROFF         --with-groff
# XORG_WITH_PS2PDF        --with-ps2pdf
#
# Interface to module:
# ENABLE_DEVEL_DOCS:	used in makefiles to conditionally generate developer docs
# --enable-devel-docs:	'yes' user instructs the module to generate developer docs
#			'no' user instructs the module not to generate developer docs
# parm1:		specify the default value, yes or no.
#
AC_DEFUN([XORG_ENABLE_DEVEL_DOCS],[
m4_define([devel_default], m4_default([$1], [yes]))
AC_ARG_ENABLE(devel-docs,
	AS_HELP_STRING([--enable-devel-docs],
	   [Enable building the developer documentation (default: ]devel_default[)]),
	   [build_devel_docs=$enableval], [build_devel_docs=]devel_default)
m4_undefine([devel_default])
AM_CONDITIONAL(ENABLE_DEVEL_DOCS, [test x$build_devel_docs = xyes])
AC_MSG_CHECKING([whether to build developer documentation])
AC_MSG_RESULT([$build_devel_docs])
])dnl# XORG_ENABLE_DEVEL_DOCS

# XORG_ENABLE_SPECS (enable_specs=yes)
# ----------------
# Minimum version: 1.6.0
#
# This macro enables a builder to skip all functional specification targets.
# Combined with the specific tool checking macros XORG_WITH_*, it provides
# maximum flexibilty in controlling documentation building.
# Refer to:
# XORG_WITH_XMLTO         --with-xmlto
# XORG_WITH_ASCIIDOC      --with-asciidoc
# XORG_WITH_DOXYGEN       --with-doxygen
# XORG_WITH_FOP           --with-fop
# XORG_WITH_GROFF         --with-groff
# XORG_WITH_PS2PDF        --with-ps2pdf
#
# Interface to module:
# ENABLE_SPECS:		used in makefiles to conditionally generate specs
# --enable-specs:	'yes' user instructs the module to generate specs
#			'no' user instructs the module not to generate specs
# parm1:		specify the default value, yes or no.
#
AC_DEFUN([XORG_ENABLE_SPECS],[
m4_define([spec_default], m4_default([$1], [yes]))
AC_ARG_ENABLE(specs,
	AS_HELP_STRING([--enable-specs],
	   [Enable building the specs (default: ]spec_default[)]),
	   [build_specs=$enableval], [build_specs=]spec_default)
m4_undefine([spec_default])
AM_CONDITIONAL(ENABLE_SPECS, [test x$build_specs = xyes])
AC_MSG_CHECKING([whether to build functional specifications])
AC_MSG_RESULT([$build_specs])
])dnl# XORG_ENABLE_SPECS

# XORG_ENABLE_UNIT_TESTS (enable_unit_tests=auto)
# ----------------------------------------------
# Minimum version: 1.13.0
#
# This macro enables a builder to enable/disable unit testing
# It makes no assumption about the test cases implementation
# Test cases may or may not use Automake "Support for test suites"
# They may or may not use the software utility library GLib
#
# When used in conjunction with XORG_WITH_GLIB, use both AM_CONDITIONAL
# ENABLE_UNIT_TESTS and HAVE_GLIB. Not all unit tests may use glib.
# The variable enable_unit_tests is used by other macros in this file.
#
# Interface to module:
# ENABLE_UNIT_TESTS:	used in makefiles to conditionally build tests
# enable_unit_tests:    used in configure.ac for additional configuration
# --enable-unit-tests:	'yes' user instructs the module to build tests
#			'no' user instructs the module not to build tests
# parm1:		specify the default value, yes or no.
#
AC_DEFUN([XORG_ENABLE_UNIT_TESTS],[
AC_BEFORE([$0], [XORG_WITH_GLIB])
AC_BEFORE([$0], [XORG_LD_WRAP])
AC_REQUIRE([XORG_MEMORY_CHECK_FLAGS])
m4_define([_defopt], m4_default([$1], [auto]))
AC_ARG_ENABLE(unit-tests, AS_HELP_STRING([--enable-unit-tests],
	[Enable building unit test cases (default: ]_defopt[)]),
	[enable_unit_tests=$enableval], [enable_unit_tests=]_defopt)
m4_undefine([_defopt])
AM_CONDITIONAL(ENABLE_UNIT_TESTS, [test "x$enable_unit_tests" != xno])
AC_MSG_CHECKING([whether to build unit test cases])
AC_MSG_RESULT([$enable_unit_tests])
])dnl# XORG_ENABLE_UNIT_TESTS

# XORG_ENABLE_INTEGRATION_TESTS (enable_unit_tests=auto)
# ------------------------------------------------------
# Minimum version: 1.17.0
#
# This macro enables a builder to enable/disable integration testing
# It makes no assumption about the test cases' implementation
# Test cases may or may not use Automake "Support for test suites"
#
# Please see XORG_ENABLE_UNIT_TESTS for unit test support. Unit test support
# usually requires less dependencies and may be built and run under less
# stringent environments than integration tests.
#
# Interface to module:
# ENABLE_INTEGRATION_TESTS:   used in makefiles to conditionally build tests
# enable_integration_tests:   used in configure.ac for additional configuration
# --enable-integration-tests: 'yes' user instructs the module to build tests
#                             'no' user instructs the module not to build tests
# parm1:                      specify the default value, yes or no.
#
AC_DEFUN([XORG_ENABLE_INTEGRATION_TESTS],[
AC_REQUIRE([XORG_MEMORY_CHECK_FLAGS])
m4_define([_defopt], m4_default([$1], [auto]))
AC_ARG_ENABLE(integration-tests, AS_HELP_STRING([--enable-integration-tests],
	[Enable building integration test cases (default: ]_defopt[)]),
	[enable_integration_tests=$enableval],
	[enable_integration_tests=]_defopt)
m4_undefine([_defopt])
AM_CONDITIONAL([ENABLE_INTEGRATION_TESTS],
	[test "x$enable_integration_tests" != xno])
AC_MSG_CHECKING([whether to build unit test cases])
AC_MSG_RESULT([$enable_integration_tests])
])dnl# XORG_ENABLE_INTEGRATION_TESTS

# XORG_WITH_GLIB([MIN-VERSION], [DEFAULT])
# ----------------------------------------
# Minimum version: 1.13.0
#
# GLib is a library which provides advanced data structures and functions.
# This macro enables a module to test for the presence of Glib.
#
# When used with ENABLE_UNIT_TESTS, it is assumed GLib is used for unit testing.
# Otherwise the value of $enable_unit_tests is blank.
#
# Please see XORG_ENABLE_INTEGRATION_TESTS for integration test support. Unit
# test support usually requires less dependencies and may be built and run under
# less stringent environments than integration tests.
#
# Interface to module:
# HAVE_GLIB: used in makefiles to conditionally build targets
# with_glib: used in configure.ac to know if GLib has been found
# --with-glib:	'yes' user instructs the module to use glib
#		'no' user instructs the module not to use glib
#
AC_DEFUN([XORG_WITH_GLIB],[
AC_REQUIRE([PKG_PROG_PKG_CONFIG])
m4_define([_defopt], m4_default([$2], [auto]))
AC_ARG_WITH(glib, AS_HELP_STRING([--with-glib],
	[Use GLib library for unit testing (default: ]_defopt[)]),
	[with_glib=$withval], [with_glib=]_defopt)
m4_undefine([_defopt])

have_glib=no
# Do not probe GLib if user explicitly disabled unit testing
if test "x$enable_unit_tests" != x"no"; then
  # Do not probe GLib if user explicitly disabled it
  if test "x$with_glib" != x"no"; then
    m4_ifval(
      [$1],
      [PKG_CHECK_MODULES([GLIB], [glib-2.0 >= $1], [have_glib=yes], [have_glib=no])],
      [PKG_CHECK_MODULES([GLIB], [glib-2.0], [have_glib=yes], [have_glib=no])]
    )
  fi
fi

# Not having GLib when unit testing has been explicitly requested is an error
if test "x$enable_unit_tests" = x"yes"; then
  if test "x$have_glib" = x"no"; then
    AC_MSG_ERROR([--enable-unit-tests=yes specified but glib-2.0 not found])
  fi
fi

# Having unit testing disabled when GLib has been explicitly requested is an error
if test "x$enable_unit_tests" = x"no"; then
  if test "x$with_glib" = x"yes"; then
    AC_MSG_ERROR([--enable-unit-tests=yes specified but glib-2.0 not found])
  fi
fi

# Not having GLib when it has been explicitly requested is an error
if test "x$with_glib" = x"yes"; then
  if test "x$have_glib" = x"no"; then
    AC_MSG_ERROR([--with-glib=yes specified but glib-2.0 not found])
  fi
fi

AM_CONDITIONAL([HAVE_GLIB], [test "$have_glib" = yes])
])dnl# XORG_WITH_GLIB

# XORG_LD_WRAP([required|optional])
# ---------------------------------
# Minimum version: 1.13.0
#
# Check if linker supports -wrap, passed via compiler flags
#
# When used with ENABLE_UNIT_TESTS, it is assumed -wrap is used for unit testing.
# Otherwise the value of $enable_unit_tests is blank.
#
# Argument added in 1.16.0 - default is "required", to match existing behavior
# of returning an error if enable_unit_tests is yes, and ld -wrap is not
# available, an argument of "optional" allows use when some unit tests require
# ld -wrap and others do not.
#
AC_DEFUN([XORG_LD_WRAP],[
XORG_CHECK_LINKER_FLAGS([-Wl,-wrap,exit],[have_ld_wrap=yes],[have_ld_wrap=no],
    [AC_LANG_PROGRAM([#include <stdlib.h>
                      void __wrap_exit(int status) { return; }],
                     [exit(0);])])
# Not having ld wrap when unit testing has been explicitly requested is an error
if test "x$enable_unit_tests" = x"yes" -a "x$1" != "xoptional"; then
  if test "x$have_ld_wrap" = x"no"; then
    AC_MSG_ERROR([--enable-unit-tests=yes specified but ld -wrap support is not available])
  fi
fi
AM_CONDITIONAL([HAVE_LD_WRAP], [test "$have_ld_wrap" = yes])
#
])dnl# XORG_LD_WRAP

# XORG_CHECK_LINKER_FLAGS
# -----------------------
# SYNOPSIS
#
#   XORG_CHECK_LINKER_FLAGS(FLAGS, [ACTION-SUCCESS], [ACTION-FAILURE], [PROGRAM-SOURCE])
#
# DESCRIPTION
#
#   Check whether the given linker FLAGS work with the current language's
#   linker, or whether they give an error.
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   PROGRAM-SOURCE is the program source to link with, if needed
#
#   NOTE: Based on AX_CHECK_COMPILER_FLAGS.
#
# LICENSE
#
#   Copyright (c) 2009 Mike Frysinger <vapier@gentoo.org>
#   Copyright (c) 2009 Steven G. Johnson <stevenj@alum.mit.edu>
#   Copyright (c) 2009 Matteo Frigo
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.#
AC_DEFUN([XORG_CHECK_LINKER_FLAGS],
[AC_MSG_CHECKING([whether the linker accepts $1])
dnl Some hackery here since AC_CACHE_VAL can't handle a non-literal varname:
AS_LITERAL_IF([$1],
  [AC_CACHE_VAL(AS_TR_SH(xorg_cv_linker_flags_[$1]), [
      ax_save_FLAGS=$LDFLAGS
      LDFLAGS="$1"
      AC_LINK_IFELSE([m4_default([$4],[AC_LANG_PROGRAM()])],
        AS_TR_SH(xorg_cv_linker_flags_[$1])=yes,
        AS_TR_SH(xorg_cv_linker_flags_[$1])=no)
      LDFLAGS=$ax_save_FLAGS])],
  [ax_save_FLAGS=$LDFLAGS
   LDFLAGS="$1"
   AC_LINK_IFELSE([AC_LANG_PROGRAM()],
     eval AS_TR_SH(xorg_cv_linker_flags_[$1])=yes,
     eval AS_TR_SH(xorg_cv_linker_flags_[$1])=no)
   LDFLAGS=$ax_save_FLAGS])
eval xorg_check_linker_flags=$AS_TR_SH(xorg_cv_linker_flags_[$1])
AC_MSG_RESULT($xorg_check_linker_flags)
if test "x$xorg_check_linker_flags" = xyes; then
	m4_default([$2], :)
else
	m4_default([$3], :)
fi
])dnl# XORG_CHECK_LINKER_FLAGS

# XORG_MEMORY_CHECK_FLAGS
# -----------------------
# Minimum version: 1.16.0
#
# This macro attempts to find appropriate memory checking functionality
# for various platforms which unit testing code may use to catch various
# forms of memory allocation and access errors in testing.
#
# Interface to module:
# XORG_MALLOC_DEBUG_ENV - environment variables to set to enable debugging
#                         Usually added to TESTS_ENVIRONMENT in Makefile.am
#
# If the user sets the value of XORG_MALLOC_DEBUG_ENV, it is used verbatim.
#
AC_DEFUN([XORG_MEMORY_CHECK_FLAGS],[

AC_REQUIRE([AC_CANONICAL_HOST])
AC_ARG_VAR([XORG_MALLOC_DEBUG_ENV],
           [Environment variables to enable memory checking in tests])

# Check for different types of support on different platforms
case $host_os in
    solaris*)
        AC_CHECK_LIB([umem], [umem_alloc],
            [malloc_debug_env='LD_PRELOAD=libumem.so UMEM_DEBUG=default'])
        ;;
    *-gnu*) # GNU libc - Value is used as a single byte bit pattern,
        # both directly and inverted, so should not be 0 or 255.
        malloc_debug_env='MALLOC_PERTURB_=15'
        ;;
    darwin*)
        malloc_debug_env='MallocPreScribble=1 MallocScribble=1 DYLD_INSERT_LIBRARIES=/usr/lib/libgmalloc.dylib'
        ;;
    *bsd*)
        malloc_debug_env='MallocPreScribble=1 MallocScribble=1'
        ;;
esac

# User supplied flags override default flags
if test "x$XORG_MALLOC_DEBUG_ENV" != "x"; then
    malloc_debug_env="$XORG_MALLOC_DEBUG_ENV"
fi

AC_SUBST([XORG_MALLOC_DEBUG_ENV],[$malloc_debug_env])
])dnl# XORG_MEMORY_CHECK_FLAGS

# XORG_CHECK_MALLOC_ZERO
# ----------------------
# Minimum version: 1.0.0
#
# Defines {MALLOC,XMALLOC,XTMALLOC}_ZERO_CFLAGS appropriately if
# malloc(0) returns NULL.  Packages should add one of these cflags to
# their AM_CFLAGS (or other appropriate *_CFLAGS) to use them.
AC_DEFUN([XORG_CHECK_MALLOC_ZERO],[
AC_ARG_ENABLE([malloc0returnsnull],
	[AS_HELP_STRING([--enable-malloc0returnsnull],
		       [malloc(0) returns NULL (default: auto)])],
	[MALLOC_ZERO_RETURNS_NULL=$enableval],
	[MALLOC_ZERO_RETURNS_NULL=auto])dnl

AC_MSG_CHECKING([whether malloc(0) returns NULL])
if test "x${MALLOC_ZERO_RETURNS_NULL}" = "xauto"; then
	AC_RUN_IFELSE([AC_LANG_PROGRAM([
#include <stdlib.h>
],[
    char *m0, *r0, *c0, *p;
    m0 = malloc(0);
    p = malloc(10);
    r0 = realloc(p,0);
    c0 = calloc(0,10);
    exit((m0 == 0 || r0 == 0 || c0 == 0) ? 0 : 1);
])],
		[MALLOC_ZERO_RETURNS_NULL=yes],
		[MALLOC_ZERO_RETURNS_NULL=no],
		[MALLOC_ZERO_RETURNS_NULL=yes])
fi
AC_MSG_RESULT([${MALLOC_ZERO_RETURNS_NULL}])dnl

if test "x${MALLOC_ZERO_RETURNS_NULL}" = "xyes"; then
	MALLOC_ZERO_CFLAGS="-DMALLOC_0_RETURNS_NULL"
	XMALLOC_ZERO_CFLAGS="${MALLOC_ZERO_CFLAGS}"
	XTMALLOC_ZERO_CFLAGS="${MALLOC_ZERO_CFLAGS} -DXTMALLOC_BC"
else
	MALLOC_ZERO_CFLAGS=""
	XMALLOC_ZERO_CFLAGS=""
	XTMALLOC_ZERO_CFLAGS=""
fi

AC_SUBST([MALLOC_ZERO_CFLAGS])dnl
AC_SUBST([XMALLOC_ZERO_CFLAGS])dnl
AC_SUBST([XTMALLOC_ZERO_CFLAGS])dnl
])dnl# XORG_CHECK_MALLOC_ZERO

# XORG_WITH_LINT()
# ----------------
# Minimum version: 1.1.0
#
# This macro enables the use of a tool that flags some suspicious and
# non-portable constructs (likely to be bugs) in C language source code.
# It will attempt to locate the tool and use appropriate options.
# There are various lint type tools on different platforms.
#
# Interface to module:
# LINT:		returns the path to the tool found on the platform
#		or the value set to LINT on the configure cmd line
#		also an Automake conditional
# LINT_FLAGS:	an Automake variable with appropriate flags
#
# --with-lint:	'yes' user instructs the module to use lint
#		'no' user instructs the module not to use lint (default)
#
# If the user sets the value of LINT, AC_PATH_PROG skips testing the path.
# If the user sets the value of LINT_FLAGS, they are used verbatim.
#
AC_DEFUN([XORG_WITH_LINT],[

AC_ARG_VAR([LINT],[Path to a lint-style command])dnl
AC_ARG_VAR([LINT_FLAGS],[Flags for the lint-style command])dnl
AC_ARG_WITH([lint],[AS_HELP_STRING([--with-lint],
		[Use a lint-style source code checker (default: disabled)])],
		[use_lint=${withval}],[use_lint=no])dnl

# Obtain platform specific info like program name and options
# The lint program on FreeBSD and NetBSD is different from the one on Solaris
case $host_os in
  *linux* | *openbsd* | kfreebsd*-gnu | darwin* | cygwin*)
	lint_name=splint
	lint_options="-badflag"
	;;
  *freebsd* | *netbsd*)
	lint_name=lint
	lint_options="-u -b"
	;;
  *solaris*)
	lint_name=lint
	lint_options="-u -b -h -erroff=E_INDISTING_FROM_TRUNC2"
	;;
esac

# Test for the presence of the program (either guessed by the code or spelled out by the user)
if test "x${use_lint}" = x"yes"; then
   AC_PATH_PROG([LINT],[${lint_name}])
   if test "x${LINT}" = "x"; then
        AC_MSG_ERROR([--with-lint=yes specified but lint-style tool not found in PATH])
   fi
elif test "x${use_lint}" = x"no"; then
   if test "x${LINT}" != "x"; then
      AC_MSG_WARN([ignoring LINT environment variable since --with-lint=no was specified])
   fi
else
   AC_MSG_ERROR([--with-lint expects 'yes' or 'no'. Use LINT variable to specify path.])
fi

# User supplied flags override default flags
if test "x${LINT_FLAGS}" != "x"; then
   lint_options=${LINT_FLAGS}
fi

AC_SUBST([LINT_FLAGS],[${lint_options}])dnl
AM_CONDITIONAL([LINT],[test "x${LINT}" != "x"])dnl

])dnl# XORG_WITH_LINT

# XORG_LINT_LIBRARY(LIBNAME)
# --------------------------
# Minimum version: 1.1.0
#
# Sets up flags for building lint libraries for checking programs that call
# functions in the library.
#
# Interface to module:
# LINTLIB		- Automake variable with the name of lint library file to make
# MAKE_LINT_LIB		- Automake conditional
#
# --enable-lint-library:  - 'yes' user instructs the module to created a lint library
#			  - 'no' user instructs the module not to create a lint library (default)

AC_DEFUN([XORG_LINT_LIBRARY],[
AC_REQUIRE([XORG_WITH_LINT])dnl
AC_ARG_ENABLE([lint-library],[AS_HELP_STRING([--enable-lint-library],
	[Create lint library (default: disabled)])],
	[make_lint_lib=${enableval}],[make_lint_lib=no])dnl

if test "x${make_lint_lib}" = x"yes"; then
   LINTLIB=llib-l$1.ln
   if test "x${LINT}" = "x"; then
        AC_MSG_ERROR([Cannot make lint library without --with-lint])
   fi
elif test "x${make_lint_lib}" != x"no"; then
   AC_MSG_ERROR([--enable-lint-library expects 'yes' or 'no'.])
fi

AC_SUBST([LINTLIB])dnl
AM_CONDITIONAL([MAKE_LINT_LIB],[test "x${make_lint_lib}" != "xno"])dnl

])dnl# XORG_LINT_LIBRARY

# XORG_COMPILER_BRAND
# -------------------
# Minimum version: 1.14.0
#
# Checks for various brands of compilers and sets flags as appropriate:
#   GNU gcc - relies on AC_PROG_CC (via AC_PROG_CC_C99) to set GCC to "yes"
#   GNU g++ - relies on AC_PROG_CXX to set GXX to "yes"
#   clang compiler - sets CLANGCC to "yes"
#   Intel compiler - sets INTELCC to "yes"
#   Sun/Oracle Solaris Studio cc - sets SUNCC to "yes"
#
AC_DEFUN([XORG_COMPILER_BRAND],[
    dnl# probably already done, but just in case:
AC_LANG_CASE([C],[
	AC_REQUIRE([AC_PROG_CC_C99])dnl
],[C++],[
	AC_REQUIRE([AC_PROG_CXX])dnl
])dnl
  ## just some basic decl checks:
AC_CHECK_DECL([__clang__],[CLANGCC="yes"],[CLANGCC="no"]) ## (need newline)
AC_CHECK_DECL([__INTEL_COMPILER],[INTELCC="yes"],[INTELCC="no"]) ## (need newline)
AC_CHECK_DECL([__SUNPRO_C],[SUNCC="yes"],[SUNCC="no"]) ## (need newline)
  ## ...ok, that should be it, right?
])dnl# XORG_COMPILER_BRAND

# XORG_TESTSET_CFLAG(<variable>, <flag>, [<alternative flag>, ...])
# ---------------
# Minimum version: 1.16.0
#
# Test if the compiler works when passed the given flag as a command line argument.
# If it succeeds, the flag is appeneded to the given variable.  If not, it tries the
# next flag in the list until there are no more options.
#
# Note that this does not guarantee that the compiler supports the flag as some
# compilers will simply ignore arguments that they do not understand, but we do
# attempt to weed out false positives by using -Werror=unknown-warning-option and
# -Werror=unused-command-line-argument
#
AC_DEFUN([XORG_TESTSET_CFLAG], [
m4_if([$#], 0, [m4_fatal([XORG_TESTSET_CFLAG was given with an unsupported number of arguments])])dnl
m4_if([$#], 1, [m4_fatal([XORG_TESTSET_CFLAG was given with an unsupported number of arguments])])dnl

AC_LANG_COMPILER_REQUIRE dnl# from... somewhere...

AC_LANG_CASE([C],[ dnl
	AC_REQUIRE([AC_PROG_CC_C99])dnl
	define([PREFIX],[C])dnl
	define([CACHE_PREFIX],[cc])dnl
	define([COMPILER],[${CC}])dnl
],[C++],[ dnl
	define([PREFIX],[CXX])dnl
	define([CACHE_PREFIX],[cxx])dnl
	define([COMPILER],[${CXX}])dnl
],[Fortran 77],[ dnl
	define([PREFIX],[F77])dnl
	define([CACHE_PREFIX],[f77])dnl
	define([COMPILER],[${F77}])dnl
])dnl

[xorg_testset_save_]PREFIX[FLAGS]="$PREFIX[FLAGS]"

if test "x$[xorg_testset_]CACHE_PREFIX[_unknown_warning_option]" = "x"; then
	PREFIX[FLAGS]="$PREFIX[FLAGS] -Werror=unknown-warning-option"
	AC_CACHE_CHECK([if ]COMPILER[ supports -Werror=unknown-warning-option],
			[xorg_cv_]CACHE_PREFIX[_flag_unknown_warning_option],
			AC_COMPILE_IFELSE([AC_LANG_CASE([C],
			                  [AC_LANG_SOURCE([int i;])],
			                  [C++],
			                  [AC_LANG_SOURCE([int i;])],
			                  [Fortran 77],
			                  [AC_LANG_SOURCE([])])],
					  [xorg_cv_]CACHE_PREFIX[_flag_unknown_warning_option=yes],
					  [xorg_cv_]CACHE_PREFIX[_flag_unknown_warning_option=no]))
	[xorg_testset_]CACHE_PREFIX[_unknown_warning_option]=$[xorg_cv_]CACHE_PREFIX[_flag_unknown_warning_option]
	PREFIX[FLAGS]="$[xorg_testset_save_]PREFIX[FLAGS]"
fi

if test "x$[xorg_testset_]CACHE_PREFIX[_unused_command_line_argument]" = "x"; then
	if test "x$[xorg_testset_]CACHE_PREFIX[_unknown_warning_option]" = "xyes"; then
		PREFIX[FLAGS]="$PREFIX[FLAGS] -Werror=unknown-warning-option"
	fi
	PREFIX[FLAGS]="$PREFIX[FLAGS] -Werror=unused-command-line-argument"
	AC_CACHE_CHECK([if ]COMPILER[ supports -Werror=unused-command-line-argument],
			[xorg_cv_]CACHE_PREFIX[_flag_unused_command_line_argument],
			AC_COMPILE_IFELSE([AC_LANG_CASE([C],
			                  [AC_LANG_SOURCE([int i;])],
			                  [C++],
			                  [AC_LANG_SOURCE([int i;])],
			                  [Fortran 77],
			                  [AC_LANG_SOURCE([])])],
					  [xorg_cv_]CACHE_PREFIX[_flag_unused_command_line_argument=yes],
					  [xorg_cv_]CACHE_PREFIX[_flag_unused_command_line_argument=no]))
	[xorg_testset_]CACHE_PREFIX[_unused_command_line_argument]=$[xorg_cv_]CACHE_PREFIX[_flag_unused_command_line_argument]
	PREFIX[FLAGS]="$[xorg_testset_save_]PREFIX[FLAGS]"
fi

found="no"
m4_foreach([flag], m4_cdr($@), [
	if test $found = "no" ; then
		if test "x${xorg_testset_unknown_warning_option}" = "xyes" || test "x$[xorg_testset_]CACHE_PREFIX[_unknown_warning_option]" = "xyes"; then
			## for clang
			PREFIX[FLAGS]="$PREFIX[FLAGS] -Werror=unknown-warning-option"
		fi

		if test "x${xorg_testset_unused_command_line_argument}" = "xyes" || test "x$[xorg_testset_]CACHE_PREFIX[_unused_command_line_argument]" = "xyes"; then
			## for clang
			PREFIX[FLAGS]="$PREFIX[FLAGS] -Werror=unused-command-line-argument"
		fi

		PREFIX[FLAGS]="$PREFIX[FLAGS] ]flag["

dnl Some hackery here since AC_CACHE_VAL cannot handle a non-literal varname
		AC_MSG_CHECKING([if ]COMPILER[ supports ]flag[])
		cacheid=AS_TR_SH([xorg_cv_]CACHE_PREFIX[_flag_]flag[])
		AC_CACHE_VAL($cacheid,
			     [AC_LINK_IFELSE([AC_LANG_CASE([C],
			                  [AC_LANG_PROGRAM([int i;])],
			                  [C++],
			                  [AC_LANG_PROGRAM([int i;])],
			                  [Fortran 77],
			                  [AC_LANG_PROGRAM([])])],
					     [eval $cacheid=yes],
					     [eval $cacheid=no])])dnl

		PREFIX[FLAGS]="$[xorg_testset_save_]PREFIX[FLAGS]"

		eval supported=\$$cacheid
		AC_MSG_RESULT([$supported])
		if test "$supported" = "yes" ; then
			$1="$$1 ]flag["
			found="yes"
		fi
	fi
])dnl
])dnl# XORG_TESTSET_CFLAG

# XORG_COMPILER_FLAGS
# ---------------
# Minimum version: 1.16.0
#
# Defines BASE_CFLAGS or BASE_CXXFLAGS to contain a set of command line
# arguments supported by the selected compiler which do NOT alter the generated
# code.  These arguments will cause the compiler to print various warnings
# during compilation AND turn a conservative set of warnings into errors.
#
# The set of flags supported by BASE_CFLAGS and BASE_CXXFLAGS will grow in
# future versions of util-macros as options are added to new compilers.
#
AC_DEFUN([XORG_COMPILER_FLAGS], [
AC_REQUIRE([XORG_COMPILER_BRAND])dnl

AC_ARG_ENABLE([selective-werror],
              [AS_HELP_STRING([--disable-selective-werror],
                              [Turn off selective compiler errors. (default: enabled)])],
              [SELECTIVE_WERROR=$enableval],
              [SELECTIVE_WERROR=yes])dnl

AC_LANG_CASE([C],[
    define([PREFIX],[C])dnl
    define([WERROR_WRITE_STRINGS_CV],[xorg_cv_cc_flag__Werror_write_strings])dnl
],[C++],[
    define([PREFIX],[CXX])dnl
    define([WERROR_WRITE_STRINGS_CV],[xorg_cv_cxx_flag__Werror_write_strings])dnl
],[Fortran 77],[
    define([PREFIX],[F])dnl
    define([WERROR_WRITE_STRINGS_CV],[xorg_cv_f77_flag__Werror_write_strings])dnl
])dnl
# -v is too short to test reliably with XORG_TESTSET_CFLAG:
if test "x${SUNCC}" = "xyes"; then
    [BASE_]PREFIX[FLAGS]="-v"
else
    [BASE_]PREFIX[FLAGS]=""
fi

# This chunk of warnings were those that existed in the legacy CWARNFLAGS
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wall -Wno-cast-function-type], [-Wmost])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-declarations])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wformat=2 -Wno-format-nonliteral], [-Wformat])dnl

AC_LANG_CASE([C],[
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstrict-prototypes])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-prototypes])
	if test "x${BE_REALLY_ANNOYING}" = "xyes"; then 
	  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]],[-Wtraditional-conversion])
	fi
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wc99-c11-compat -Wno-long-long -Wno-import -Wno-deprecated], [-Wc90-c99-compat -Wno-long-long -Wno-import -Wno-deprecated], [-Wpedantic -Wno-long-long -Wno-import -Wno-deprecated], [-Wc11-extensions -Wc99-compat -Wc99-designator -Wc99-extensions])
],[C++],[
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wuseless-cast])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmismatched-tags])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-exception-spec])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wnon-literal-null-conversion])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wpredefined-identifier-outside-function])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wvexing-parse])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wreturn-stack-address])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wshadow-field-in-constructor])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunused-private-field])
],[Fortran 77],[
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Waliasing])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wc-binding-type])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wimplicit-interface])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wimplicit-procedure])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Winteger-division])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wintrinsics-std])
	XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wreal-q-constant])
	# warning flags already tested in configure.ac: -Wall -Wextra -Wsurprising
	# -Warray-temporaries -Wcharacter-truncation -Wconversion-extra
	# -Wfrontend-loop-interchange -Wuse-without-only -Wrealloc-lhs -Wrealloc-lhs-all
])dnl

# This chunk adds additional warnings that could catch undesired effects.
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunused -Wno-unused-parameter])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wuninitialized -Wno-maybe-uninitialized], [-Wsometimes-uninitialized])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wshadow])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wparentheses])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-noreturn])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-format-attribute])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wredundant-decls])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wdouble-promotion])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wformat-overflow=2], [-Wformat-overflow], [-Wformat-length=2], [-Wformat-length])
if test "x${STRICT_COMPILE}" != "xyes"; then
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wformat-truncation=2], [-Wformat-truncation])
else
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wformat-truncation=1], [-Wformat-truncation=0])
fi
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstringop-overflow=2], [-Wstringop-overflow])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstringop-truncation=2], [-Wstringop-truncation])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wgcc-compat])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wasm])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunneeded-internal-declaration])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstring-plus-int])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstring-conversion])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wbool-conversion])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wconstant-logical-operand])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunused-comparison])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wtautological-constant-out-of-range-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunevaluated-expression])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunsequenced])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wself-assign])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wshift-sign-overflow])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstatic-in-inline])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wparentheses-equality])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Winvalid-noreturn])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wloop-analysis], [-Wfor-loop-analysis])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wunreachable-code-loop-increment])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wtautological-pointer-compare], [-Wtautological-compare])dnl

AC_REQUIRE([AC_C_VARARRAYS])dnl

if test "x${ac_cv_c_vararrays}" = "xno"; then
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wvla], [-Wvla-extension])
elif test "x${ac_cv_c_vararrays}" = "xyes"; then
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wvla-larger-than=9999])
fi

# These are currently disabled because they are noisy.  They will be enabled
# in the future once the codebase is sufficiently modernized to silence
# them.  For now, I do NOT want them to drown out the other warnings.
dnl# XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wlogical-op])
dnl# XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wcast-align])
dnl# XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wcast-qual])

# Turn some warnings into errors, so we do NOT accidently get successful builds
# when there are problems that should be fixed.

if test "x${SELECTIVE_WERROR}" = "xyes"; then
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=pointer-arith])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=nonnull], [-Werror=nonnull-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=init-self])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=main])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=missing-braces])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=sequence-point], [-Werror=unsequenced])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=return-type], [-errwarn=E_FUNC_HAS_NO_RETURN_STMT])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=trigraphs])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=array-bounds], [-Werror=array-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=write-strings])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=address])dnl
AC_REQUIRE([AC_TYPE_INTPTR_T])dnl
AC_REQUIRE([AC_TYPE_UINTPTR_T])dnl
# conditionalize on whether silencing is easily possible:
if test "x${ac_cv_type_intptr_t}" = "xyes" -a "x${ac_cv_type_uintptr_t}" = "xyes"; then
  if test -n "${ac_cv_sizeof_int}" -a -n "${ac_cv_sizeof_void_p}"; then
    if test "x${ac_cv_sizeof_int}" != "x${ac_cv_sizeof_void_p}"; then
      test -n "${SELECTIVE_WERROR}"
      AC_LANG_CASE([C],[
        XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=int-to-pointer-cast], [-errwarn=E_BAD_PTR_INT_COMBINATION])
        XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=pointer-to-int-cast]) # Also -errwarn=E_BAD_PTR_INT_COMBINATION
      ],[C++],[echo "skipping a few C-only flags for C++"])
      ## FIXME: did this cause a syntax error?
    else
      AC_MSG_NOTICE([pointers and ints are the same size so it is safe to cast between them; skipping check to see if we can error on warnings about them])
    fi
  else
    AC_MSG_NOTICE([we need to know how big ints and pointers are to decide whether to error on warnings about casts between them])
  fi
else
  AC_MSG_NOTICE([handling casts between pointers and integers and vice versa is easier when we have intptr_t and uintptr_t, so skipping erroring on such warnings due to missing types])
fi
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=pointer-compare], [-Werror=tautological-pointer-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=endif-labels], [-Werror=extra-tokens])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=comment])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=newline-eof])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=shorten-64-to-32])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=float-conversion])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=builtin-memcpy-chk-size], [-Werror=sizeof-pointer-memaccess])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=stringop-overflow], [-Werror=stringop-overread])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=unused-but-set-parameter])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=unused-label])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=unused-local-typedefs])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=unused-result])
AC_LANG_CASE([Fortran 77],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=argument-mismatch])
],[C++],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=conversion-null])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=narrowing])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=strict-null-sentinel])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=sign-promo])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=shadow-local])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=parentheses])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=redundant-decls])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=format-overflow])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=format-truncation])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=stringop-truncation])
],[C],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=deprecated-non-prototype], [-Werror=knr-promoted-parameter], [-Werror=missing-prototype-for-cc])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=old-style-declaration])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=implicit], [-errwarn=E_NO_EXPLICIT_TYPE_GIVEN -errwarn=E_NO_IMPLICIT_DECL_ALLOWED])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=int-conversion], [-Werror=implicit-int-conversion])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=declaration-after-statement])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=missing-field-initializers])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=absolute-value])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=nested-externs])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=old-style-definition], [-Wold-style-definition])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=enum-conversion], [-Werror=enum-enum-conversion])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=array-parameter], [-Werror=vla-parameter])
])
if test "[x${]WERROR_WRITE_STRINGS_CV[}]" != "xyes"; then
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=incompatible-pointer-types])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=discarded-qualifiers])
else
  if test "x${CLANGCC}" = "xyes" && test "x${STRICT_COMPILE}" != "xyes"; then 
    XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Werror=incompatible-pointer-types-discards-qualifier])
  else
    AC_MSG_NOTICE([skipping adding -Werror=incompatible-pointer-types and -Werror=discarded-qualifiers when -Werror=write-strings is already on])
  fi
fi
else
AC_MSG_WARN([You have chosen not to turn some select compiler warnings into errors.  This should not be necessary.  Please report why you needed to do so in a bug report at $PACKAGE_BUGREPORT])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wpointer-arith])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wnonnull], [-Wnonnull-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Winit-self])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmain])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wmissing-braces])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wsequence-point]) # (unsequenced already handled above)
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wreturn-type])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wtrigraphs])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Warray-bounds], [-Warray-compare])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wwrite-strings], [-Wincompatible-pointer-types-discards-qualifier])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Waddress])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wincompatible-pointer-types])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wpointer-compare]) # (tautological one already handled above)
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wendif-labels], [-Wextra-tokens])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wshorten-64-to-32])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wfloat-conversion])
XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wbuiltin-memcpy-chk-size], [-Wsizeof-pointer-memaccess])
# (stringops already handled above)
AC_LANG_CASE([Fortran 77],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wargument-mismatch])
],[C++],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wconversion-null])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wnarrowing])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wstrict-null-sentinel])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wsign-promo])
],[C],[
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wold-style-declaration])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wimplicit])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wint-to-pointer-cast])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wpointer-to-int-cast])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wint-conversion], [-Wimplicit-int-conversion])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wdeclaration-after-statement])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wnested-externs])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wold-style-definition])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Wenum-conversion], [-Wenum-enum-conversion])
  XORG_TESTSET_CFLAG([[BASE_]PREFIX[FLAGS]], [-Warray-parameter], [-Wvla-parameter])
])
dnl# -Wdiscarded-qualifiers should already be on by default
fi

AC_SUBST([BASE_]PREFIX[FLAGS])
])dnl# XORG_COMPILER_FLAGS

# XORG_CWARNFLAGS
# ---------------
# Minimum version: 1.2.0
# Deprecated since: 1.16.0 (Use XORG_COMPILER_FLAGS instead)
#
# Defines CWARNFLAGS to enable C compiler warnings.
#
# This function is deprecated because it defines -fno-strict-aliasing
# which alters the code generated by the compiler.  If -fno-strict-aliasing
# is needed, then it should be added explicitly in the module when
# it is updated to use BASE_CFLAGS.
#
AC_DEFUN([XORG_CWARNFLAGS],[
AC_REQUIRE([AC_TYPE_INTPTR_T])dnl
AC_REQUIRE([AC_TYPE_UINTPTR_T])dnl
AC_REQUIRE([XORG_COMPILER_FLAGS])dnl
AC_REQUIRE([XORG_COMPILER_BRAND])dnl
AC_LANG_CASE([C],[
		CWARNFLAGS="${BASE_CFLAGS}"
		if  test "x${GCC}" = "xyes"; then
		    CWARNFLAGS="${CWARNFLAGS} -fno-strict-aliasing"
		fi
		AC_SUBST([CWARNFLAGS])dnl
	])dnl
])dnl# XORG_CWARNFLAGS

# XORG_CXXWARNFLAGS
AC_DEFUN([XORG_CXXWARNFLAGS],[
AC_REQUIRE([AC_TYPE_INTPTR_T])dnl
AC_REQUIRE([AC_TYPE_UINTPTR_T])dnl
AC_REQUIRE([XORG_COMPILER_BRAND])dnl
AC_LANG_PUSH([C++])dnl
XORG_COMPILER_FLAGS
AC_LANG_CASE([C++],[
CXXWARNFLAGS="${BASE_CXXFLAGS}"
if  test "x${GCC}" = "xyes"; then
    CXXWARNFLAGS="${CXXWARNFLAGS} -fno-strict-aliasing"
fi
AC_SUBST([CXXWARNFLAGS])dnl
])dnl
AC_LANG_POP([C++])dnl
])dnl# XORG_CXXWARNFLAGS

# XORG_F77WARNFLAGS
AC_DEFUN([XORG_F77WARNFLAGS],[
AC_REQUIRE([XORG_COMPILER_BRAND])dnl
AC_LANG_PUSH([Fortran 77])dnl
XORG_COMPILER_FLAGS
AC_LANG_CASE([Fortran 77],[
F77WARNFLAGS="${BASE_F77FLAGS}"
AC_SUBST([F77WARNFLAGS])dnl
])dnl
AC_LANG_POP([Fortran 77])dnl
])dnl# XORG_F77WARNFLAGS

# XORG_STRICT_OPTION
# -----------------------
# Minimum version: 1.3.0
#
# Add configure option to enable strict compilation flags, such as treating
# warnings as fatal errors.
# If --enable-strict-compilation is passed to configure, adds strict flags to
# $BASE_CFLAGS or $BASE_CXXFLAGS and the deprecated $CWARNFLAGS.
#
# Starting in 1.14.0 also exports $STRICT_CFLAGS for use in other tests or
# when strict compilation is unconditionally desired.
AC_DEFUN([XORG_STRICT_OPTION],[
AC_REQUIRE([XORG_CWARNFLAGS])dnl
AC_REQUIRE([XORG_COMPILER_FLAGS])dnl

AC_ARG_ENABLE([strict-compilation],
			  [AS_HELP_STRING([--enable-strict-compilation],
			  [Enable all warnings from compiler and make them errors (default: disabled)])],
			  [STRICT_COMPILE=${enableval}],[STRICT_COMPILE=no])dnl

AC_LANG_CASE([C],[
        define([PREFIX],[C])dnl
],[C++],[
        define([PREFIX],[CXX])dnl
])dnl

[STRICT_]PREFIX[FLAGS]=""
XORG_TESTSET_CFLAG([[STRICT_]PREFIX[FLAGS]], [-pedantic])
XORG_TESTSET_CFLAG([[STRICT_]PREFIX[FLAGS]], [-Werror], [-errwarn])dnl

# Earlier versions of gcc (eg: 4.2) support -Werror=attributes, but do not
# activate it with -Werror, so we add it here explicitly.
XORG_TESTSET_CFLAG([[STRICT_]PREFIX[FLAGS]], [-Werror=attributes])dnl

if test "x${STRICT_COMPILE}" = "xyes"; then
    [BASE_]PREFIX[FLAGS]="$[BASE_]PREFIX[FLAGS] $[STRICT_]PREFIX[FLAGS]"
    AC_LANG_CASE([C],[CWARNFLAGS="${CWARNFLAGS} ${STRICT_CFLAGS}"])
fi
AC_SUBST([STRICT_]PREFIX[FLAGS])dnl
AC_SUBST([BASE_]PREFIX[FLAGS])dnl
AC_LANG_CASE([C],[AC_SUBST([CWARNFLAGS])])dnl
])dnl# XORG_STRICT_OPTION

# XORG_DEFAULT_OPTIONS
# --------------------
# Minimum version: 1.3.0
#
# Defines default options for X.Org modules.
#
AC_DEFUN([XORG_DEFAULT_OPTIONS],[
AC_REQUIRE([AC_PROG_INSTALL])dnl
XORG_COMPILER_FLAGS
XORG_CWARNFLAGS
XORG_STRICT_OPTION
XORG_RELEASE_VERSION
XORG_CHANGELOG
XORG_INSTALL
XORG_MANPAGE_SECTIONS
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])],
    [AC_SUBST([AM_DEFAULT_VERBOSITY],[1])])dnl
])dnl # XORG_DEFAULT_OPTIONS

# XORG_INSTALL()
# ----------------
# Minimum version: 1.4.0
#
# Defines the variable INSTALL_CMD as the command to copy
# INSTALL from $prefix/share/util-macros.
#
AC_DEFUN([XORG_INSTALL],[
AC_REQUIRE([PKG_PROG_PKG_CONFIG])
macros_datadir=`${PKG_CONFIG} --print-errors --variable=pkgdatadir xorg-macros`
INSTALL_CMD="(cp -f "${macros_datadir}/INSTALL" \$(top_srcdir)/.INSTALL.tmp && \
mv \$(top_srcdir)/.INSTALL.tmp \$(top_srcdir)/INSTALL) \
|| (rm -f \$(top_srcdir)/.INSTALL.tmp; touch \$(top_srcdir)/INSTALL; \
echo 'util-macros \"pkgdatadir\" from xorg-macros.pc not found: installing possibly empty INSTALL.' >&2)"
AC_SUBST([INSTALL_CMD])dnl
])dnl# XORG_INSTALL
dnl Copyright 2005 Red Hat, Inc
dnl
dnl Permission to use, copy, modify, distribute, and sell this software and its
dnl documentation for any purpose is hereby granted without fee, provided that
dnl the above copyright notice appear in all copies and that both that
dnl copyright notice and this permission notice appear in supporting
dnl documentation.
dnl
dnl The above copyright notice and this permission notice shall be included
dnl in all copies or substantial portions of the Software.
dnl
dnl THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
dnl OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
dnl MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
dnl IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
dnl OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
dnl ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
dnl OTHER DEALINGS IN THE SOFTWARE.
dnl
dnl Except as contained in this notice, the name of the copyright holders shall
dnl not be used in advertising or otherwise to promote the sale, use or
dnl other dealings in this Software without prior written authorization
dnl from the copyright holders.
dnl

# XORG_RELEASE_VERSION
# --------------------
# Defines PACKAGE_VERSION_{MAJOR,MINOR,PATCHLEVEL} for modules to use.
 
AC_DEFUN([XORG_RELEASE_VERSION],[
	AC_DEFINE_UNQUOTED([PACKAGE_VERSION_MAJOR],
		[`echo ${PACKAGE_VERSION} | cut -d . -f 1`],
		[Major version of this package])
	PVM=`echo ${PACKAGE_VERSION} | cut -d . -f 2 | cut -d - -f 1`
	if test "x${PVM}" = "x"; then
		PVM="0"
	fi
	AC_DEFINE_UNQUOTED([PACKAGE_VERSION_MINOR],
		[${PVM}],
		[Minor version of this package])
	PVP=`echo ${PACKAGE_VERSION} | cut -d . -f 3 | cut -d - -f 1`
	if test "x${PVP}" = "x"; then
		PVP="0"
	fi
	AC_DEFINE_UNQUOTED([PACKAGE_VERSION_PATCHLEVEL],
		[${PVP}],
		[Patch version of this package])dnl
])dnl# XORG_RELEASE_VERSION

# XORG_CHANGELOG()
# ----------------
# Minimum version: 1.2.0
#
# Defines the variable CHANGELOG_CMD as the command to generate
# ChangeLog from git.
#
#
AC_DEFUN([XORG_CHANGELOG], [
CHANGELOG_CMD="(GIT_DIR=\$(top_srcdir)/.git git log > \$(top_srcdir)/.changelog.tmp && \
mv \$(top_srcdir)/.changelog.tmp \$(top_srcdir)/ChangeLog) \
|| (rm -f \$(top_srcdir)/.changelog.tmp; touch \$(top_srcdir)/ChangeLog; \
echo 'git directory not found: installing possibly empty changelog.' >&2)"
AC_SUBST([CHANGELOG_CMD])dnl
])dnl # XORG_CHANGELOG
