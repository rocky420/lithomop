c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2004  All Rights Reserved
c
c  Copyright 2004 Rensselaer Polytechnic Institute.
c  All worldwide rights reserved.  A license to use, copy, modify and
c  distribute this software for non-commercial research purposes only
c  is hereby granted, provided that this copyright notice and
c  accompanying disclaimer is not modified or removed from the software.
c
c  DISCLAIMER:  The software is distributed "AS IS" without any express
c  or implied warranty, including but not limited to, any implied
c  warranties of merchantability or fitness for a particular purpose
c  or any warranty of non-infringement of any current or pending patent
c  rights.  The authors of the software make no representations about
c  the suitability of this software for any particular purpose.  The
c  entire risk as to the quality and performance of the software is with
c  the user.  Should the software prove defective, the user assumes the
c  cost of all necessary servicing, repair or correction.  In
c  particular, neither Rensselaer Polytechnic Institute, nor the authors
c  of the software are liable for any indirect, special, consequential,
c  or incidental damages related to the software, to the maximum extent
c  the law permits.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine gload_drv(
     & b,bres,gvec1,gvec2,grav,neq,                                     ! force
     & x,d,numnp,                                                       ! global
     & dx,numslp,                                                       ! slip
     & tfault,numfn,                                                    ! fault
     & ien,lm,lmx,lmf,infiel,numelt,nconsz,                             ! elemnt
     & prop,mhist,infmat,numat,npropsz,                                 ! materl
     & gauss,shj,infetype,                                              ! eltype
     & histry,rtimdat,ntimdat,nhist,lastep,gload_cmp,                   ! timdat
     & skew,numrot,                                                     ! skew
     & ierr,errstrng)                                                   ! errcode
c
c...  driver routine to add body forces due to gravity
c
      include "implicit.inc"
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
      integer neq,numnp,numslp,numfn,numelt,nconsz,numat,npropsz,nhist
      integer lastep,numrot,ierr
      integer ien(nconsz),lm(ndof,nconsz),lmx(ndof,nconsz),lmf(nconsz)
      integer infiel(6,numelt),mhist(npropsz),infmat(6,numat)
      integer infetype(4,netypes)
      character errstrng*(*)
      double precision b(neq),bres(neq),gvec1(neq),gvec2(neq),grav(ndof)
      double precision x(nsd,numnp),d(ndof,numnp),dx(ndof,numnp)
      double precision tfault(ndof,numfn),prop(npropsz)
      double precision gauss(nsd+1,ngaussmax,netypes)
      double precision shj(nsd+1,nenmax,ngaussmax,netypes)
      double precision histry(nhist,lastep+1),skew(nskdim,numnp)
c
c...  included dimension and type statements
c
      include "rtimdat_dim.inc"
      include "ntimdat_dim.inc"
c
c...  external routines
c
      external gload_cmp
c
c...  local variables
c
      integer i,imat,matgpt,nmatel,nprop,indprop
      logical matchg
      double precision gsum,dens,dif
      double precision ptmp(100)
c
c...  included variable definitions
c
      include "rtimdat_def.inc"
      include "ntimdat_def.inc"
c
cdebug      write(6,*) "Hello from gload_drv_f!"
c
      gsum=zero
      do i=1,ndof
        gsum=gsum+grav(i)*grav(i)
      end do
      if(gsum.eq.zero) return
      call fill(gvec2,zero,neq)
      matgpt=1
c
c...  loop over material groups
c
      do imat=1,numat
        nmatel=infmat(2,imat)
        nprop=infmat(5,imat)
        indprop=infmat(6,imat)
        matchg=.false.
        call mathist(ptmp,prop(indprop),mhist(indprop),histry,nprop,
     &   imat,nstep,nhist,lastep,matchg,ierr,errstrng)
c
        if(ierr.ne.izero) return
c
        dens=ptmp(1)
c
        call gload_cmp(
     &   gvec2,grav,neq,                                                ! force
     &   x,d,numnp,                                                     ! global
     &   dx,numslp,                                                     ! slip
     &   tfault,numfn,                                                  ! fault
     &   ien,lm,lmx,lmf,infiel,numelt,nconsz,                           ! elemnt
     &   dens,infmat(1,imat),matgpt,nmatel,matchg,                      ! materl
     &   gauss,shj,infetype,                                            ! eltype
     &   rtimdat,ntimdat,                                               ! timdat
     &   skew,numrot,                                                   ! skew
     &   ierr,errstrng)                                                 ! errcode
c
        matgpt=matgpt+nmatel
c
      end do
c
c...find difference between computed total body force for new nodal
c   positions (gvec2) and current body force (gvec1) and update
c   body force vector and global load vector by this amount.
c
      do i=1,neq
        dif=gvec2(i)-gvec1(i)
        gvec1(i)=gvec2(i)
        b(i)=b(i)+dif
        bres(i)=bres(i)+dif
      end do
c
      return
      end
c
c version
c $Id: gload_drv.f,v 1.1 2004/07/01 20:17:23 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 