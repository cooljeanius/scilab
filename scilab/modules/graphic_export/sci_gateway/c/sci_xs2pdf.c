/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Koumar Sylvestre
 * desc : interface for xs2pdf routine
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "gw_graphic_export.h"
#include "xs2file.h"

/*--------------------------------------------------------------------------*/
int sci_xs2pdf( char * fname, unsigned long fname_len )
{
  return xs2file( fname, PDF_EXPORT ) ;
}
/*--------------------------------------------------------------------------*/
