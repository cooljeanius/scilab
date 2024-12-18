/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 * Copyright (C) 2006 - INRIA - Allan Cornet
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
/* file: set_parent_property.c                                            */
/* desc : function to modify in Scilab the parent field of                */
/*        a handle                                                        */
/*------------------------------------------------------------------------*/

#include <string.h>

#include "sci_types.h"
#include "setHandleProperty.h"
#include "getPropertyAssignedValue.h"
#include "Scierror.h"
#include "localization.h"
#include "SetPropertyStatus.h"
#include "GetProperty.h"
#include "InitUIMenu.h"
#include "setGraphicObjectProperty.h"
#include "getGraphicObjectProperty.h"
#include "graphicObjectProperties.h"
#include "HandleManagement.h"
#include "FigureList.h"

/*------------------------------------------------------------------------*/
int set_parent_property(void* _pvCtx, char* pobjUID, size_t stackPointer, int valueType, int nbRow, int nbCol)
{
    char *pstParentUID = NULL;
    int iParentType = -1;
    int *piParentType = &iParentType;
    int iParentStyle = -1;
    int *piParentStyle = &iParentStyle;
    int iObjType = -1;
    int *piObjType = &iObjType;

    getGraphicObjectProperty(pobjUID, __GO_TYPE__, jni_int, (void **)&piObjType);

    if (iObjType == __GO_UICONTROL__)
    {
        if (valueType == sci_handles)
        {
            pstParentUID = (char*)getObjectFromHandle(getHandleFromStack(stackPointer));
        }
        else if (valueType == sci_matrix)
        {
            pstParentUID = (char*)getFigureFromIndex((int)getDoubleMatrixFromStack(stackPointer)[0]);
        }
        else
        {
            Scierror(999, _("Wrong type for '%s' property: '%s' handle or '%s' handle expected.\n"), "parent", "Figure", "Frame uicontrol");
            return SET_PROPERTY_ERROR;
        }

        if (pstParentUID == NULL)
        {
            // Can not set the parent
            Scierror(999, _("Wrong value for '%s' property: A '%s' or '%s' handle expected.\n"), "Parent", "Figure", "Frame uicontrol");
            return SET_PROPERTY_ERROR;
        }

        getGraphicObjectProperty(pstParentUID, __GO_TYPE__, jni_int, (void **)&piParentType);

        if (iParentType != __GO_FIGURE__)
        {
            getGraphicObjectProperty(pstParentUID, __GO_STYLE__, jni_int, (void **)&piParentStyle);
            if (iParentType != __GO_UICONTROL__ || iParentStyle != __GO_UI_FRAME__)
            {
                Scierror(999, _("Wrong value for '%s' property: A '%s' or '%s' handle expected.\n"), "Parent", "Figure", "Frame uicontrol");
                return SET_PROPERTY_ERROR;
            }
        }

        setGraphicObjectRelationship(pstParentUID, pobjUID);
        return SET_PROPERTY_SUCCEED;
    }

    if (iObjType == __GO_UIMENU__)
    {
        if ((valueType != sci_handles) && (valueType != sci_matrix))    /* sci_matrix used for adding menus in console menu */
        {
            Scierror(999, _("Wrong type for '%s' property: '%s' handle or '%s' handle expected.\n"), "parent", "Figure", "Uimenu");
            return SET_PROPERTY_ERROR;
        }
        else
        {
            return setMenuParent(pobjUID, stackPointer, valueType, nbRow, nbCol);
        }
    }
    else
    {
        Scierror(999, _("Parent property can not be modified directly.\n"));
        return SET_PROPERTY_ERROR;
    }
}

/*------------------------------------------------------------------------*/
