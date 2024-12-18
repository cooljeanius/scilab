// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->

loadXcosLibs();

assert_checktrue(importXcosDiagram(SCI + "/modules/xcos/tests/unit_tests/tows_c.xcos"));
scicos_simulate(scs_m, list());

t = (0.2:0.1:12.9)';
A_ref = struct('values', sin(t), 'time', t);

assert_checkequal(fieldnames(A), fieldnames(A_ref));
assert_checkalmostequal(A.time, A_ref.time);
assert_checkalmostequal(A.values, A_ref.values);
