// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function [t] = sinh(z)
//
//  PURPOSE
//     element wise hyperbolic sinus
//
//  METHOD
//     based on the formula  sinh(z) = -i sin(i z)
//

  rhs = argn(2);

  if rhs <> 1 then
    error(msprintf(gettext("%s: Wrong number of input argument(s): %d expected.\n"),"sinh",1));
  end

  if type(z)<>1 then
   error(msprintf(gettext("%s: Wrong type for input argument #%d: Real or complex matrix expected.\n"),"sinh",1));
  end

  if isreal(z) then 
     t = imag(sin(imult(z)))
  else
     t = -imult(sin(imult(z)))
  end
endfunction
