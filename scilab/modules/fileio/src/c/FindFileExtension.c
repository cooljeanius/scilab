/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Allan CORNET
 * ...
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
/*--------------------------------------------------------------------------*/
#if _MSC_VER
#include <Windows.h>
#include <shlwapi.h>
#pragma comment(lib, "shlwapi.lib")
#include "strdup_windows.h"
#else
#include <string.h>
#include <stdio.h>
#endif
#include "FindFileExtension.h"
#include "MALLOC.h"
#include "charEncoding.h"
/*--------------------------------------------------------------------------*/
char *FindFileExtension(char *filename)
{
    char *extension = NULL;
    if (filename)
    {
#ifndef _MSC_VER
        int lengthfilename = (int) strlen(filename);
        int  i = lengthfilename;

        while (filename[i] != '.' && i > 0)
        {
            i--;
        }

        if (i > 0)
        {
            int lengthextension = (lengthfilename - i);
            const size_t extension_amt = (sizeof(char) * (lengthextension + 1UL));
            extension = (char *)MALLOC(extension_amt);
            if (extension) snprintf(extension, extension_amt, "%s",
                                        &filename[i]);
        }
#else
        {
            wchar_t *wcFilename = to_wide_string(filename);
            if (wcFilename)
            {
                extension = wide_string_to_UTF8(PathFindExtensionW(wcFilename));
                FREE(wcFilename);
                wcFilename = NULL;
            }
        }
#endif
    }
    return extension;
}
/*--------------------------------------------------------------------------*/
