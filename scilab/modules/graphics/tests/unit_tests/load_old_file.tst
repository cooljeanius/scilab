// =============================================================================
// scilab ( http://www.scilab.org/ ) - this file is part of scilab
// copyright (c) 2008 - inria - jean-baptiste silvy <jean-baptiste.silvy@inria.fr>
//
//  this file is distributed under the same license as the scilab package.
// =============================================================================

// <-- test with graphic -->

// non regression bug for load which weren't able to open
// files saved from old scilab version
// here we have a file saved by scilab 4.1.2, name load_old_file.scg

// load the file
// this file was obtained with the command save("load_old_file.scg",gcf())
// from Scilab 4.1.2. The figure was obtained by renning the example
// of the axes_properties help from from the first line to the next to the last one
// (ie everything without the final sda())
load(SCI + "/modules/graphics/tests/unit_tests/load_old_file.scg");

// check some data
fig = gcf();

// check figure
if fig.figure_id <> 0 then pause; end
if fig.background <> 8 then pause; end
if fig.pixel_drawing_mode <> "copy" then pause; end
if size(fig.children, '*') <> 1 then pause; end

// check axes
axes = f.children;
if axes.type <> "Axes" then pause; end
if size(axes.children, '*') <> 5 then pause; end
if axes.axes_visible <> ["on", "on", "on"] then pause; end
if axes.x_location <> "bottom" then pause; end
if axes.grid <> [-1, -1] then pause; end
if axes.font_style <> 6 then pause; end
if axes.data_bounds <> [-10, 2; 10, 2] then pause; end
if axes.margins <> [0.125, 0.125, 0.125, 0.125] then pause; end
if axes.axes_bounds <> [0,0,1,1] then pause; end
if axes.hiddencolor <> 4 then pause; end
if axes.user_data <> [] then pause; end;
if axes.clip_state <> "clipgrf" then pause; end
if axes.view <> "2d" then pause; end

// check first compound
comp1 = axes.children(1);
if comp1.type <> "Compound" then pause; end
if size(comp1.children, '*') <> 3 then pause; end
if comp1.visible <> "on" then pause; end

// check compund children
if comp1.children(1).type <> "Polyline" then pause; end
if comp1.children(1).foreground <> 3 then pause; end
if comp1.children(2).type <> "Polyline" then pause; end
if comp1.children(2).foreground <> 2 then pause; end
if comp1.children(3).type <> "Polyline" then pause; end
if comp1.children(3).foreground <> 1 then pause; end

// check segs
segs = axes.children(2);
if segs.type <> "Segs" then pause; end
if segs.segs_color <> [5,5,5,5,5,5,5,5] then pause; end
if segs.arrow_size <> 1 then pause; end
if segs.line_style <> 1 then pause; end
if size(segs.data) <> [16, 2] then pause; end

// check first rectangle
rect1 = axes.children(3);
if rect1.type <> "Rectangle" then pause; end
if rect1.mark_size <> 0 then pause; end
if rect1.data <> [-2, 0.25, 4, 0.5]; then pause; end
if rect1.background <> -2; then pause; end
if rect1.fill_mode <> "on" then pause; end
if rect1.line_mode <> "on" then pause; end
if rect1.clip_state <> "clipgrf" then pause; end
if rect1.user_data <> [] then pause; end

// check second rectangle
rect2 = axes.children(4);
if rect2.type <> "Rectangle" then pause; end
if rect2.mark_size <> 0 then pause; end
if rect2.data <> [-4, 0.5, 8, 1]; then pause; end
if rect2.background <> -2; then pause; end
if rect2.fill_mode <> "off" then pause; end
if rect2.line_mode <> "on" then pause; end
if rect2.clip_state <> "clipgrf" then pause; end
if rect2.user_data <> [] then pause; end


// check second compound
comp2 = axes.children(5);
if comp2.type <> "Compound" then pause; end
if size(comp2.children, '*') <> 1 then pause; end
if comp2.visible <> "on" then pause; end
if comp2.user_data <> [] then pause; end

// check polyline
if comp2.children(1).type <> "Polyline" then pause; end
if comp2.children(1).foreground <> 1 then pause; end
if size(comp2.children(1).data) <> [79, 2] then pause; end
if comp2.children(1).interp_color_mode <> "off" then pause; end
if comp2.children(1).fill_mode <> "off" then pause; end

