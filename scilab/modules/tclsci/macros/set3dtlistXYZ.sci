// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution. The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2.1-en.txt

//Plot3d
function set3dtlistXYZ (X,Y,Z)
    global ged_handle; h=ged_handle
    ged_tmp_tlist = tlist(["3d","x","y","z"],X,Y,Z)
    h.data=ged_tmp_tlist;
    clear ged_tmp_tlist;
endfunction