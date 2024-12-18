// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA - Vincent Couvert
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function M=%hm_k_s(M1,M2)
hmsize = double(M1.dims);
ssize = size(M2);
ssize = [ssize ones(1,length(hmsize)-length(ssize))];
hmsize = [hmsize ones(1,length(ssize)-length(hmsize))];
subs=list()
for k=length(ssize):-1:1
  ind = (1:ssize(k))';
  subs(k) = ind(:,ones(1,hmsize(k)));
end
M = M2(subs(:));
endfunction

