dnl#
dnl# Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
dnl# Copyright (C) INRIA - 2008 - Sylvestre Ledru
dnl# 
dnl# This file must be used under the terms of the CeCILL.
dnl# This source file is licensed as described in the file COPYING, which
dnl# you should have received as part of this distribution.  The terms
dnl# are also available at    
dnl# http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
dnl#
dnl# libxml is mandatory in Scilab 
dnl# When we check :
dnl# * if the path is provided or that we have to find it ourself
dnl# * if it is available
dnl# * what are the compilation flags 
dnl# * what are linking flags
AC_DEFUN([AC_LIBXML2],[

AC_ARG_WITH([libxml2],
            [AS_HELP_STRING([--with-libxml2=PREFIX],
                            [Set the path to your libxml2 installation])],
            [with_libxml2=${withval}],
            [with_libxml2='yes'])dnl

if test "$with_libxml2" != 'yes' -a "$with_libxml2" != 'no'; then
   # Look if xml-config xml2_config (which provides cflags and ldflags) is available
   AC_MSG_CHECKING([libxml2, for xml-config])
   XML_CONFIG="${with_libxml2}/bin/xml2-config" 
        if test -x "$XML_CONFIG"; then
                AC_MSG_RESULT([$XML_CONFIG])
        else
                AC_MSG_ERROR([Unable to find $XML_CONFIG. Please check the path you provided])
	fi
else
	AC_CHECK_PROGS([XML_CONFIG],[xml2-config],[no])
	if test "x$XML_CONFIG" = "xno"; then
		AC_MSG_ERROR([Unable to find xml2-config in the path. Please check your installation of libxml2])
	fi
fi
saved_cflags="${CFLAGS}"
saved_LIBS="${LIBS}"

AC_REQUIRE([AC_PROG_SED])dnl

# extra space is so the pipe thru sed works correctly:
XML_FLAGS=$(echo " `${XML_CONFIG} --cflags`" | ${SED} "s/ -I/ -Wp,-I/g")
XML_LIBS=`${XML_CONFIG} --libs`
XML_VERSION=`${XML_CONFIG} --version`

AC_MSG_NOTICE([${XML_CONFIG} told us that libxml2 requires flags of ${XML_FLAGS}, libs of ${XML_LIBS}, and has a version of ${XML_VERSION}])dnl

PRE_PKG_CONFIG_XML_FLAGS="${XML_FLAGS}"
AC_SUBST([PRE_PKG_CONFIG_XML_FLAGS])dnl

CFLAGS="${CFLAGS} ${XML_FLAGS}"
LIBS="${LIBS} ${XML_LIBS}"

AC_CHECK_LIB([xml2],[xmlReaderForFile],
             [],
             [AC_MSG_ERROR([libxml2 : library missing. (Cannot find symbol xmlReaderForFile). Check if libxml2 is installed and if the version is correct])])
AC_CHECK_HEADERS([libxml/xmlreader.h])
AC_CHECK_HEADERS([libxml/parser.h])dnl

AC_CHECK_HEADERS([libxml/xpath.h])
AC_CHECK_HEADERS([libxml/xpathInternals.h])dnl

CFLAGS=$saved_cflags
LIBS="$saved_LIBS"

AC_SUBST([XML_FLAGS])dnl
AC_SUBST([XML_LIBS])dnl
AC_SUBST([XML_VERSION])dnl

AC_DEFINE_UNQUOTED([LIBXML_FLAGS],["$XML_FLAGS"],[libXML2 flags])
AC_DEFINE_UNQUOTED([LIBXML_LIBS],["$XML_LIBS"],[libXML2 library])

CFLAGS="$CFLAGS $XML_FLAGS"
AC_CHECK_LIB([xml2],[xmlInitParserCtxt],[],
             [AC_MSG_ERROR([libxml2 : library missing])])

AC_CHECK_HEADERS([libxml/tree.h],[],
                 [AC_MSG_ERROR([libxml2 : library missing missing])])	

# Gets compilation and library flags
])dnl
