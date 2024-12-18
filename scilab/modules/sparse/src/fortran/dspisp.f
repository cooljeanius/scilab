c Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
c Copyright (C) INRIA
c 
c This file must be used under the terms of the CeCILL.
c This source file is licensed as described in the file COPYING, which
c you should have received as part of this distribution.  The terms
c are also available at    
c http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
      subroutine dspisp(ma,na,a,nela,inda,i,ni,j,nj,
     $     mb,nb,b,nelb,indb,mr,nr,r,nelr,indr,ptrb,ierr)
c     extract a submatrix from a sparse matrix
c!
      integer inda(*),indr(*),i(*),j(*),ptrb(*)
      integer indb(*),mb,nb,nelb
      integer ma,na,ni,nj,mr,nr,nela,nelr,ierr
      double precision a(*),r(*),b(*)
      logical allrow,allcol
      integer findl
      external findl
c
      mr=ni
      nr=nj
      ierr=0
      nelmx=nelr
      allrow=ni.lt.0
      allcol=nj.lt.0
      if(allrow) then 
         mr=ma
         ni=mr
      else
         mi=0
         do 01 kk=1,ni
            mi=max(mi,i(kk))
 01      continue
         mr=max(ma,mi)
      endif
      if(allcol) then 
         nr=na
         nj=na
      else
         mj=0
         do 02 kk=1,nj
            mj=max(mj,j(kk))
 02      continue
         nr=max(na,mj)
      endif
      if (allrow.and.allcol) then
c     a(:,:)=b
         call icopy(mb+nelb,indb,1,indr,1)
         call unsfdcopy(nelb,b,1,r,1)
         nelr=nelb
         return
      elseif(allcol) then
c     a(i,:)=b
         jr=1
         jb=1
         ja=1
         call sz2ptr(indb,mb,ptrb)
         do 20 l=1,mr
            indr(l)=0
            ii=findl(l,i,ni)
            if(ii.eq.0) then
c     this line is not modified
               if(l.le.ma) then
                  indr(l)=inda(l)
                  call icopy(indr(l),inda(ma+ja),1,indr(mr+jr),1)
                  if(jr+indr(l).gt.nelmx) then
                     ierr=1
                     return
                  endif
                  call unsfdcopy(indr(l),a(ja),1,r(jr),1)
                  jr=jr+indr(l)
                  ja=ja+indr(l)
               else
                  indr(l)=0
               endif
            else
c     all this line is replaced by corresponding b line
               jb=ptrb(ii)
               indr(l)=indb(ii)
               if(jr+indr(l).gt.nelmx) then
                  ierr=1
                  return
               endif
               call icopy(indr(l),indb(mb+jb),1,indr(mr+jr),1)
               call unsfdcopy(indr(l),b(jb),1,r(jr),1)
               jr=jr+indr(l)
               if(l.le.ma) then
                  ja=ja+inda(l)
               endif
            endif
 20      continue
         nelr=jr-1
      elseif(allrow) then
c     a(:,j)=b
         jr=1
         ja=0
         jb=0
         do 35 l=1,ma
            ja1=1
            nbl=indb(l)
            nal=inda(l)
            indr(l)=0
            do 31 k=1,nr
               jj=findl(k,j,nj)
               if(jj.eq.0) then
c     the  a(l,k) element is not modified insert it in r if non zero
                  if(ja1.le.nal.and.inda(ma+ja+ja1).eq.k) then
c     *              a(l,k) element is non zero
                     if(jr+1.gt.nelmx) then
                        ierr=1
                        return
                     endif
                     r(jr)=a(ja+ja1)
                     indr(l)=indr(l)+1
                     indr(mr+jr)=k
                     jr=jr+1
                     ja1=ja1+1
                  endif
               else
c     the  a(l,k) element is replaced by b(l,jj) element if non zero
                  jb1=findl(jj,indb(mb+jb+1),nbl)
                  if(jb1.ne.0) then
c     *           b(l,jj) element if non zero
                     if(jr+1.gt.nelmx) then
                        ierr=1
                        return
                     endif
                     r(jr)=b(jb+jb1)
                     indr(l)=indr(l)+1
                     indr(mr+jr)=k
                     jr=jr+1
                  endif
                  if(ja1.le.nal.and.inda(ma+ja+ja1).eq.k) ja1=ja1+1
               endif
 31         continue
            ja=ja+nal
            jb=jb+nbl
 35     continue
        nelr=jr-1
        return
      else
c     a(i,j)=b
         jr=1
         ja=0
         call sz2ptr(indb,mb,ptrb)
         do 45 l=1,mr
            ja1=1
            if(l.le.ma) then 
               nal=inda(l)
            else
               nal=0
            endif
            indr(l)=0
            ii=findl(l,i,ni)
            if(ii.eq.0) then
c     *     the a(l,:) is not modified
               if(l.le.ma) then
                  indr(l)=inda(l)
                  call icopy(indr(l),inda(ma+ja+ja1),1,indr(mr+jr),1)
                  call unsfdcopy(indr(l),a(ja+ja1),1,r(jr),1)
                  jr=jr+indr(l)
                  ja1=ja1+indr(l)
               else
                  indr(l)=0
               endif
            else
               jb=ptrb(ii)-1
               jb1=1
               nbl=indb(ii)
               do 42 k=1,nr
                  jj=findl(k,j,nj)
                  if(jj.eq.0) then
c     *           insert a(l,k) element insert  in r if non zero
                     if(ja1.le.nal.and.inda(ma+ja+ja1).eq.k) then
c     *              a(l,k) element is non zero
                        if(jr+1.gt.nelmx) then
                           ierr=1
                           return
                        endif
                        r(jr)=a(ja+ja1)
                        indr(l)=indr(l)+1
                        indr(mr+jr)=k
                        jr=jr+1
                        ja1=ja1+1
                     endif
                  else
c     *           replace a(l,k) element  by b(ii,jj) element if non zero
                     jb1=findl(jj,indb(mb+jb+1),nbl)
                     if(jb1.ne.0) then
c     *               b(l,jj) element if non zero
                        if(jr+1.gt.nelmx) then
                           ierr=1
                           return
                        endif
                        r(jr)=b(jb+jb1)
                        indr(l)=indr(l)+1
                        indr(mr+jr)=k
                        jr=jr+1
                     endif
                     if(ja1.le.nal.and.inda(ma+ja+ja1).eq.k) ja1=ja1+1
                  endif
 42            continue
            endif
            ja=ja+nal
 45      continue
         nelr=jr-1
      endif
      end

