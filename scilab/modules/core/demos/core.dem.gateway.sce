// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Allan CORNET
//
// This file is released under the 3-clause BSD license. See COPYING-BSD.

function subdemolist = demo_gateway()

  demopath = get_absolute_file_path("core.dem.gateway.sce");
  add_demo(_("Introduction"), demopath + "core.dem.gateway.sce");

  subdemolist = [_("Getting started with Scilab")  ,"intro/intro.dem.sce"]

  subdemolist(:,2) = demopath + subdemolist(:,2);

endfunction  

subdemolist = demo_gateway();
clear demo_gateway;
