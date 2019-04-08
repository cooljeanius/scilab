
/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) INRIA - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __SCIERROR__
#define __SCIERROR__

#include <stdarg.h>

#ifdef __cplusplus
extern "C" {
#endif
#include "do_error_number.h"

#ifndef ATTRIBUTE_PRINTF
# define ATTRIBUTE_PRINTF(m, n) __attribute__((__format__(__printf__, m, n)))
#endif /* ATTRIBUTE_PRINTF */

/*
* as sciprint but with an added first argument
* which is ignored (used in do_printf)
* @param iv error code
* @param fmt
* @param ...
*/
extern int Scierror(int iv, const char *fmt, ...) ATTRIBUTE_PRINTF(2, 3);

#ifdef __cplusplus
}
#endif
#endif /* __SCIERROR__ */
/*--------------------------------------------------------------------------*/
