// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
function M=%s_4_hm(s,M)

//s>=M
if size(s,'*')<> 1 then
  error('>= : arguments have incompatible dimensions')
end
M('entries')=s>=M('entries')
endfunction
