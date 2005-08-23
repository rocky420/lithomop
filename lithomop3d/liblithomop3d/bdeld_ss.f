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
      subroutine bdeldss(xl,dl,sh,shj,ee,det,gauss,n,
     & nen,nee,nsd,ndof,nstr,ngauss,ierr,getshape,bmatrix)
c
c...  Subroutine to compute strain increments in each element.
c     Strain is evaluated at the number of gauss points specified by
c     ngauss (the locations and weights are contained in gauss).
c
c     This is a generic routine for any element type, and is meant to
c     be used only for small strain problems.
c
c     Two subroutine names are passed in as arguments.  The
c     corresponding routine is called depending on whether B-bar is
c     being used.
c
      include "implicit.inc"
      include "nshape.inc"
c
c...  subroutine arguments
c
      integer n,nen,nee,nsd,ndof,nstr,ngauss,ierr
      double precision xl(nsd,nen),dl(ndof*nen)
      double precision sh(nsd+1,nenmax,ngaussmax)
      double precision shj(nsd+1,nenmax,ngaussmax),ee(nstr,ngauss)
      double precision det(ngauss),gauss(nsd+1,ngaussmax)
c
c...  defined constants
c
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  external routines
c
      external getshape,bmatrix
c
c...  local variables
c
      integer l,i,nee
      double precision shd(4,nenmax,ngaussmax),b(6,3*nenmax)
      double precision shbar(4,nenmax),vol
c
c...compute shape function derivatives over number of strain integration
c   points, and then compute average dilatational component.
c
cdebug      write(6,*) "Hello from bdeld_ss_f!"
c
      call getshape(xl,sh,shj,shd,shbar,det,gauss,vol,n,nen,nsd,
     & ngauss,ierr)
      if(ierr.ne.0) return
c
c...construct b matrix and compute strains and rotations at gauss
c   point(s)
c
      do l=1,ngauss
        call bmatrix(b,shd(1,1,l),shbar,nsd,ndof,nen,nstr)
        call dgemv("n",nstr,nee,one,b,nstr,dl,ione,zero,ee(1,l),ione)
      end do
      return
      end
c
c version
c $Id: bdeld_ss.f,v 1.1 2004/06/14 21:40:22 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 