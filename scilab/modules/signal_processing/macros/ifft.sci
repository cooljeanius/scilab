// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA - 1988 - C. Bunks
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
function x=ifft(a,varargin)
  if type(a)==1|(typeof(a)=='hypermat'&type(a.entries)==1) then 
    x=fft(a,1,varargin(:))
  else
    error(msprintf(_("%s: Wrong type for input argument #%d: Array of double expected.\n"),"ifft", 1));
  end
endfunction
