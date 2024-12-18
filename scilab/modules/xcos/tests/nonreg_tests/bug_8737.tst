// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 8737 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=8737
//
// <-- Short Description -->
// Hidden links should not be ordered when exported

status = importXcosDiagram(SCI + "/modules/xcos/tests/nonreg_tests/bug_8737.xcos");
if ~status then pause, end

// compile and simulate
scicos_simulate(scs_m, list(), struct(), "nw");

