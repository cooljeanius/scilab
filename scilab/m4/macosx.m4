#
# Return MacOSX version using the system_profile tool.
# (or whichever tool works)
#

AC_DEFUN([AC_GET_MACOSX_VERSION],[
    AC_PATH_PROG([DEFAULTS],[defaults])
    AC_PATH_PROG([SW_VERS],[sw_vers])
    AC_PATH_PROG([UNAME],[uname])
    AC_MSG_CHECKING([how to determine Mac OS X Version])
    if test -e $HOME/Library/Preferences/com.apple.loginwindow.plist -a "x$DEFAULTS" != "x"; then
        AC_MSG_RESULT([using "defaults"])
    	[macosx_version="`defaults read loginwindow SystemVersionStampAsString`"]
    elif test "x$SW_VERS" != "x"; then
        AC_MSG_RESULT([using "sw_vers"])
        [macosx_version="`sw_vers -productVersion`"]
    elif test "x$UNAME" != "x"; then
        AC_MSG_RESULT([using "uname"])
        [darwin_version="`uname -r | cut -d. -f1`"]
        [macosx_version=10.$(($darwin_version - 4))]
    else
        AC_MSG_ERROR([none of the standard ways of determining the Mac OS X version are available.])
    fi
    AC_MSG_CHECKING([Mac OS X Version])
    case $macosx_version in
         11.*)
              AC_MSG_RESULT([macOS 11 - Big Sur])
              AC_MSG_WARN([there has been a big gap since the previous tested version; expect breakages])
              ;;
         10.9*)
              AC_MSG_RESULT([Mac OS X 10.9 - Mavericks.])
              ;;
         10.8*)
              AC_MSG_RESULT([Mac OS X 10.8 - Mountain Lion.])
         ;;
         10.7*)
              AC_MSG_RESULT([Mac OS X 10.7 - Lion.])
         ;;
         10.6*)
              AC_MSG_RESULT([Mac OS X 10.6 - Snow Leopard.])
         ;;
         *10.5*)
              AC_MSG_RESULT([Mac OS X 10.5 - Leopard.])
         ;;
         *)
              AC_MSG_ERROR([MacOSX 10.5, 10.6, 10.7, 10.8, or 10.9 are needed. Found $macosx_version])
         ;;
	 esac
])
