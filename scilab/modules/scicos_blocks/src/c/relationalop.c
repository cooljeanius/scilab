/*  Scicos
*
*  Copyright (C) INRIA - METALAU Project <scicos@inria.fr>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
*
* See the file ./license.txt
*/
/*--------------------------------------------------------------------------*/ 
#include <math.h>
#include "scicos_block.h"
#include "dynlib_scicos_blocks.h"
/*--------------------------------------------------------------------------*/ 
SCICOS_BLOCKS_IMPEXP void relationalop(scicos_block *block,int flag)
{
	int i = block->ipar[0];
	if(flag==1)
	{
		if ((block->ng!=0)&(get_phase_simulation()==2))
		{
			block->outptr[0][0]=block->mode[0]-1.0;
		}
		else 
		{
			switch (i)
			{
			case 0:
				if(block->inptr[0][0]==block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;

			case 1:
				if(block->inptr[0][0]!=block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;
			case 2:
				if(block->inptr[0][0]<block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;    
			case 3:
				if(block->inptr[0][0]<=block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;   
			case 4:
				if(block->inptr[0][0]>=block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;   
			case 5:
				if(block->inptr[0][0]>block->inptr[1][0]) 
				{
					block->outptr[0][0]=1.0;
				}
				else
				{
					block->outptr[0][0]=0.0;
				}
				break;
			}
		}

	}
	else if(flag==9)
	{
		block->g[0]=block->inptr[0][0]-block->inptr[1][0];
		if (get_phase_simulation()==1) 
		{
			switch (i)
			{
			case 0:
				if(block->inptr[0][0]==block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;

			case 1:
				if(block->inptr[0][0]!=block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;
			case 2:
				if(block->inptr[0][0]<block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;    
			case 3:
				if(block->inptr[0][0]<=block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;   
			case 4:
				if(block->inptr[0][0]>=block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;   
			case 5:
				if(block->inptr[0][0]>block->inptr[1][0]) 
				{
					block->mode[0]=(int)2.0;
				}
				else
				{
					block->mode[0]=(int)1.0;
				}
				break;
			}
		}
	}
}
/*--------------------------------------------------------------------------*/ 
