// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 6799 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=6799
//
// <-- Short Description -->
//  The TOWS_c.sci define the default setting in the wrong order.

loadXcosLibs;

// exec(SCI + "/modules/scicos_blocks/macros/Sinks/TOWS_c.sci");

block = TOWS_c("define", [], []);

s = size(block.graphics.exprs);

if s(1) <> 3 then pause, end
if s(2) <> 1 then pause, end

