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
/* file: sci_xchange.c                                                    */
/* desc : interface for xchange routine                                   */
/*------------------------------------------------------------------------*/

#include "gw_graphics.h"
#include "stack-c.h"
#include "PloEch.h"

#define VIEWING_RECT_SIZE 4

/*--------------------------------------------------------------------------*/
int sci_xchange( char * fname, unsigned long fname_len )
{
    int m1 = 0, n1 = 0, l1 = 0, m2 = 0, n2 = 0, l2 = 0, m3 = 0, n3 = 0, l3 = 0, l4 = 0, l5 = 0;
    int four = VIEWING_RECT_SIZE ;
    int one  = 1 ;
    int * xPixCoords = NULL;
    int * yPixCoords = NULL;
    double * xCoords = NULL;
    double * yCoords = NULL;
    int viewingRect[VIEWING_RECT_SIZE];

    CheckRhs(3, 3);
    CheckLhs(1, 3);

    GetRhsVar(3, STRING_DATATYPE, &m3, &n3, &l3);


    /* Convert coordinates */
    if ( strcmp(cstk(l3), "i2f") == 0)
    {
        GetRhsVar(1, MATRIX_OF_INTEGER_DATATYPE, &m1, &n1, &l1);
        GetRhsVar(2, MATRIX_OF_INTEGER_DATATYPE, &m2, &n2, &l2);
        CheckSameDims(1, 2, m1, n1, m2, n2);

        CreateVar(Rhs + 1, MATRIX_OF_DOUBLE_DATATYPE, &m1, &n1, &l3);
        CreateVar(Rhs + 2, MATRIX_OF_DOUBLE_DATATYPE, &m1, &n1, &l4);
        /* Get rectangle */
        CreateVar(Rhs + 3, MATRIX_OF_DOUBLE_DATATYPE, &one, &four, &l5);

        xPixCoords = istk(l1);
        yPixCoords = istk(l2);
        xCoords = stk(l3);
        yCoords = stk(l4);

        convertPixelCoordsToUserCoords(xPixCoords, yPixCoords,
                                       xCoords, yCoords,
                                       m1 * n1, viewingRect );

    }
    else
    {
        GetRhsVar(1, MATRIX_OF_DOUBLE_DATATYPE, &m1, &n1, &l1);
        GetRhsVar(2, MATRIX_OF_DOUBLE_DATATYPE, &m2, &n2, &l2);
        CheckSameDims(1, 2, m1, n1, m2, n2);

        CreateVar(Rhs + 1, MATRIX_OF_INTEGER_DATATYPE, &m1, &n1, &l3);
        CreateVar(Rhs + 2, MATRIX_OF_INTEGER_DATATYPE, &m1, &n1, &l4);
        /* Get rectangle */
        CreateVar(Rhs + 3, MATRIX_OF_DOUBLE_DATATYPE, &one, &four, &l5);

        xCoords = stk(l1);
        yCoords = stk(l2);
        xPixCoords = istk(l3);
        yPixCoords = istk(l4);

        convertUserCoordToPixelCoords(xCoords, yCoords,
                                      xPixCoords, yPixCoords,
                                      m1 * n1, viewingRect);
    }

    *stk(l5) = (double)viewingRect[0];
    *stk(l5 + 1) = (double)viewingRect[1];
    *stk(l5 + 2) = (double)viewingRect[2];
    *stk(l5 + 3) = (double)viewingRect[3];

    LhsVar(1) = Rhs + 1;
    LhsVar(2) = Rhs + 2;
    LhsVar(3) = Rhs + 3;
    PutLhsVar();
    return 0;
}
/*--------------------------------------------------------------------------*/

#undef VIEWING_RECT_SIZE

