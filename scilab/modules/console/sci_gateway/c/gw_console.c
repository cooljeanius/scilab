/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Allan CORNET
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
/*--------------------------------------------------------------------------*/
#include <string.h>
#include "gw_console.h"
#include "api_scilab.h"
#include "MALLOC.h"
#include "callFunctionFromGateway.h"
/*--------------------------------------------------------------------------*/
static gw_generic_table Tab[]=
{
{sci_clc,"clc"},
{sci_tohome,"tohome"},
{sci_lines,"lines"},
{sci_prompt,"prompt"},
{sci_iswaitingforinput,"iswaitingforinput"}
};
/*--------------------------------------------------------------------------*/
int gw_console(void)
{  
	Rhs = Max(0, Rhs);

	if(pvApiCtx == NULL)
	{
		pvApiCtx = (StrCtx*)MALLOC(sizeof(StrCtx));
	}

	pvApiCtx->pstName = (char*)Tab[Fin-1].name;
    callFunctionFromGateway(Tab,SIZE_CURRENT_GENERIC_TABLE(Tab));
	return 0;
}
/*--------------------------------------------------------------------------*/
