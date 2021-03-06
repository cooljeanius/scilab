/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Sylvestre LEDRU
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/* !!! PLEASE DO NOT TRANSLATE STRINGS IN THIS FILE SEE BUG 5505 !!! */

#include <stdio.h>
#include <string.h>
#include <stdio.h>
#include <libxml/xmlversion.h>

#ifdef WITH_TK
# include <tcl.h>
# include <tk.h>
#endif /* WITH_TK */


/* ifdef-ed for now: */
#ifdef YES_I_REALLY_WANT_TO_USE_UMFPACK
# ifdef WITH_UMFPACK
#  ifdef UMFPACK_SUITESPARSE
#   include <suitesparse/umfpack.h>
#  else
#   include <umfpack.h>
#  endif /* UMFPACK_SUITESPARSE */
# endif /* WITH_UMFPACK */
#endif /* YES_I_REALLY_WANT_TO_USE_UMFPACK */

#include "MALLOC.h"
#include "getstaticdebuginfo.h"
#include "version.h"

char **getStaticDebugInfo(int *sizeArray)
{
    char **outputStaticList = NULL;
    int i;

    static debug_message staticDebug[NB_DEBUG_ELEMENT] =
    {
#ifdef SCI_VERSION_STRING
        {"Scilab Version", SCI_VERSION_STRING},
#endif
#ifdef __DATE__
        {"Compilation date", __DATE__},
#endif
#ifdef __TIME__
        {"Compilation time", __TIME__},
#endif
#ifdef __VERSION__
        {"Compileur version", __VERSION__},
#endif
#ifdef LIBXML_DOTTED_VERSION
        {"XML version", LIBXML_DOTTED_VERSION},
#endif
#ifdef LIBXML_FLAGS
        {"XML compilation flags", LIBXML_FLAGS},
#endif
#ifdef LIBXML_LIBS
        {"XML libraries", LIBXML_LIBS},
#endif
#ifdef PCRE_VERSION
        {"PCRE version", PCRE_VERSION},
#endif
#ifdef PCRE_FLAGS
        {"PCRE compilation flags", PCRE_FLAGS},
#endif
#ifdef PCRE_LIBS
        {"PCRE libraries", PCRE_LIBS},
#endif
#ifdef TCL_PATCH_LEVEL
        {"TCL version", TCL_PATCH_LEVEL},
#endif
#ifdef TK_PATCH_LEVEL
        {"TK version", TK_PATCH_LEVEL},
#endif
#ifdef SHARED_LIB_EXT
        {"Shared library extension", SHARED_LIB_EXT},
#endif
#ifdef WITH_GUI
        {"Scilab GUI", "Enable"},
#endif
#ifdef WITH_FFTW
        {"FFTW", "Enable"},
#endif
#ifdef PATH_SEPARATOR
        {"Path separator", PATH_SEPARATOR},
#endif
#ifdef DIR_SEPARATOR
        {"Directory separator", DIR_SEPARATOR},
#endif
#ifdef WITH_UMFPACK
        {"UMFPACK", "Enable"},
#ifdef UMFPACK_VERSION
        {"UMFPACK version", UMFPACK_VERSION},
#endif
#ifdef UMFPACK_VERSION
        {"UMFPACK version", UMFPACK_VERSION},
#endif
#endif
#ifndef _LP64
        {"Compiler Architecture", "X86"},
#endif
#ifdef _LP64
        {"Compiler Architecture", "X64"},
#endif
    };

    for (i = 0; i < NB_DEBUG_ELEMENT; i++)
    {
        debug_message msg = staticDebug[i];
        size_t osl_len;
        size_t osl_i_len;

        if (msg.description == NULL)    /* We reach the end of the static list */
        {
            break;
        }

        if (outputStaticList)
        {
            /* Alloc the big list */
            osl_len = (sizeof(char *) * ((size_t)i + 1UL));
            outputStaticList = (char **)REALLOC(outputStaticList, osl_len);
        }
        else
        {
            osl_len = (sizeof(char *) * ((size_t)i + 1UL));
            outputStaticList = (char **)MALLOC(osl_len);
        }

        /* Create the element in the array */
        /* 3 for :, space and \0 */
        /* 2 for -Wformat-truncation */
        osl_i_len = ((strlen(msg.description) + strlen(msg.value) + 3UL + 2UL)
                     * sizeof(char));
        outputStaticList[i] = (char *)MALLOC(osl_i_len);
        snprintf(outputStaticList[i], osl_i_len, "%s: %s", msg.description,
                 msg.value);
    }
    *sizeArray = i;
    return outputStaticList;
}
