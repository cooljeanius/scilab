/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA
 * Copyright (C) 2012 - DIGITEO - Allan CORNET
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __VECT_AND_H__
#define __VECT_AND_H__

#define AND_ON_ALL 0
#define AND_BY_ROWS 1
#define AND_BY_COLUMNS 2

/**
 * logical "and" of the elements of an array
 *
 * @param[in] v boolean matrix as input
 * @param[in] m rows size
 * @param[in] n columns size
 * @param[out] r result of logical "and" 
 * @param[in] opt: AND_ON_ALL, AND_BY_ROWS or AND_BY_COLUMNS
 */

void vect_and(const int *v, int m, int n, int *r, int opt);

#endif /* __VECT_AND_H__ */
