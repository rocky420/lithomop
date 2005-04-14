c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2005  All Rights Reserved
c
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
      subroutine write_ucd_node_vals(d,deld,tfault,dfault,nfault,numfn,
     & dx,deldx,idslp,numsn,deltp,nstep,numnp,kucd,ucdroot,iprestress)
c
c...  Specialized routine to output displacement info for SCEC
c     benchmarks.
c     This routine creates the nodal value portion of the UCD file for
c     each time step, including the header information.  Note that a
c     complete UCD file is formed by concatenating the mesh output from
c     write_ucdmesh with the file created by this routine.
c     At present, displacements and velocities are written.  In the near
c     future, the variable idispout should be used to determine whether
c     to output displacements, displacement increments, and/or
c     velocities.
c     Note also that the split node output is not really a UCD file,
c     since it contains both node and element information.
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer numfn,numsn,nstep,numnp,kucd,iprestress
      integer nfault(3,numfn),idslp(numsn)
      double precision deltp
      double precision d(ndof,numnp),deld(ndof,numnp)
      double precision tfault(ndof,numfn),dfault(ndof,numfn)
      double precision dx(ndof,numnp),deldx(ndof,numnp)
      character ucdroot*(*)
c
c...  local constants
c
      integer nnvals
      parameter(nnvals=6)
      integer ival(nnvals)
      data ival/1,1,1,1,1,1/
      character dout(nnvals)*9
      data dout/"X-Displ,m","Y-Displ,m","Z-Displ,m",
     &          "X-Vel,m/s","Y-Vel,m/s","Z-Vel,m/s"/
c
c...  external functions
c
      integer nchar,nnblnk
      external nchar,nnblnk
c
c...  local variables
c
      integer i,j,i1,i2,inode
      double precision rmult
      character filenm*200,cstep*5
c
cdebug      write(6,*) "Hello from write_ucd_node_vals!"
c
      if(deltp.ne.zero) then
        rmult=one/deltp
      else
        rmult=one
      end if
      i1=nnblnk(ucdroot)
      i2=nchar(ucdroot)
      if(iprestress.eq.izero) then
        write(cstep,"(i5.5)") nstep
      else
        cstep="prest"
      end if
c
c...  write mesh info
c
      filenm=ucdroot(i1:i2)//".mesh.time."//cstep//".inp"
      open(kucd,file=filenm,status="new")
      write(kucd,"(7i7)") nnvals,(ival(i),i=1,nnvals)
      do i=1,nnvals
        write(kucd,"(a9)") dout(i)
      end do
c
c...  write nodal displacements
c
      do i=1,numnp
        write(kucd,"(i7,6(2x,1pe15.8))") i,(d(j,i),j=1,ndof),
     &   (rmult*deld(j,i),j=1,ndof)
      end do
      close(kucd)
c
c...  write split node displacements, if there are any
c
      if(numfn.ne.0) then
        filenm=ucdroot(i1:i2)//".mesh.split.time."//cstep//".inp"
        open(kucd,file=filenm,status="new")
        write(kucd,"(7i7)") nnvals,(ival(i),i=1,nnvals)
        do i=1,nnvals
          write(kucd,"(a9)") dout(i)
        end do
        do i=1,numfn
          write(kucd,"(2i7,6(2x,1pe15.8))") nfault(1,i),nfault(2,i),
     &     (tfault(j,i),j=1,ndof),(rmult*dfault(j,i),j=1,ndof)
        end do
        close(kucd)
      end if
c
c...  write slippery node displacements, if there are any
c
      if(numsn.ne.0) then
        filenm=ucdroot(i1:i2)//".mesh.slip.time."//cstep//".inp"
        open(kucd,file=filenm,status="new")
        write(kucd,"(7i7)") nnvals,(ival(i),i=1,nnvals)
        do i=1,nnvals
          write(kucd,"(a9)") dout(i)
        end do
        do i=1,numsn
          inode=idslp(i)
          write(kucd,"(i7,6(2x,1pe15.8))") idslp(inode),
     &     (dx(j,inode),j=1,ndof),(rmult*deldx(j,inode),j=1,ndof)
        end do
        close(kucd)
      end if
      return
      end
c
c version
c $Id: write_ucd_node_vals.f,v 1.4 2005/04/14 01:01:22 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
