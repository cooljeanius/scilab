// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009-2010 - INRIA - pierre.lando@scilab.org
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
//
// <-- Non-regression test for bug 4979 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=4979
//
// <-- Short Description -->
// Use unzoom on an empty figure resulted to a warning message :
// Warning !!!
// Scilab has found a critical error (Unknow exception).
// Save your data and restart Scilab.

clf(gcf(),'reset');
zoom_rect([0,0,1,1]);
unzoom();
a=gca();
if a.zoom_box != [] then pause;end;
// should not display any warning or error
