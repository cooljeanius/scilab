/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) INRIA
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __FINITE_H__
#define __FINITE_H__

#include "doublecomplex.h"
#include "dynlib_elementary_functions.h"

#if (!defined(HAVE_FINITE) && !defined(HAVE_DECL_FINITE) && !defined(finite) && !defined(__MATH__)) \
    || defined(S_SPLINT_S)
ELEMENTARY_FUNCTIONS_IMPEXP int finite(double x);
#endif /* missing finite, or using splint */

ELEMENTARY_FUNCTIONS_IMPEXP int finiteComplex(doublecomplex x);

#endif /* __FINITE_H__ */
