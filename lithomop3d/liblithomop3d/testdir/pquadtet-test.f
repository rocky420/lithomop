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
      subroutine pquadtet(sh,shj,gauss,infetype,intord)
c
c... Subroutine to compute shape functions in natural coordinates,
c    integration points, and weights for a quadratic tetrahedron.
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
      integer intord
      integer infetype(4)
      double precision sh(nsd+1,nenmax,ngaussmax)
      double precision shj(nsd+1,nenmax,ngaussmax)
      double precision gauss(nsd+1,ngaussmax)
c
c...  local constants
c
c*      double precision r(10),s(10),t(10),u(10)
c*      data r/ 1d0, 0d0, 0d0, 0d0,0.5d0,0.0d0,0.5d0,0.5d0,0.0d0,0.0d0/
c*      data s/ 0d0, 1d0, 0d0, 0d0,0.5d0,0.5d0,0.0d0,0.0d0,0.5d0,0.0d0/
c*      data t/ 0d0, 0d0, 1d0, 0d0,0.0d0,0.5d0,0.5d0,0.0d0,0.0d0,0.5d0/
c*      data u/ 0d0, 0d0, 0d0, 1d0,0.0d0,0.0d0,0.0d0,0.5d0,0.5d0,0.5d0/
c
c...  intrinsic functions
c
      intrinsic sqrt,max
c
c...  user-defined functions
c
c
c...  local variables
c
c*      integer nen,ngauss,nec,nee,i,l,nshsize,ngssize
      integer nen,ngauss,nec,nee,l,nshsize,ngssize
c*      double precision g1,g2,rr,ss,tt,uu,drr,dss,dtt,duu
      double precision g1,g2,rr,ss,tt,uu
      double precision tetvol
      integer idb,jdb
      double precision dbsum
c
      write(6,*) "Hello from pquadtet_f!"
c
c...  definitions
c
      tetvol=sixth
      nshsize=(nsd+1)*nenmax*ngaussmax
      ngssize=(nsd+1)*ngaussmax
c
c...  Quadratic tet definition
c
      nen=10
      nec=nsd*nen
      nee=ndof*nen
      if(intord.eq.itwo) then
        ngauss=ifour
        g1=(five-sqrt(five))/20.0d0
        g2=(five+three*sqrt(five))/20.0d0
        do l=1,ngauss
          gauss(1,l)=g1
          gauss(2,l)=g1
          gauss(3,l)=g1
          if(l.ne.ione) gauss(l-ione,l)=g2
          gauss(4,l)=fourth*tetvol
        end do
      else
        ngauss=ifive
        gauss(1,1)=fourth
        gauss(2,1)=fourth
        gauss(3,1)=fourth
        gauss(4,1)=-(0.8d0*tetvol)
        g1=sixth
        g2=half
        do l=2,ngauss
          gauss(1,l)=g1
          gauss(2,l)=g1
          gauss(3,l)=g1
          if(l.ne.itwo) gauss(l-ione,l)=g2
          gauss(4,l)=0.45d0*tetvol
        end do
      end if
c
      infetype(1)=ngauss
      infetype(2)=nen
      infetype(3)=nec
      infetype(4)=nee
c
      do l=1,ngauss
        rr=gauss(1,l)
        ss=gauss(2,l)
        tt=gauss(3,l)
c*        uu=g1
c*        if(l.eq.ione) uu=g2
c*        if(intord.eq.itwo) uu=fourth
        uu=one-rr-ss-tt
        write(6,*) "l:",l
        write(6,*) "rr,ss,tt,uu:",rr,ss,tt,uu
        sh(4,1,l)=uu*(two*uu-one)
        sh(1,1,l)=one-four*uu
        sh(2,1,l)=one-four*uu
        sh(3,1,l)=one-four*uu
        sh(4,2,l)=rr*(two*rr-one)
        sh(1,2,l)=four*rr-one
        sh(2,2,l)=zero
        sh(3,2,l)=zero
        sh(4,3,l)=ss*(two*ss-one)
        sh(1,3,l)=zero
        sh(2,3,l)=four*ss-one
        sh(3,3,l)=zero
        sh(4,4,l)=tt*(two*tt-one)
        sh(1,4,l)=zero
        sh(2,4,l)=zero
        sh(3,4,l)=four*tt-one
        sh(4,5,l)=four*rr*uu
        sh(1,5,l)=four*(uu-rr)
        sh(2,5,l)=-(four*rr)
        sh(3,5,l)=-(four*rr)
        sh(4,6,l)=four*rr*ss
        sh(1,6,l)=four*ss
        sh(2,6,l)=four*rr
        sh(3,6,l)=zero
        sh(4,7,l)=four*ss*uu
        sh(1,7,l)=-(four*ss)
        sh(2,7,l)=four*(uu-ss)
        sh(3,7,l)=-(four*ss)
        sh(4,8,l)=four*tt*uu
        sh(1,8,l)=-(four*tt)
        sh(2,8,l)=-(four*tt)
        sh(3,8,l)=four*(uu-tt)
        sh(4,9,l)=four*rr*tt
        sh(1,9,l)=four*tt
        sh(2,9,l)=zero
        sh(3,9,l)=four*rr
        sh(4,10,l)=four*ss*tt
        sh(1,10,l)=zero
        sh(2,10,l)=four*tt
        sh(3,10,l)=four*ss
        dbsum=zero
        do idb=1,nen
          write(6,*) "sh:",(sh(jdb,idb,l),jdb=1,4)
          dbsum=dbsum+sh(4,idb,l)
        end do
        write(6,*) "l, sum sh:",l,dbsum
        write(6,*) "gauss:",(gauss(idb,l),idb=1,4)
      end do
      call dcopy(nshsize,sh,ione,shj,ione)
c
      return
      end
c
c version
c $Id: pquadtet-test.f,v 1.1 2004/08/12 14:39:02 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
