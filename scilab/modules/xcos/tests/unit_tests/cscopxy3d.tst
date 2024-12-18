// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
// <-- TEST WITH GRAPHIC -->

// test scope values 

loadXcosLibs();

assert_checktrue(importXcosDiagram(SCI + "/modules/xcos/tests/unit_tests/cscopxy3d.xcos"));
xcos_simulate(scs_m, 4);

function assert_checkcscopxy3d()
    f=gcf();
    assert_checkequal(size(f.children), [1 1])

    a=f.children(1);
    assert_checkequal(size(a.children), [1 1])

    p1=a.children(1);

    assert_checkequal(f.figure_id, 20003);
    assert_checkequal(a.data_bounds, [-1 -0.5 0; 1 2.5 10]);

    assert_checkequal(a.x_label.text, "x");
    assert_checkequal(a.y_label.text, "y");
    assert_checkequal(a.z_label.text, "z");


    assert_checkequal(p1.closed, "off");
    assert_checkequal(p1.line_mode, "on");
    assert_checkequal(p1.fill_mode, "off");
    assert_checkequal(p1.line_style, 1);
    assert_checkequal(p1.thickness, 1);
    assert_checkequal(p1.arrow_size_factor, 1);
    assert_checkequal(p1.polyline_style, 1);
    assert_checkequal(p1.foreground, 2);
    // not documented eg invalid value
    // assert_checkequal(p1.background, -2);
    assert_checkequal(p1.interp_color_vector, []);
    assert_checkequal(p1.interp_color_mode, "off");
    assert_checkequal(p1.mark_mode, "off");
    assert_checkequal(p1.mark_style, 0);
    // "point" is the default on the new graphic
    // assert_checkequal(p1.mark_size_unit, "tabulated");
    // the defualt mark size is 0 
    // assert_checkequal(p1.mark_size, 1);
    // not documented eg invalid value
    // assert_checkequal(p1.mark_foreground, -1);
    // assert_checkequal(p1.mark_background, -2);
    assert_checkequal(p1.x_shift, []);
    assert_checkequal(p1.y_shift, []);
    assert_checkequal(p1.z_shift, []);
    assert_checkequal(p1.bar_width, 0);
    // disabled on the new graphic
    // assert_checkequal(p1.clip_state, "clipgrf");
    assert_checkequal(p1.clip_box, []);
endfunction
assert_checkcscopxy3d()

// Simulate again to check multi-simulations cases
xcos_simulate(scs_m, 4);
assert_checkcscopxy3d();

