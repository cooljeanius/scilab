/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009-2011 - DIGITEO - Vincent COUVERT
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "SetUimenuChecked.hxx"

int SetUimenuChecked(void* _pvCtx, char *pobjUID, size_t stackPointer, int valueType, int nbRow, int nbCol)
{
    int b = (int)FALSE;
    BOOL status = FALSE;

    b = tryGetBooleanValueFromStack(stackPointer, valueType, nbRow, nbCol,
                                    const_cast<char *>("Checked"));
    if (b == NOT_A_BOOLEAN_VALUE)
    {
        return SET_PROPERTY_ERROR;
    }

    status = setGraphicObjectProperty(pobjUID, __GO_UI_CHECKED__, &b, jni_bool, 1);

    if (status == TRUE)
    {
        return SET_PROPERTY_SUCCEED;
    }
    else
    {
        Scierror(999, _("'%s' property does not exist for this handle.\n"), "Checked");
        return SET_PROPERTY_ERROR;
    }
}
