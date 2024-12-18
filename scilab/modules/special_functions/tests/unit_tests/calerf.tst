// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
deff('y=f(t)','y=exp(-t^2)');
r = calerf(1,0);
ref = 2/sqrt(%pi)*intg(0,1,f);
if abs(r - ref) > %eps then pause,end
