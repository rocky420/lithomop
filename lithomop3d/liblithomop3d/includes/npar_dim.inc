c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2003  All Rights Reserved
c
c <LicenseText>
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c...  npar_dim.inc:  A header that describes the data type and
c     dimensions of arrays for the npar parameter group.  This
c     header should be included for any TECTON routine that uses
c     the group.  All 'dim' header files must be included before
c     any 'def' header files.
c
c...  arrays containing parameters
c
      integer npar(14)
c
c...  scalar parameters associated with arrays
c
      integer numelt,numat,numpr,numslp,numfn,ipstrs,ipauto,nstatesz,
     & nstatesz0,ndmatsz,nconsz,numdif,intord,nstate0
c
c version
c $Id: npar_dim.inc,v 1.4 2005/02/24 00:30:50 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 21:38:38 2003
c
c End of file 