// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
// <-- ENGLISH IMPOSED -->
//
// <-- Non-regression test for bug 7363 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7363
//
// <-- Short Description -->
// CBLOCK block produce an error when opening parameters

ilib_verbose(0);

loadXcosLibs(); loadScicos();

// stubbing dialogs
prot = funcprot();
funcprot(0);

function %str=x_mdialog(%desc,%labels,%ini)
    %str=%ini;
endfunction

function str_out = dialog(kind, str_in) ;
    str_out = str_in;
endfunction

funcprot(prot);

// start test
o = CBLOCK("define");
o = CBLOCK("set", o);

