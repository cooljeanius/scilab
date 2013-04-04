c Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
c Copyright (C) INRIA
c 
c This file must be used under the terms of the CeCILL.
c This source file is licensed as described in the file COPYING, which
c you should have received as part of this distribution.  The terms
c are also available at    
c http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

      subroutine intricc(fname)
c     equations de  riccati

      include 'stack.h'
      character*(*) fname
      integer iadr,sadr
c
      double precision eps,rcond
      integer cont,disc
      data disc/13/,cont/12/
c
      iadr(l)=l+l-1
      sadr(l)=(l/2)+1
c
      eps=stk(leps)
      lz=lstk(top+1)
c
      if(rhs.ne.4) then
         call error(39)
         return
      endif
      ilcd=iadr(lstk(top))
      if(istk(ilcd).ne.10) then
         err=rhs
         call error(55)
         return
      endif
      icd=abs(istk(ilcd+5+istk(ilcd+1)*istk(ilcd+2)))
      if(icd.ne.cont .and. icd.ne.disc) then
         err=rhs
         call error(36)
         return
      endif
c
c     second membre
      top=top-1
      ic=iadr(lstk(top))
      if(istk(ic).ne.1) then
         err=rhs-1
         call error(53)
         return
      endif
      if(istk(ic+3).ne.0) then
         err=rhs-1
         call error(52)
         return
      endif
      mc=istk(ic+1)
      nc=istk(ic+2)
      nnc=nc*mc
      lc=sadr(ic+4)
      top=top-1
c
      err=0
c
c    riccati
c
  30  continue
c
c    a'*x+x*a-x*b*x+c=0
c
c         matrice b
      ib=iadr(lstk(top))
      if(istk(ib).ne.1) then
         err=2
         call error(53)
         return
      endif
      if(istk(ib+3).ne.0) then
         err=2
         call error(52)
         return
      endif
      mb=istk(ib+1)
      nb=istk(ib+2)
      if(mb.ne.nb) then
         err=2
         call error(20)
         return
      endif
      nnb=mb*nb
      lb=sadr(ib+4)
c
      top=top-1
      ia=iadr(lstk(top))
      if(istk(ia).ne.1) then
         err=1
         call error(53)
         return
      endif
      if(istk(ia+3).ne.0) then
         err=1
         call error(52)
         return
      endif
      ma=istk(ia+1)
      na=istk(ia+2)
      if(ma.ne.na) then
         err=1
         call error(20)
         return
      endif
      nna=na*ma
      nn=na+na
      la =sadr(ia+4)
c
      if(ma.ne.mb) then
         call error(42)
         return
      endif
c
      lw=lz
      lz=lw+nn*nn
      lw1=lz+nn*nn
      lw2=lw1+nn
      lw3=lw2+nn
      err=lw3+nn-lstk(bot)
      if(err.gt.0) then
         call error(17)
         return
      endif
c
      if(icd.eq.disc) goto 31
      call rilac(na,nn,stk(la),na,stk(lc),stk(lb),rcond,stk(la),
     x           stk(lw),nn,stk(lz),eps,stk(lw3),
     x           stk(lw1),stk(lw2),err)
      if(err.ne.0) then
         call error(24)
         return
      endif
      return
  31  continue
      call ricd(na,nn,stk(la),na,stk(lc),stk(lb),rcond,stk(la),
     x          stk(lw),nn,stk(lz),eps,stk(lw3),
     x          stk(lw1),stk(lw2),err)
      if(err.ne.0) then
         call error(24)
         return
      endif
      return
      end
