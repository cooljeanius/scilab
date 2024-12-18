// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Clement DAVID
// Copyright (C) 2012 - Scilab Enterprises - Clement DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH XCOS -->
//
// <-- Non-regression test for bug 7639 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7639
//
// <-- Short Description -->
// When I try to generate some code for a superblock containing a scilab
// function, it produce an error message.


global msg;
msg = [];
// overwrite message
prot = funcprot();
funcprot(0);
function num=message(strings ,buttons, modal)
    global msg;
    msg = strings;

    num = 1;
endfunction
funcprot(prot);

loadXcosLibs();

status = importXcosDiagram(SCI + "/modules/xcos/tests/nonreg_tests/bug_7639.xcos");
if ~status then pause, end

// export the Superblock to the file
blk = [];
for i=1:length(scs_m.objs) do
  blk = scs_m.objs(i);
  if typeof(blk) == "Block" & blk.gui == "SUPER_f" then
    break;
  end
end
assert_checktrue(length(blk) <> 0);

// call and check for a message error (the out blk will be empty on error)
blk = xcosCodeGeneration(blk);
assert_checktrue(length(blk) == 0);
assert_checktrue(length(msg) <> 0);
