
/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) INRIA -
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*--------------------------------------------------------------------------*/
#include <string.h>
#include "stack-c.h"
#include "sci_rankqr.h"
/*--------------------------------------------------------------------------*/
extern int C2F(intmb03od)(char *fname, unsigned long fname_len);
extern int C2F(intzb03od)(char *fname, unsigned long fname_len);
/*--------------------------------------------------------------------------*/
int intrankqr(char* fname)
{
    int *header1;
    int Cmplx;
    int ret;

    if (fname == NULL)
    {
        ; /* ??? */
    }

    header1 = (int *) GetData(1);
    Cmplx = header1[3];
    if (Cmplx == 0)
    {
        ret = C2F(intmb03od)("rankqr", 6L);
        return 0;
    }
    else
    {
        ret = C2F(intzb03od)("rankqr", 6L);
        return 0;
    }
    (void)ret;
    return -1; /*NOTREACHED*/
}
/*--------------------------------------------------------------------------*/
