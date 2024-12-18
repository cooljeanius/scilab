/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2006 - INRIA - Allan CORNET
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "gw_optimization.h"
#include "machine.h"
/*--------------------------------------------------------------------------*/
extern int C2F(intreadmps)(int *id);
/*--------------------------------------------------------------------------*/
int sci_readmps(char *fname,unsigned long fname_len)
{
	static int id[6];
	C2F(intreadmps)(id);
	return 0;
}
/*--------------------------------------------------------------------------*/
