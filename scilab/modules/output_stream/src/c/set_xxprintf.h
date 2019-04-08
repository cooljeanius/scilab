/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
/*--------------------------------------------------------------------------*/
#ifndef __SET_XXPRINTF_H__
#define __SET_XXPRINTF_H__
/*--------------------------------------------------------------------------*/
#include <stdio.h>
#include "stack-def.h" /* bsiz */
/*--------------------------------------------------------------------------*/
#ifndef GCC_VERSION
# define GCC_VERSION (__GNUC__ * 1000 + __GNUC_MINOR__)
#endif /* GCC_VERSION */
#ifndef ATTRIBUTE_NONNULL
# if (GCC_VERSION >= 3003)
#  define ATTRIBUTE_NONNULL(m) __attribute__((__nonnull__(m)))
# else
#  define ATTRIBUTE_NONNULL(m)
# endif /* GNUC >= 3.3 */
#endif /* ATTRIBUTE_NONNULL */
/*--------------------------------------------------------------------------*/
typedef int (*XXPRINTF)(FILE *, char *, ...);
typedef int (*FLUSH)(FILE *) ATTRIBUTE_NONNULL(1);
/*--------------------------------------------------------------------------*/
#define  MAX_SPRINTF_SIZE  bsiz
/*--------------------------------------------------------------------------*/

/**
* set output function  sprintf, sciprint2, fprintf
* @param[in] fp "Pointer to a FILE object"
* @param[out] xxprintf "Pointer to output function"
* @param[in] flush flush
* @param[out] target output "buffer"
*/
void set_xxprintf(FILE *fp, XXPRINTF *xxprintf, FLUSH *flush, char **target);

#endif /* __SET_XXPRINTF_H__ */
/*--------------------------------------------------------------------------*/

