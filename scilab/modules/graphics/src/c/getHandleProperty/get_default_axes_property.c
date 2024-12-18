/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Allan Cornet
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
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
/* file: get_default_axes_property.c                                      */
/* desc : function to retrieve in Scilab the default_axes field of a      */
/*        handle                                                          */
/*------------------------------------------------------------------------*/

#include "getHandleProperty.h"
#include "returnProperty.h"
#include "Scierror.h"
#include "localization.h"
#include "InitObjects.h"
#include "MALLOC.h"
#include "HandleManagement.h"
#include "AxesModel.h"
/*--------------------------------------------------------------------------*/
int get_default_axes_property(void* _pvCtx, char* pobjUID)
{

    if (pobjUID != NULL)
    {
        /* This property should not be called on an handle */
        Scierror(999, _("'%s' property does not exist for this handle.\n"), "default_axes");
        return -1;
    }

  return sciReturnHandle(_pvCtx, getHandle(getAxesModel()));
}
/*--------------------------------------------------------------------------*/
