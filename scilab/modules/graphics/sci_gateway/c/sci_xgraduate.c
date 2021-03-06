/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*------------------------------------------------------------------------*/
/* file: sci_xgraduate.c                                                  */
/* desc : interface for xgraduate routine                                 */
/*------------------------------------------------------------------------*/

#include "gw_graphics.h"
#include "stack-c.h"
#include "Format.h"

/*--------------------------------------------------------------------------*/
int sci_xgraduate(char *fname, unsigned long fname_len)
{
    double xa = 0., xi = 0.;
    int m1 = 0, n1 = 0, l1 = 0, m2 = 0, n2 = 0, l2 = 0, i = 0;
    int kMinr = 0, kMaxr = 0, ar = 0, lr = 0, np1 = 0, np2 = 0, un = 1;

    CheckRhs(2, 2);
    CheckLhs(2, 7);
    GetRhsVar(1, MATRIX_OF_DOUBLE_DATATYPE, &m1, &n1, &l1);
    CheckScalar(1, m1, n1);
    GetRhsVar(2, MATRIX_OF_DOUBLE_DATATYPE, &m2, &n2, &l2);
    CheckScalar(2, m2, n2);

    C2F(graduate)(stk(l1), stk(l2), &xi, &xa, &np1, &np2, &kMinr, &kMaxr, &ar);

    *stk(l1) = xi;
    *stk(l2) = xa;

    if (Lhs >= 3)
    {
        CreateVar(3, MATRIX_OF_DOUBLE_DATATYPE, &un, &un, &lr);
        *stk(lr ) = (double) np1;
    }
    if (Lhs >= 4)
    {
        CreateVar(4, MATRIX_OF_DOUBLE_DATATYPE, &un, &un, &lr);
        *stk(lr ) = (double) np2;
    }
    if (Lhs >= 5)
    {
        CreateVar(5, MATRIX_OF_DOUBLE_DATATYPE, &un, &un, &lr);
        *stk(lr ) = (double) kMinr;
    }
    if (Lhs >= 6)
    {
        CreateVar(6, MATRIX_OF_DOUBLE_DATATYPE, &un, &un, &lr);
        *stk(lr ) = (double) kMaxr;
    }
    if (Lhs >= 7)
    {
        CreateVar(7, MATRIX_OF_DOUBLE_DATATYPE, &un, &un, &lr);
        *stk(lr ) = (double) ar;
    }
    for (i = 1; i <= Lhs ; i++)
    {
        LhsVar(i) = i;
    }
    PutLhsVar();
    return 0;
}
/*--------------------------------------------------------------------------*/
