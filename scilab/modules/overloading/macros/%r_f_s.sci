// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// 
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at    
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function f=%r_f_s(f,m)
// [f;m]   [rational;constant]
//!

f=rlist([f('num');m],[f('den');ones(m)],f('dt'))
endfunction
