/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Allan Cornet
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
 * Copyright (C) 2010 - DIGITEO - Manuel Juliachs
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*------------------------------------------------------------------------*/
/* file: set_pixel_drawing_mode_property.c                                */
/* desc : function to modify in Scilab the pixel_drawing_mode field of    */
/*        a handle                                                        */
/*------------------------------------------------------------------------*/

#include "setHandleProperty.h"
#include "SetProperty.h"
#include "getPropertyAssignedValue.h"
#include "Scierror.h"
#include "localization.h"
#include "pixel_mode.h"
#include "SetPropertyStatus.h"
#include "sci_types.h"

#include "setGraphicObjectProperty.h"
#include "graphicObjectProperties.h"

/*------------------------------------------------------------------------*/
int set_pixel_drawing_mode_property(void* _pvCtx, char* pobjUID, size_t stackPointer, int valueType, int nbRow, int nbCol )
{
    int v = -1;
    BOOL status = FALSE;

    if ( !( valueType == sci_strings ) )
    {
        Scierror(999, _("Wrong type for '%s' property: String expected.\n"), "pixel_drawing_mode");
        return SET_PROPERTY_ERROR ;
    }

    v = getPixelModeIndex( getStringFromStack( stackPointer ) ) ;

    if ( v < 0 )
    {
        Scierror(999, _("Wrong value for '%s' property: Must be in the set {%s}.\n"), "pixel_drawing_mode", "and, andReverse, andInverted, clear, copy, copyInverted, equiv, invert, noop, nor, nand, or, orReverse, orInverted, set, xor");
        return SET_PROPERTY_ERROR ;
    }

    status = setGraphicObjectProperty(pobjUID, __GO_PIXEL_DRAWING_MODE__, &v, jni_int, 1);

    if (status == TRUE)
    {
        return SET_PROPERTY_SUCCEED;
    }
    else
    {
        Scierror(999, _("'%s' property does not exist for this handle.\n"), "pixel_drawing_mode");
        return SET_PROPERTY_ERROR;
    }
}
/*------------------------------------------------------------------------*/
