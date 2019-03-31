/*
 *  dummy.c
 *  scilab-Xcode
 *
 *  Created by Eric Gallager on 3/30/19.
 *  Copyright 2019 George Washington University. All rights reserved.
 *
 */

#include "dummy.h"

void we_must_provide_at_least_one_object_file(void)
{
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
    __asm__("");
#endif /* __GNUC__ && !__STRICT_ANSI__ */
    return;
}
