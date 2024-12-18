// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 4620 -->
//

// <-- Short Description -->
// the setenv function makes scilab hangs 
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=4620
//

A = 1:100000;
B = strcat(string(A),'');
r = setenv('TEST_FOO',B);
if r <> %f then pause,end                    