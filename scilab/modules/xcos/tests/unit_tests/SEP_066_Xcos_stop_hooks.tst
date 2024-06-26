// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) DIGITEO - 2010-2010 - Clément DAVID <clement.david@scilab.org>
//
// This file is distributed under the same license as the Scilab package.

// <-- TEST WITH XCOS -->
//
// <-- Short Description -->
// Check the API of the Xcos hooks, see SEP_066_Xcos_hooks.odt

loadXcosLibs();
global status;
status = [];

function continueSimulation = pre_xcos_simulate(scs_m, needcompile)
        global status;

        status = [status 'pre_called'];
        continueSimulation = %f;
endfunction

function post_xcos_simulate(%cpr, scs_m, needcompile)
        global status;

        // check that the simulation has been run
        f=gcf();
        a=gca();
        p=a.children(1);
        assert_checkalmostequal(p.data($,1), 29.9, 0.1, 0.1);

        status = [status 'post_called'];
endfunction

assert_checktrue(importXcosDiagram(SCI + "/modules/xcos/demos/Simple_Demo.xcos"));
xcos_simulate(scs_m, 4);

assert_checkequal(status, ["pre_called"]);

