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
c...  ntimdat_dim.inc:  A header that describes the data type and
c     dimensions of arrays for the ntimdat parameter group.  This
c     header should be included for any TECTON routine that uses
c     the group.  All 'dim' header files must be included before
c     any 'def' header files.
c
c...  arrays containing parameters
c
      integer ntimdat(9)
c
c...  scalar parameters associated with arrays
c
      integer nstep,maxitp,ntdinitp,lgdefp,itmaxp,nittot,nrftot,
     & ndtot,ireform
c
c version
c $Id: ntimdat_dim.inc,v 1.4 2004/07/21 15:25:26 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 21:38:38 2003
c
c End of file 