// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2002-2004 - INRIA - Vincent COUVERT
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function r=is_a_vector(A)
// M2SCI function
// Checks if all dimensions of A but one are 1
// Input: A = a M2SCI tlist
// Output: r = boolean value (true if A is a vector)

nbones=0
n=size(A.dims)
r=%F
for k=1:n
  if A.dims(k)==1 then
    nbones=nbones+1
  elseif A.dims(k)==-1 then
    return
  end
end
r=nbones==n-1
endfunction
