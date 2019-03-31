/*
 *  notypes.c
 *  scilab-Xcode
 *
 *  Created by Eric Gallager on 3/30/19.
 *  Copyright 2019 George Washington University. All rights reserved.
 *
 */

#include "notypes.h"
#include "Scierror.h"
#include "localization.h"

/*--------------------------------------------------------------------------*/
int gw_types(void)
{
    Scierror(999, _("Scilab '%s' module not installed.\n"), "types");
    return 0;
}
