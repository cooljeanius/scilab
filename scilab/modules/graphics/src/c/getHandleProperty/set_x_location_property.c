/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Allan Cornet
 * Copyright (C) 2006 - INRIA - Jean-Baptiste Silvy
 * Copyright (C) 2009 - DIGITEO - Pierre Lando
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
/* file: set_x_location_property.c                                        */
/* desc : function to modify in Scilab the x_location field of            */
/*        a handle                                                        */
/*------------------------------------------------------------------------*/

#include "setHandleProperty.h"
#include "SetProperty.h"
#include "getPropertyAssignedValue.h"
#include "SetPropertyStatus.h"
#include "Scierror.h"
#include "localization.h"

#include "setGraphicObjectProperty.h"
#include "graphicObjectProperties.h"

/*------------------------------------------------------------------------*/
int set_x_location_property(void* _pvCtx, char* pobjUID, size_t stackPointer, int valueType, int nbRow, int nbCol )
{
    BOOL status = FALSE;
    int axisLocation = 0;

    if ( !( valueType == sci_strings ) )
    {
        Scierror(999, _("Wrong type for '%s' property: String expected.\n"), "x_location");
        return SET_PROPERTY_ERROR;
    }

    if ( isStringParamEqual( stackPointer, "bottom" ) )
    {
        axisLocation = 0;
    }
    else if ( isStringParamEqual( stackPointer, "top" ) )
    {
        axisLocation = 1;
    }
    else if ( isStringParamEqual( stackPointer, "middle" ) )
    {
        axisLocation = 2;
    }
    else if ( isStringParamEqual( stackPointer, "origin" ) )
    {
        axisLocation = 3;
    }
    else
    {
        Scierror(999, _("Wrong value for '%s' property: Must be in the set {%s}.\n"), "x_location", "bottom, top, middle, origin");
        return SET_PROPERTY_ERROR ;
    }

    status = setGraphicObjectProperty(pobjUID, __GO_X_AXIS_LOCATION__, &axisLocation, jni_int, 1);

    if (status == TRUE)
    {
        return SET_PROPERTY_SUCCEED ;
    }
    else
    {
        Scierror(999, _("'%s' property does not exist for this handle.\n"), "x_location");
        return SET_PROPERTY_ERROR;
    }
}
/*------------------------------------------------------------------------*/
