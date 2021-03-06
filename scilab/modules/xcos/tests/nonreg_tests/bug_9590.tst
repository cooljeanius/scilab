// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 9590 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=9590
//
// <-- Short Description -->
// xcos examples were not embeded in binary version on Windows.

assert_checkequal(isdir("SCI/modules/xcos/examples"), %t);
assert_checkequal(isfile("SCI/modules/xcos/examples/integer_pal/en_US/JKFLIPFLOP_en_US.xcos"), %t);