
/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2006-2008 - INRIA - Allan CORNET <allan.cornet@inria.fr>
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __GW_RANDLIB_H__
#define __GW_RANDLIB_H__
/*--------------------------------------------------------------------------*/ 
#include "dynlib_randlib.h"
/*--------------------------------------------------------------------------*/ 
RANDLIB_IMPEXP int gw_randlib(void);
/*--------------------------------------------------------------------------*/ 
RANDLIB_IMPEXP int sci_Rand(char *fname,unsigned long fname_len);
/*--------------------------------------------------------------------------*/ 
#endif /* __GW_RANDLIB_H__ */
/*--------------------------------------------------------------------------*/
