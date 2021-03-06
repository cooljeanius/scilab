// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Sylvestre LEDRU
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 7715 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7715
//
// <-- Short Description -->
// Performances of xcosDiagramToHDF5 degraded after several subsequent calls to this function.


timer();
xcosDiagramToScilab(SCI+"/modules/xcos/demos/susp.xcos");
run1 = timer();

xcosDiagramToScilab(SCI+"/modules/xcos/demos/susp.xcos");

timer();
xcosDiagramToScilab(SCI+"/modules/xcos/demos/susp.xcos");
run3 = timer();

// If the computer slows for an other reasons, we might have this bug again.
// Add a XX% error
errorPercentage=1.1;

// Since all libraries are loaded the first time, the further runs are way
// faster
if run1*errorPercentage < run3 then pause, end
