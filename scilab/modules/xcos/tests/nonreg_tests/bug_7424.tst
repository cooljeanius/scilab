// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 7424 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7424
//
// <-- Short Description -->
// Integer codec can produce a NuulPointerException

importXcosDiagram(SCI + "/modules/xcos/tests/nonreg_tests/bug_7424.xcos");
// suceed if no exception (checked on stderr).

