//  Scicos
//
//  Copyright (C) INRIA - METALAU Project <scicos@inria.fr>
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
//
// See the file ../license.txt
//

function [x,y,typ]=LOGBLK_f(job,arg1,arg2)
x=[];y=[];typ=[];
select job
case 'plot' then
  standard_draw(arg1)
case 'getinputs' then
  [x,y,typ]=standard_inputs(arg1)
case 'getoutputs' then
  [x,y,typ]=standard_outputs(arg1)
case 'getorigin' then
  [x,y]=standard_origin(arg1)
case 'set' then
  x=arg1;
  graphics=arg1.graphics;exprs=graphics.exprs
  model=arg1.model;
  if size(exprs,'*')==2 then exprs=exprs(2),end //compatibility
  while %t do
    [ok,a,exprs]=scicos_getvalue('Set log block parameters',..
	'Basis (>1)',list('vec',1),exprs)
    if ~ok then break,end
    if a<=1 then
      message('Basis must be larger than 1')
    else
      if ok then
	graphics.exprs=exprs
	model.rpar=a
	x.graphics=graphics;x.model=model
	break
      end
    end
  end
case 'define' then
  in=1
  a=%e
  model=scicos_model()
  model.sim='logblk'
  model.in=-1
  model.out=-1
  model.rpar=a
  model.blocktype='c'
  model.dep_ut=[%t %f]

  exprs='%e'
  gr_i=['xstringb(orig(1),orig(2),''Log'',sz(1),sz(2),''fill'');']
  x=standard_define([2 2],model,exprs,gr_i)
end
endfunction
