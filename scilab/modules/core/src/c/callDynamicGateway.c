/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Allan CORNET
 * Copyright (C) 2008 - INRIA - Sylvestre LEDRU
 * Copyright (C) 2010 - DIGITEO - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "machine.h"
#include "callDynamicGateway.h"
#include "MALLOC.h"
#include "Scierror.h"
#include "sciprint.h"
#include "localization.h"
#include "setgetSCIpath.h"
#include "getshortpathname.h"
#include "BOOL.h"
#include "charEncoding.h"
/*--------------------------------------------------------------------------*/
dynamic_gateway_error_code callDynamicGateway(char *moduleName,
        char *dynLibName,
        char *gw_name,
        DynLibHandle *hlib,
        PROC_GATEWAY *ptrGateway)
{
    if (*hlib == NULL)
    {
        /* Under Linux/Unix, load thanks to dlopen */
#ifdef _MSC_VER
        wchar_t *wcdynLibName = to_wide_string(dynLibName);
        if (wcdynLibName)
        {
            *hlib = LoadDynLibraryW(wcdynLibName);
            FREE(wcdynLibName);
            wcdynLibName = NULL;
        }
        if (*hlib == NULL)
        {
            return DYN_GW_LOAD_LIBRARY_ERROR;
        }
#else
        *hlib = LoadDynLibrary(dynLibName);

        if (*hlib == NULL)
        {
            char *previousError = GetLastDynLibError();

            /* Haven't been able to find the lib with dlopen...
            * This can happen for two reasons:
            * - the lib must be dynamically linked
            * - Some silly issues under Suse (see bug #2875)
            * Note that we are handling only the "source tree build"
            * because libraries are split (they are in the same directory
            * in the binary)
            */
            char *SciPath = getSCIpath();
#define PATHTOMODULE "/modules/"
#ifndef LT_OBJDIR
#define LT_OBJDIR ".libs/"
#endif

            /* Build the full path to the library */
            size_t pathToLib_len = ((strlen(SciPath) + strlen(PATHTOMODULE)
                                     + strlen(moduleName) + strlen("/")
                                     + strlen(LT_OBJDIR) + strlen(dynLibName) + 1UL)
                                    * sizeof(char));
            char *pathToLib = (char *)MALLOC(pathToLib_len);
            snprintf(pathToLib, pathToLib_len, "%s%s%s/%s%s", SciPath,
                     PATHTOMODULE, moduleName, LT_OBJDIR, dynLibName);

            *hlib = LoadDynLibrary(pathToLib);

            if (*hlib == NULL)
            {
                if (previousError != NULL)
                {
                    sciprint("A previous error has been detected while loading %s: %s\n", dynLibName, previousError);
                }
                if (SciPath)
                {
                    FREE(SciPath);
                    SciPath = NULL;
                }
                if (pathToLib)
                {
                    FREE(pathToLib);
                    pathToLib = NULL;
                }
                return DYN_GW_LOAD_LIBRARY_ERROR;
            }
            if (SciPath)
            {
                FREE(SciPath);
                SciPath = NULL;
            }
            if (pathToLib)
            {
                FREE(pathToLib);
                pathToLib = NULL;
            }
        }
#endif
    }

    if (*ptrGateway == NULL)
    {
        *ptrGateway = (PROC_GATEWAY) GetDynLibFuncPtr(*hlib, gw_name);
        if (*ptrGateway == NULL)
        {
            return DYN_GW_PTR_FUNCTION_ERROR ;
        }
    }

    if ( (*hlib) && (*ptrGateway) )
    {
        (*ptrGateway)();
        return DYN_GW_NO_ERROR;
    }

    return DYN_GW_CALL_FUNCTION_ERROR;
}
/*--------------------------------------------------------------------------*/
char *buildModuleDynLibraryName(char *modulename, dynlib_name_format iType)
{
    char *dynlibname = NULL;
    size_t lenName = (strlen(modulename) + strlen(SHARED_LIB_EXT));
    size_t dynlibname_len;
    switch (iType)
    {
        case DYNLIB_NAME_FORMAT_AUTO:
        default:
#ifdef _MSC_VER
            lenName = lenName + strlen(FORMATGATEWAYLIBNAME_1);
#else
            lenName = lenName + strlen(FORMATGATEWAYLIBNAME_3);
#endif
            dynlibname_len = (sizeof(char) * (lenName + 1UL));
            dynlibname = (char *)MALLOC(dynlibname_len);
            if (dynlibname)
            {
#ifdef _MSC_VER
                snprintf(dynlibname, dynlibname_len, FORMATGATEWAYLIBNAME_1,
                         modulename, SHARED_LIB_EXT);
#else
                snprintf(dynlibname, dynlibname_len, FORMATGATEWAYLIBNAME_3,
                         modulename, SHARED_LIB_EXT);
#endif
            }
            break;
        case DYNLIB_NAME_FORMAT_1:
            lenName = lenName + strlen(FORMATGATEWAYLIBNAME_1);
            dynlibname_len = (sizeof(char) * (lenName + 1UL));
            dynlibname = (char *)MALLOC(dynlibname_len);
            if (dynlibname)
            {
                snprintf(dynlibname, dynlibname_len, FORMATGATEWAYLIBNAME_1,
                         modulename, SHARED_LIB_EXT);
            }
            break;
        case DYNLIB_NAME_FORMAT_2:
            lenName = lenName + strlen(FORMATGATEWAYLIBNAME_2);
            dynlibname_len = (sizeof(char) * (lenName + 1UL));
            dynlibname = (char *)MALLOC(dynlibname_len);
            if (dynlibname)
            {
                snprintf(dynlibname, dynlibname_len, FORMATGATEWAYLIBNAME_2,
                         modulename, SHARED_LIB_EXT);
            }
            break;
        case DYNLIB_NAME_FORMAT_3:
            lenName = lenName + strlen(FORMATGATEWAYLIBNAME_3);
            dynlibname_len = (sizeof(char) * (lenName + 1UL));
            dynlibname = (char *)MALLOC(dynlibname_len);
            if (dynlibname)
            {
                snprintf(dynlibname, dynlibname_len, FORMATGATEWAYLIBNAME_3,
                         modulename, SHARED_LIB_EXT);
            }
            break;
    }
    return dynlibname;
}
/*--------------------------------------------------------------------------*/
char *buildGatewayName(char *modulename)
{
    /* example gw_scicos */
#define FORMATGATEWAYNAME "gw_%s"

    char *gatewayname = NULL;
    const size_t lenName = (strlen(modulename) + strlen(FORMATGATEWAYNAME));
    const size_t gatewayname_len = (sizeof(char) * (lenName + 1UL));
    gatewayname = (char *)MALLOC(gatewayname_len);

    if (gatewayname)
    {
        snprintf(gatewayname, gatewayname_len, FORMATGATEWAYNAME, modulename);
    }

    return gatewayname;
}
/*--------------------------------------------------------------------------*/
void displayErrorGateway(dynamic_gateway_error_code err, char *libraryname, char *functionname)
{
    switch (err)
    {
        case DYN_GW_NO_ERROR :
            /* NO ERROR */
            break;
        case DYN_GW_LOAD_LIBRARY_ERROR :
            Scierror(999, _("Impossible to load %s library: %s\n"), libraryname, GetLastDynLibError());
            break;
        case DYN_GW_PTR_FUNCTION_ERROR :
            Scierror(999, _("Impossible to load %s function in %s library: %s\n"), functionname, libraryname, GetLastDynLibError());
            break;
        case DYN_GW_CALL_FUNCTION_ERROR :
            Scierror(999, _("Impossible to call %s in %s library: %s\n"), functionname, libraryname, GetLastDynLibError());
            break;
    }
}
/*--------------------------------------------------------------------------*/
BOOL freeDynamicGateway(char **dynLibName,
                        char **gw_name,
                        DynLibHandle *hlib,
                        PROC_GATEWAY *ptrGateway)
{
    if (*dynLibName)
    {
        FREE(*dynLibName);
        *dynLibName = NULL;
    }

    if (*gw_name)
    {
        FREE(*gw_name);
        *gw_name = NULL;
    }

    if (*hlib)
    {
        FreeDynLibrary(*hlib);
        *hlib = NULL;
    }

    if (*ptrGateway)
    {
        *ptrGateway = NULL;
    }

    if ((*hlib == NULL) && (*ptrGateway == NULL))
    {
        return TRUE;
    }

    return FALSE;
}
/*--------------------------------------------------------------------------*/
