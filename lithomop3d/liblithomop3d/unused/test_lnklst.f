      program test_lnklst
c
c...  simple driver to test lnklst routine given the output from
c     the beginning of lnklst.
c
      implicit none
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nshape.inc"
      include "nconsts.inc"
      integer neq,nconsz,numelt,iwork
      parameter(neq=4521,nconsz=13824,numelt=1728,iwork=452100)
c
c...  subroutine arguments
c
      integer nsizea,nnz,numsn,ierr
      integer lm(ndof*nconsz),lmx(ndof*nconsz),infiel(6,numelt)
      integer infetype(4,netypes),indx(neq),link(iwork),nbrs(iwork)
      character errstrng*80
c
      integer idb,jdb
c
      open(15,file="lnklst.info")
      read(15,*) (lm(idb),idb=1,ndof*nconsz)
      read(15,*) (lmx(idb),idb=1,ndof*nconsz)
      do idb=1,numelt
        read(15,*) (infiel(jdb,idb),jdb=1,6)
      end do
      do idb=1,netypes
        read(15,*) (infetype(jdb,idb),jdb=1,4)
      end do
      close(15)
      call lnklst(neq,lm,lmx,infiel,nconsz,numelt,infetype,indx,
     & link,nbrs,iwork,nsizea,nnz,numsn,ierr,errstrng)
      write(6,*) nsizea,nnz
      stop
      end
c
c
c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c  Lithomop3d by Charles A. Williams
c  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
c
c  Permission is hereby granted, free of charge, to any person obtaining
c  a copy of this software and associated documentation files (the
c  "Software"), to deal in the Software without restriction, including
c  without limitation the rights to use, copy, modify, merge, publish,
c  distribute, sublicense, and/or sell copies of the Software, and to
c  permit persons to whom the Software is furnished to do so, subject to
c  the following conditions:
c
c  The above copyright notice and this permission notice shall be
c  included in all copies or substantial portions of the Software.
c
c  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
c  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
c  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
c  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
c  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
c  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
c  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine lnklst(neq,lm,lmx,infiel,nconsz,numelt,infetype,indx,
     & link,nbrs,iwork,nsizea,nnz,numsn,ierr,errstrng)
c
c      program to create a linked list of nonzero row and column entries
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nshape.inc"
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer neq,nconsz,numelt,iwork,nsizea,nnz,numsn,ierr
      integer lm(ndof*nconsz),lmx(ndof*nconsz),infiel(6,numelt)
      integer infetype(4,netypes),indx(neq),link(iwork),nbrs(iwork)
      character errstrng*(*)
c
c...  intrinsic functions
c
      intrinsic abs
c
c...  local variables
c
      integer inext,iel,indlm,ietype,nee,neeq,i,ii,irow,loc,j,jj,icol
      integer loctmp,ival,locsav
      integer idb,idbind
c
      write(6,*) "Hello from lnklst_f!"
c
      write(6,*) "neq,nconsz,numelt,iwork,nsizea,nnz,numsn:",neq,nconsz,
     & numelt,iwork,nsizea,nnz,numsn
      call ifill(indx,izero,neq)
      call ifill(link,izero,iwork)
      call ifill(nbrs,izero,iwork)
cdebug      do idb=1,netypes
cdebug        write(6,*) "infetype:",(infetype(jdb,idb),jdb=1,4)
cdebug      end do
cdebug      write(6,*) "lm:",(lm(idb),idb=1,ndof*nconsz)
cdebug      write(6,*) "lmx:",(lm(idb),idb=1,ndof*nconsz)
c
      inext=ione
      do iel=1,numelt
c
c      check that available storage is not exceeded
c*     Temporary output to stdout that should be replaced by an
c*     exception.
c
        if(inext.gt.iwork) then
          ierr=300
          write(errstrng,700) inext-iwork
          write(6,*) "Uncaught exception?"
          return
        end if
        indlm=ndof*(infiel(1,iel)-ione)+ione
        ietype=infiel(3,iel)
        nee=infetype(4,ietype)
        neeq=nee
        if(numsn.ne.izero) neeq=itwo*nee
cdebug        write(6,*) "iel,indlm,ietype,nee,neeq:",
cdebug     &   iel,indlm,ietype,nee,neeq
c
        do i=1,neeq
          ii=indlm+i-1
          if(i.le.nee) irow=lm(ii)
          if(i.gt.nee) irow=abs(lmx(ii-nee))
          if(irow.ne.izero) then
            loc=indx(irow)
            do j=1,neeq
              jj=indlm+j-1
              if(j.le.nee) icol=lm(jj)
              if(j.gt.nee) icol=abs(lmx(jj-nee))
              if(icol.ne.izero.and.icol.ne.irow) then
cdebug                write(6,*) "iel,i,j,ii,jj,irow,icol,loc,inext:",
cdebug     &           iel,i,j,ii,jj,irow,icol,loc,inext
                if(loc.eq.izero) then
                  loc=inext
                  indx(irow)=inext
                  nbrs(inext)=icol
                  link(inext)=-irow
                  inext=inext+1
                else
                  loctmp=loc
 40               continue
                    ival=nbrs(loctmp)
                    if(icol.eq.ival) goto 30
                    locsav=loctmp
                    loctmp=link(loctmp)
                  if(loctmp.gt.izero) goto 40
                  link(locsav)=inext
                  nbrs(inext)=icol
                  link(inext)=-irow
                  inext=inext+1
                end if
              end if
 30           continue
            end do
          end if
        end do
      end do
      write(6,*) "After loop in lnklst!"
      call flush(6)
      nsizea=inext-ione
      nnz=nsizea+neq+ione
      write(6,*) "nsizea,nnz,neq:",nsizea,nnz,neq
      call flush(6)
      idbind=max(inext-100,1)
      write(6,*) "end of nbrs:",(nbrs(idb),idb=idbind,inext)
      write(6,*) "end of link:",(link(idb),idb=idbind,inext)
      idbind=max(neq-100,1)
      write(6,*) "end of indx:",(indx(idb),idb=idbind,neq)
      call flush(6)
cdebug      open(15,file="makemsr.info")
cdebug      write(15,*) neq,nnz,iwork
cdebug      write(15,*) (indx(idb),idb=1,neq)
cdebug      write(15,*) (link(idb),idb=1,iwork)
cdebug      write(15,*) (nbrs(idb),idb=1,iwork)
cdebug      close(15)
 700  format("lnklst:  Working storage exceeded by ",i7)
      return
      end
c
c version
c $Id: test_lnklst.f,v 1.1 2004/08/12 14:41:19 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c  Lithomop3d by Charles A. Williams
c  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
c
c  Permission is hereby granted, free of charge, to any person obtaining
c  a copy of this software and associated documentation files (the
c  "Software"), to deal in the Software without restriction, including
c  without limitation the rights to use, copy, modify, merge, publish,
c  distribute, sublicense, and/or sell copies of the Software, and to
c  permit persons to whom the Software is furnished to do so, subject to
c  the following conditions:
c
c  The above copyright notice and this permission notice shall be
c  included in all copies or substantial portions of the Software.
c
c  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
c  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
c  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
c  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
c  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
c  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
c  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine ifill(ia,ival,m)
c
c.... program to fill an interger array with the given value
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer m
      integer ia(m),ival
c
c...  local variables
c
      integer i
c
      do i=1,m
        ia(i)=ival
      end do
      return
      end
c
c version
c $Id: test_lnklst.f,v 1.1 2004/08/12 14:41:19 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
