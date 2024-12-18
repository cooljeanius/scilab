// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Yann COLLETTE <yann.collette@scilab.org>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
//
// <-- ENGLISH IMPOSED -->
//
// <-- Non-regression test for bug 5462 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=5462
//
// <-- Short Description -->
// Can not save correctly a sparse matrix in a MAT-file using savematfile.

A = sprand(1000,1000,0.01);
savematfile('test_matfile.mat','A');
A1 = A;
clear A
loadmatfile('test_matfile.mat','A');

if (norm(A1 - A)>=10*%eps) then pause,end
