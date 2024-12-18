// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
function r=%c_b_c(varargin)
if  size(varargin)==2 then
  if type(varargin(1))==10 & type(varargin(2))==10 then
    r=asciimat(asciimat(varargin(1)):asciimat(varargin(2)))
  end
elseif size(varargin)==3 then
  if type(varargin(1))==10 & type(varargin(2))==10 & type(varargin(3))==10 then
    r=asciimat(asciimat(varargin(1)):asciimat(varargin(2)):asciimat(varargin(3)))
  end
else
  error(43)
end
endfunction
