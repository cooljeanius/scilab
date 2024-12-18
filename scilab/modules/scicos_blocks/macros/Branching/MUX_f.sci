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

function [x,y,typ]=MUX_f(job,arg1,arg2)
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
    [ok,in,exprs]=scicos_getvalue('Set MUX block parameters',..
	'number of input ports or vector of sizes',list('vec',-1),exprs)
    if ~ok then break,end
    if size(in,'*')==1 then
      if in<2|in>8 then
	message('Block must have at least two input ports and at most eight')
	ok=%f
      else
	[model,graphics,ok]=check_io(model,graphics,-[1:in]',0,[],[])
      end
    else
      if size(in,'*')<2| size(in,'*')>8|or(in==0) then
	message(['Block must have at least two input ports';
		 'and at most eight, and size 0 is not allowed. '])
	ok=%f
      else
	if min(in)<0 then nout=0,else nout=sum(in),end
	[model,graphics,ok]=check_io(model,graphics,in(:),nout,[],[])
	if ok then in=size(in,'*'),end
      end
    end
    if ok then
      graphics.exprs=exprs;model.ipar=in
      x.graphics=graphics;x.model=model
      break
    end
  end
 case 'define' then
  in=2
  model=scicos_model()
  model.sim=list('mux',1)
  model.in=-[1:in]'
  model.out=0
  model.ipar=in
  model.blocktype='c'
  model.dep_ut=[%t %f]

  exprs=string(in)
  gr_i='xstringb(orig(1),orig(2),''Mux'',sz(1),sz(2),''fill'')'
  x=standard_define([2 2],model,exprs,gr_i)
end
endfunction
