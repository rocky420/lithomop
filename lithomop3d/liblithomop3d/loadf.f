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
      subroutine loadf(fault,dfault,histry,deltp,nfault,nstep,ndof,
     & numfn,nhist,lastep,idout,kto,kw)
c
c...program to compute current split node displacements
c
c       if ihist = -1 constant velocity
c                =  0 constant displacement in elastic soln
c                =  # load history number
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer nstep,ndof,numfn,nhist,lastep,idout,kto,kw
      integer nfault(3,numfn)
      double precision fault(ndof,numfn),dfault(ndof,numfn)
      double precision histry(nhist,lastep+1),deltp
c
c...  defined constants
c
      include "rconsts.inc"
c
c...  local variables
c
cdebug      integer idb
      integer l,j,ihist
c
cdebug      write(6,*) "Hello from loadf_f!"
c*      write(6,"(8i7)") nstep,ndof,numfn,nhist,lastep,idout,kto,kw
c
      call fill(dfault,zero,ndof*numfn)
      do l=1,numfn
        ihist=nfault(3,l)
        if(ihist.gt.nhist) then
          if(idout.gt.1) write(kw,1000) ihist,nfault(2,l)
          write(kto,1000) ihist,nfault(2,l)
          stop
        end if
        do j=1,ndof
          if(ihist.eq.-1) then
            dfault(j,l)=deltp*fault(j,l)
          else if((ihist.eq.0).and.(nstep.eq.0)) then
            dfault(j,l)=fault(j,l)
          else if(ihist.gt.0) then
            dfault(j,l)=fault(j,l)*histry(ihist,nstep+1)
          end if
        end do
c*        write(6,"(3i7,3(2x,1pe15.8))") (nfault(idb,l),idb=1,3),
c*     &   (dfault(idb,l),idb=1,ndof)
      end do
      return
1000  format(//' fatal split node error!'//
     & ' attempt to use undefined load history # ',i5,
     & ' at split node # ',i7)
      end
c
c version
c $Id: loadf.f,v 1.1 2004/04/14 21:18:30 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
