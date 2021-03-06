// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 7396 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7396
//
// <-- Short Description -->
// On I/O blocks used in SuperBlocks, empty index throws a decoding exception.

// perform a blocking decode operation
importXcosDiagram(SCI + "/modules/xcos/tests/nonreg_tests/bug_7396.xcos");

