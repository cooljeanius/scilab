/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Allan Cornet
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
 * Copyright (C) 2011 - DIGITEO - Manuel Juliachs
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
/* file: get_segs_color_property.c                                        */
/* desc : function to retrieve in Scilab the segs_color field             */
/*        of a handle                                                     */
/*------------------------------------------------------------------------*/

#include "getHandleProperty.h"
#include "GetProperty.h"
#include "returnProperty.h"
#include "Scierror.h"
#include "localization.h"
#include "MALLOC.h"

#include "getGraphicObjectProperty.h"
#include "graphicObjectProperties.h"

/*------------------------------------------------------------------------*/
int get_segs_color_property(void* _pvCtx, char* pobjUID)
{
    int* segsColors = NULL;
    int iNbSegs = 0;
    int *piNbSegs = &iNbSegs;
    int status = -1;

    getGraphicObjectProperty(pobjUID, __GO_SEGS_COLORS__, jni_int_vector, (void **)&segsColors);

    if (segsColors == NULL)
    {
        Scierror(999, _("'%s' property does not exist for this handle.\n"),"segs_color");
        return -1;
    }

    /* convert from int array to double one. */
    getGraphicObjectProperty(pobjUID, __GO_NUMBER_ARROWS__, jni_int, (void**)&piNbSegs);
    status = sciReturnRowIntVector(_pvCtx, segsColors, iNbSegs);
    return status;
}
/*------------------------------------------------------------------------*/
