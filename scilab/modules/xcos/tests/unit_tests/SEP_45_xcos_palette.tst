// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) DIGITEO - 2010-2010 - Clément DAVID <clement.david@scilab.org>
//
// This file is distributed under the same license as the Scilab package.

// <-- NOT FIXED -->

// <-- TEST WITH XCOS -->
//
// <-- Short Description -->
// Check the API of all xcos palette management methods, see SEP_45_xcos_palette.odt

loadXcosLibs;

exportedFile = TMPDIR + "/palette.sod";
palettePath = ["My special palettes" "My sum palettes" "My sum palette"];

// Typical palette adding
pal = xcosPal(palettePath($));
pal = xcosPalAddBlock(pal, SUM_f("define"));
pal = xcosPalAddBlock(pal, BIGSOM_f("define"));

xcosPalExport(pal, exportedFile);
xcosPalAdd(exportedFile, palettePath);

// Remove the palette and the palette path
for i=size(palettePath, '*'):-1:1
	xcosPalDelete(palettePath(1:i));
end


// Import a Scicos palette
exec(SCI + "/modules/scicos/palettes/Branching.cosf", -1);
pal = xcosPal(scs_m);

xcosPalExport(pal, exportedFile);
xcosPalAdd(exportedFile);


// unit test for a custom simple block
pal = xcosPal("My custom palette");
MYSUM = BIGSOM_f;
myIcon = SCI + "/modules/xcos/images/palettes/VVsourceAC.png";

style= struct();
style.labelPosition = "middle";
style.verticalLabelPosition = "bottom";
style.image = "file:" + SCI + "/modules/xcos/images/blocks/SUM.svg";
style.noLabel = "0";
style.displayedLabel = "My custom block";

pal = xcosPalAddBlock(pal, MYSUM("define"), myIcon, style);
xcosPalAdd(pal);

// move the pal to another place
palettePath = ["Customs" "first try"];
xcosPalMove("My custom palette", palettePath);
palettePath = [palettePath "My custom palette"];

// Enable and disable the palette
xcosPalEnable(palettePath);
xcosPalDisable(palettePath);

// Remove the palette and the palette path
for i=size(palettePath, '*'):-1:1
	xcosPalDelete(palettePath(1:i));
end


