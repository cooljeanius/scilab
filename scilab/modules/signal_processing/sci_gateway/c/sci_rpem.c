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

#include <string.h>
#include "gw_signal.h"
/*--------------------------------------------------------------------------*/
extern int C2F(scirpem)(char *id,unsigned long fname_len);
/*--------------------------------------------------------------------------*/
int C2F(sci_rpem)(char *fname,unsigned long fname_len)
{
	C2F(scirpem)(fname,fname_len);
	return 0;
}
/*--------------------------------------------------------------------------*/
