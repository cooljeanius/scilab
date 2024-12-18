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

function [x,y,typ]=RATELIMITER(job,arg1,arg2)
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
  while %t do
    [ok,maxp,minp,exprs]=scicos_getvalue('Set rate limiter parameters',..
	['max slope';'min slope';],list('vec',1,'vec',1),exprs)
    if ~ok then break,end
    if maxp<=minp|maxp<=0|minp>=0  then
      message('We must have max_slope> 0 > min_slope.')
    else
      rpar=[maxp;minp]
      model.rpar=rpar
      graphics.exprs=exprs
      x.graphics=graphics;x.model=model
      break
    end
  end
case 'define' then
  minp=-1;maxp=1;rpar=[maxp;minp]
  model=scicos_model()
  model.sim=list('ratelimiter',4)
  model.in=1
  model.out=1
  model.rpar=rpar
  model.blocktype='c'
  model.dep_ut=[%t %f]
  
  exprs=[string(maxp);string(minp)]
  gr_i='xstringb(orig(1),orig(2),''Rate limiter'',sz(1),sz(2),''fill'')'
  x=standard_define([3 2],model,exprs,gr_i)
end
endfunction
