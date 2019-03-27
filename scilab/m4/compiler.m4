
dnl# CHECK_COMPILER_ARG([LANG],[ARG],[GENERICFLAGSVAR],[YOURFLAGSVAR])

AC_DEFUN([CHECK_COMPILER_ARG],[
    dnl#FIXME: make this a cache-check:
    AC_LANG_PUSH([$1])
    AC_MSG_CHECKING([if the $1 compiler accepts $2])
    ac_save_$3="$$3"
    $3="$$3 $2"

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()],
       [AC_MSG_RESULT([yes])
       $4="$2"
       ],
       [AC_MSG_RESULT([no])])
    $3="$ac_save_$3";
    AC_LANG_POP([$1])
])dnl

dnl# QUIET_UNUSED_COMPILER_ARGS([LANG],[FLAGSVAR])

AC_DEFUN([QUIET_UNUSED_COMPILER_ARGS],[
        CHECK_COMPILER_ARG([$1],[-Qunused-arguments],[$2],[QUIET_$2])
        if test -z "${QUIET_$2}"; then
            CHECK_COMPILER_ARG([$1],[-Wa,-Qunused-arguments],[$2],
                               [QUIET_$2])
        fi
        if test -n "${QUIET_$2}"; then
            if test -n "${ARCH_$2}"; then
                ARCH_$2="${ARCH_$2} ${QUIET_$2}"
            elif test -n "${DEBUG_$2}"; then
                DEBUG_$2="${DEBUG_$2} ${QUIET_$2}"
            elif test -n "${COMPILER_$2}"; then
                COMPILER_$2="${COMPILER_$2} ${QUIET_$2}"
            elif test -n "${WARNING_$2}"; then
                WARNING_$2="${WARNING_$2} ${QUIET_$2}"
            elif test -n "${WERROR_$2}"; then
                WERROR_$2="${WERROR_$2} ${QUIET_$2}"
            fi
        fi
        AC_SUBST([QUIET_$2])dnl
])dnl

dnl# CHECK_COMPILER_RDYNAMIC([LANG],[GENERICFLAGSVAR],[YOURFLAGSVAR])

AC_DEFUN([CHECK_COMPILER_RDYNAMIC],[
  CHECK_COMPILER_ARG([$1],[-Werror=unused-command-line-argument],[$2],
                     [VERIFY_CLI_ARGS_$2])
  RDYNAMIC_saved_$2="$$2"
  $2="$$2 ${VERIFY_CLI_ARGS_$2}"
  CHECK_COMPILER_ARG([$1],[-rdynamic],[$2],[$3])
  $2="${RDYNAMIC_saved_$2}"
])dnl


