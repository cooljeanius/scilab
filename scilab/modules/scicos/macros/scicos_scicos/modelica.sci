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

function mo=modelica(v1,v2,v3,v4)

  if exists('model','local')==0 then model=[], end
  if exists('inputs','local')==0 then inputs=[], end
  if exists('outputs','local')==0 then outputs=[], end
  if exists('parameters','local')==0 then parameters=list([],list()), end

  mo=tlist(['modelica','model','inputs','outputs','parameters'],...
            model,inputs,outputs,parameters)
endfunction
