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

assert_checktrue(importXcosDiagram(SCI + "/modules/xcos/tests/unit_tests/canimxy.xcos"));
xcos_simulate(scs_m, 4);

function assert_checkcanimxy()
    f=gcf();
    assert_checkequal(size(f.children), [1 1])

    a=f.children(1);
    assert_checkequal(size(a.children), [2 1])

    p1=a.children(1);

    assert_checkequal(f.figure_id, 20005);
    assert_checkequal(a.data_bounds, [-10 -10 ; 10 10]);

    assert_checkequal(a.x_label.text, "x");
    assert_checkequal(a.y_label.text, "y");

    // all polylines has the same configuration, we just need to check the first one.
    assert_checkequal(p1.polyline_style, 1);
    assert_checkequal(p1.line_mode, "off");

    assert_checkequal(p1.mark_mode, "on");
    assert_checkequal(p1.mark_style, 4);
    assert_checkequal(p1.mark_size, 1);
endfunction
assert_checkcanimxy()

// Simulate again to check multi-simulations cases
xcos_simulate(scs_m, 4);
assert_checkcanimxy();

