/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004 - INRIA - Djalel Abdemouche
 * Copyright (C) 2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
 * Copyright (C) 2006 - INRIA - Vincent Couvert
 * Copyright (C) 2011 - DIGITEO - Vincent Couvert
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*------------------------------------------------------------------------*/
/* file: sci_get.c                                                        */
/* desc : interface for sci_get routine                                   */
/*------------------------------------------------------------------------*/
#include "gw_graphics.h"
/*--------------------------------------------------------------------------*/

#include "stack-c.h"
#include "HandleManagement.h"

#include "GetHashTable.h"
#include "BuildObjects.h"
#include "localization.h"
#include "Scierror.h"

#include "HandleManagement.h"
#include "CurrentObject.h"
#include "CurrentSubwin.h"
#include "getConsoleIdentifier.h"
#include "returnProperty.h"

#include "SetPropertyStatus.h"
#include "GetScreenProperty.h"
#include "freeArrayOfString.h"
#include "api_scilab.h"
/*--------------------------------------------------------------------------*/
int sciGet(void* _pvCtx, char *pobjUID, char *marker);

/*--------------------------------------------------------------------------*/
int sciGet(void* _pvCtx, char *pobjUID, char *marker)
{
    /* find the function in the hashtable relative to the property name */
    /* and call it */
    return callGetProperty(_pvCtx, pobjUID, marker);
}

/*--------------------------------------------------------------------------*/
int sci_get(char *fname, unsigned long fname_len)
{
    int m1 = 0, n1 = 0, numrow2 = 0, numcol2 = 0, l2 = 0;
    int l1 = 0;
    long hdl = 0;

    int lw = 0;
    char *pobjUID = NULL;

    /* Root properties */
    char **stkAdr = NULL;
    int status = SET_PROPERTY_ERROR;

    if ((VarType(1) == sci_mlist) || (VarType(1) == sci_tlist))
    {
        lw = 1 + Top - Rhs;
        C2F(overload) (&lw, "get", 3);
        return 0;
    }

    CheckRhs(1, 2);
    CheckLhs(0, 1);

    /*  set or create a graphic window */

    /*
     * The first input argument can be an ID or a marker (in this case, get returns the value of the current object */
    switch (VarType(1))
    {
        case 1:                    /* tclsci handle */
            GetRhsVar(1, MATRIX_OF_DOUBLE_DATATYPE, &m1, &n1, &l1);
            if ((int)*stk(l1) == 0) /* Root property */
            {
                if (Rhs == 1)
                {
                    if (sciReturnHandle(pvApiCtx, getHandle(getConsoleIdentifier())) != 0)    /* Get Console handle */
                    {
                        /* An error has occurred */
                        PutLhsVar();
                        return 0;
                    }
                    LhsVar(1) = Rhs + 1;
                    PutLhsVar();
                    return 0;
                }
                CheckRhs(2, 2);
                if (VarType(2) == sci_strings)
                {
                    GetRhsVar(2, MATRIX_OF_STRING_DATATYPE, &m1, &n1, &stkAdr);

                    if (m1 * n1 != 1)
                    {
                        freeArrayOfString(stkAdr, m1 * n1);
                        Scierror(999, _("%s: Wrong type for input argument #%d: Single string expected.\n"), "get", 2);
                        return SET_PROPERTY_ERROR;
                    }

                    status = GetScreenProperty(pvApiCtx, stkAdr[0]);

                    if (status != SET_PROPERTY_SUCCEED) /* Return property */
                    {
                        Scierror(999, _("%s: Could not read property '%s' for root object.\n"), "get", stkAdr[0]);
                        freeArrayOfString(stkAdr, m1 * n1);
                        return FALSE;
                    }
                    freeArrayOfString(stkAdr, m1 * n1);
                }
                else
                {
                    Scierror(999, _("%s: Wrong type for input argument #%d: Single string expected.\n"), "get", 2);
                    return FALSE;
                }
                LhsVar(1) = Rhs + 1;
                PutLhsVar();
            }
            else                    /* tclsci handle: should no more happen */
            {
                lw = 1 + Top - Rhs;
                C2F(overload) (&lw, "get", 3);
            }
            return 0;
            break;
        case sci_handles:          /* scalar argument (hdl + string) */
            CheckRhs(2, 2);
            GetRhsVar(1, GRAPHICAL_HANDLE_DATATYPE, &m1, &n1, &l1);
            if (m1 != 1 || n1 != 1)
            {
                lw = 1 + Top - Rhs;
                C2F(overload) (&lw, "get", 3);
                return 0;
            }
            GetRhsVar(2, STRING_DATATYPE, &numrow2, &numcol2, &l2);
            hdl = (long) * hstk(l1); /* on recupere le pointeur d'objet par le handle */
            break;
        case sci_strings:          /* string argument (string) */
            CheckRhs(1, 1);
            GetRhsVar(1, STRING_DATATYPE, &numrow2, &numcol2, &l2);
            if (strcmp(cstk(l2), "default_figure") != 0 && strcmp(cstk(l2), "default_axes") != 0)
            {
                if (strcmp(cstk(l2), "current_figure") == 0 || strcmp(cstk(l2), "current_axes") == 0 || strcmp(cstk(l2), "current_entity") == 0
                        || strcmp(cstk(l2), "hdl") == 0 || strcmp(cstk(l2), "figures_id") == 0)
                {
                    hdl = 0;
                }
                else
                {
                    /* Test debug F.Leray 13.04.04 */
                    if ((strcmp(cstk(l2), "children") != 0) && (strcmp(cstk(l2), "zoom_") != 0) && (strcmp(cstk(l2), "clip_box") != 0)
                            && (strcmp(cstk(l2), "auto_") != 0))
                    {
                        getOrCreateDefaultSubwin();
                        hdl = getHandle(getCurrentObject());
                    }
                    else
                    {
                        hdl = getHandle(getCurrentSubWin());    /* on recupere le pointeur d'objet par le handle */
                    }
                }                   /* DJ.A 08/01/04 */
            }
            else
            {
                hdl = 0;
            }
            break;
        default:
            lw = 1 + Top - Rhs;
            C2F(overload) (&lw, "get", 3);
            return 0;
            break;
    }
    /* cstk(l2) est la commande, l3 l'indice sur les parametres de la commande */
    CheckLhs(0, 1);

    if (hdl == 0)
    {
        /* No handle specified */
        if (sciGet(pvApiCtx, NULL, cstk(l2)) != 0)
        {
            /* An error has occurred */
            PutLhsVar();
            return 0;
        }
    }
    else
    {
        pobjUID = (char*)getObjectFromHandle(hdl);
        if (pobjUID != NULL)
        {

            if (sciGet(pvApiCtx, pobjUID, cstk(l2)) != 0)
            {
                /* An error has occurred */
                PutLhsVar();
                return 0;
            }
        }
        else
        {
            Scierror(999, _("%s: The handle is not or no more valid.\n"), fname);
            return 0;
        }
    }

    LhsVar(1) = Rhs + 1;
    PutLhsVar();

    return 0;
}

/*--------------------------------------------------------------------------*/
