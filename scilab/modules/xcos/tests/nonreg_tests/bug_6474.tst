/ =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- INTERACTIVE TEST -->
// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 6474 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=6474
//
// <-- Short Description -->
// demo_watertank.xcos xcos and scilab crashed when any block parameter dialog was closed the second time.

// it was easier to reproduce on Windows XP

// start scilab
// start xcos
// open demo_watertank.xcos
// run simulation
// double-click PID block
// close parameter dialog with ok (nothing needs to be changed)
// run simulation again
// double-click PID block again
// close parameter dialog with ok (nothing needs to be changed)
// xcos and scilab will crash as the dialog is closed

