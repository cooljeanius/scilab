// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
function r=%hm_n_hm(a,b)
r=and(a.dims==b.dims)
if r then
  r=hypermat(a.dims,a.entries<>b.entries)
else
  r=%t
end
endfunction
