/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Allan CORNET
 * Copyright (C) 2009 - DIGITEO - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
/*--------------------------------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include "set_xxprintf.h"
#include "sciprint.h"
#include "scilabmode.h"
/*--------------------------------------------------------------------------*/
/* local function used to flush with sprintf */
static int voidflush(FILE *fp) ATTRIBUTE_NONNULL(1);
/* local function used to call scivprint */
static int local_sciprint(int iv, char *fmt, ...);
/*--------------------------------------------------------------------------*/
extern char sprintf_buffer[MAX_SPRINTF_SIZE];
/*--------------------------------------------------------------------------*/
void set_xxprintf(FILE *fp, XXPRINTF *xxprintf, FLUSH *flush, char **target)
{
    /* re-initialize value of sprintf_buffer */
    strcpy(sprintf_buffer, "");
    if (fp == (FILE *)0)
    {
        /* sprintf */
        *target = sprintf_buffer;
        *flush = voidflush;
#ifdef S_SPLINT_S
        *xxprintf = (XXPRINTF)snprintf;
#else
        *xxprintf = (XXPRINTF)sprintf;
#endif /* S_SPLINT_S */
    }
    else if (fp == stdout)
    {
        /* sciprint2 */
        *target = (char *)0;
#ifdef S_SPLINT_S
        *flush = voidflush;
#else
        *flush = fflush;
#endif /* S_SPLINT_S */
        *xxprintf = (XXPRINTF)local_sciprint;
    }
    else
    {
        /* fprintf */
        *target = /*@access FILE@*/(char *)fp;
#ifdef S_SPLINT_S
        *flush = voidflush;
#else
        *flush = fflush;
#endif /* S_SPLINT_S */
        *xxprintf = (XXPRINTF)fprintf;
    }
}
/*--------------------------------------------------------------------------*/
static int voidflush(FILE *fp)
{
    return 0;
}
/*--------------------------------------------------------------------------*/
static int local_sciprint(int iv, char *fmt, ...)
{
    int count = 0;
    va_list ap;

    va_start(ap, fmt);
    count = scivprint(fmt, ap);
    va_end(ap);

    return count;
}
/*--------------------------------------------------------------------------*/
