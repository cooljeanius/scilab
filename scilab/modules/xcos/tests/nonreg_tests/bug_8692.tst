// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 8692 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=8692
//
// <-- Short Description -->
// Blocks null values produce an exception on export.

// open then export a diagram with null values
status = importXcosDiagram(SCI + "/modules/xcos/tests/nonreg_tests/bug_8692.xcos");
if ~status then pause, end

