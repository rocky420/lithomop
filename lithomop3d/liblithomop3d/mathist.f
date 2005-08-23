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
      subroutine mathist(ptmp,prop,mhist,histry,nprop,imat,nstep,nhist,
     & lastep,matchg,ierr,errstrng)
c
c...  subroutine to assign material properties based on time histories
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer nprop,imat,nstep,nhist,lastep,ierr
      integer mhist(nprop)
      logical matchg
      character errstrng*(*)
      double precision ptmp(nprop),prop(nprop),histry(nhist,lastep+1)
c
c...  local variables
c
      integer i
c
cdebug      write(6,*) "Hello from mathist_f!"
c
      ierr=0
      matchg=.false.
      do i=1,nprop
        ptmp(i)=prop(i)
        if(mhist(i).ne.izero) then
          if(mhist(i).gt.nhist.or.mhist(i).lt.0) then
            ierr=100
            errstrng="mathist"
            return
          end if
          ptmp(i)=histry(mhist(i),nstep+1)*prop(i)
          matchg=.true.
        end if
      end do
c
      return
      end
c
c version
c $Id: mathist.f,v 1.6 2004/08/12 02:03:59 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 