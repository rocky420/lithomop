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
      subroutine td_strs_mat_cmp_ss(
     & A,nnz,                                                           ! sparse
     & bintern,neq,                                                     ! force
     & x,d,numnp,iddmat,                                                ! global
     & dx,numslp,numsn,                                                 ! slip
     & tfault,numfn,                                                    ! fault
     & s,stemp,                                                         ! stiff
     & state,dstate,state0,dmat,ien,lm,lmx,lmf,nelfamily,               ! elemfamily
     & nstate,nstate0,nprestrflag,ipstrs,ipauto,n0states,ielg,          ! elemfamily
     & prop,nprop,elas_strs_mat,td_strs_mat,matchg,tminmax,             ! materl
     & gauss,sh,shj,nen,ngauss,nee,                                     ! eltype
     & rtimdat,ntimdat,rgiter,                                          ! timdat
     & skew,numrot,                                                     ! skew
     & getshape,bmatrix,                                                ! bbar
     & ierr,errstrng)                                                   ! errcode
c
c...  subroutine to compute the total stress and strain for the current
c     iteration for a given material model and update the global load
c     vector and the material and stiffness matrices.  This routine is
c     for time-dependent small strain problems.
c
      include "implicit.inc"
c
c     PETSc includes
c
#include "finclude/petsc.h"
#include "finclude/petsclog.h"
#include "finclude/petscvec.h"
#include "finclude/petscmat.h"
      Mat A
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nshape.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer nnz,neq,numnp,numslp,numsn,numfn,nelfamily,nstate,nstate0
      integer nprestrflag,ipstrs,ipauto,n0states,ielg,nprop
      integer nen,ngauss,nee,numrot,ierr
      integer iddmat(nstr,nstr)
      integer ien(nen,nelfamily),lm(nee,nelfamily),lmx(nee,nelfamily)
      integer lmf(nen,nelfamily)
      character errstrng*(*)
      logical matchg
      double precision bintern(neq),x(nsd,numnp),d(ndof,numnp)
      double precision dx(ndof,numnp),tfault(ndof,numfn)
      double precision s(neemax*neemax),stemp(neemax*neemax)
      double precision state(nstate,ngauss,nelfamily)
      double precision dstate(nstate,ngauss,nelfamily)
      double precision state0(nstate0,ngauss,n0states)
      double precision dmat(nddmat,ngauss,nelfamily),prop(nprop),tminmax
      double precision gauss(nsd+1,ngauss)
      double precision sh(nsd+1,nen,ngauss)
      double precision shj(nsd+1,nen,ngauss)
      double precision skew(nskdim,numnp)
c
c...  included dimension and type statements
c
      include "rtimdat_dim.inc"
      include "rgiter_dim.inc"
      include "ntimdat_dim.inc"
c
c...  intrinsic functions
c
c
c...  external routines
c
      external elas_strs_mat,td_strs_mat,getshape,bmatrix
c
c...  local variables
c
      integer ielf,incstate0,indstate0,l
      double precision tmax
      double precision dl(60),xl(60),scur(162),ee(162),p(60),det(27)
c
c...  included variable definitions
c
      include "rtimdat_def.inc"
      include "rgiter_def.inc"
      include "ntimdat_def.inc"
c
cdebug      write(6,*) "Hello from td_strs_mat_cmp_ss_f!"
c
      incstate0=izero
      indstate0=ione
      if(ipstrs.ne.izero) then
        incstate0=ione
        indstate0=izero
      end if
c
c...  loop over elements in a family
c
      do ielf=1,nelfamily
        indstate0=indstate0+incstate0
c
c...  localize coordinates and displacements
c
        call lcoord(x,xl,ien(1,ielf),nen,numnp)
        call ldisp(dl,d,ien(1,ielf),nen,numnp)
        if(numfn.ne.0) call adfldp(dl,lmf(1,ielf),tfault,nen,numfn)
        if(numslp.ne.0) call addsn(dl,dx,ien(1,ielf),lmx(1,ielf),nen,
     &   numnp)
c
c...  compute strains
c
        call bdeld_ss(xl,dl,sh,shj,ee,det,gauss,ielg,nen,nee,ngauss,
     &   getshape,bmatrix,ierr,errstrng)
        if(ierr.ne.izero) return
c
c...  loop over gauss points, compute stresses, and transfer them into
c     scur
c
        do l=1,ngauss
          call td_strs_mat(state(1,l,ielf),dstate(1,l,ielf),
     &     state0(1,l,indstate0),ee(nstr*(l-1)+1),scur(nstr*(l-1)+1),
     &     dmat(1,l,ielf),prop,rtimdat,rgiter,ntimdat,iddmat,tmax,
     &     nstate,nstate0,nprop,matchg,ierr,errstrng)
          if(ierr.ne.izero) return
          tminmax=min(tmax,tminmax)
        end do
c
c...  compute equivalent nodal loads and add them to global load
c
        call fill(p,zero,ndof*nen)
        call eforce(xl,sh,shj,det,gauss,scur,p,ielg,nen,ngauss,getshape,
     &   bmatrix,ierr,errstrng)
        if(ierr.ne.izero) return
        if(numrot.ne.izero) call rpforc(p,skew,ien(1,ielf),numnp,nen)
        call addfor(bintern,p,lm(1,ielf),lmx(1,ielf),neq,nee)
c
c...  compute element stiffness and add it to global stiffness
c
        call formes_ss(
     &   x,numnp,iddmat,                                                ! global
     &   s,stemp,                                                       ! stiff
     &   dmat(1,1,ielf),ien(1,ielf),lm(1,ielf),ielg,                    ! elemfamily
     &   gauss,sh,shj,nen,ngauss,nee,                                   ! eltype
     &   skew,numrot,                                                   ! skew
     &   getshape,bmatrix,                                              ! bbar
     &   ierr,errstrng)                                                 ! errcod
        if(ierr.ne.izero) return
        call addstf(A,s,stemp,lm(1,ielf),lmx(1,ielf),nee,numsn,nnz)
        ielg=ielg+ione
      end do
      return
      end
c
c version
c $Id: td_strs_mat_cmp_ss.F,v 1.5 2005/04/08 00:37:24 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
