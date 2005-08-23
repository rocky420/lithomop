c -*- Fortran -*-
c
c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2005  All Rights Reserved
c
c  Copyright 2005 Rensselaer Polytechnic Institute.
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
c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c...  Example include file to define element interpolation information
c     in f77.  This is a temporary template, based on a linear hex
c     element with full quadrature.  It is unclear at present whether
c     it is desirable to put all of this information into an 'include'
c     file, which will require it to be compiled as a separate element
c     type.  Since all of my present routines that deal with
c     interpolation information do not require any knowledge of the
c     element characteristics, it seems a more general approach would
c     be to either tabulate (or read from a tabulated list) this
c     information at runtime.  This would prevent the problem of
c     having to define a new element type corresponding to each possible
c     integration order, for example.
c
c...  Array definitions and values:
c
c       sh(nsd+1,nen,ngauss):     Shape functions and derivatives in
c                                 natural coordinates.
c       shj(nsd+1,nen,ngauss):    Shape functions and derivatives in
c                                 natural coordinates.  These are used
c                                 for computing the Jacobian.
c       gauss(nsd+1,ngauss):      Quadrature point coordinates and
c                                 weights.
c
c       The global dimension nsd is the number of spatial dimensions.
c
      double precision sh(nsd+1,nen,ngauss)
      double precision shj(nsd+1,nen,ngauss)
      double precision gauss(nsd+1,ngauss)
c
c...  It would probably be better to use more precision.  I did it
c     this way for neatness.  Note that standard f77 only allows you
c     to use the first 72 columns.
c
      data gauss/
     & -5.773502692d-1,-5.773502692d-1, 5.773502692d-1, 1.000000000d+00,
     &  5.773502692d-1,-5.773502692d-1, 5.773502692d-1, 1.000000000d+00,
     &  5.773502692d-1, 5.773502692d-1, 5.773502692d-1, 1.000000000d+00,
     & -5.773502692d-1, 5.773502692d-1, 5.773502692d-1, 1.000000000d+00,
     & -5.773502692d-1,-5.773502692d-1,-5.773502692d-1, 1.000000000d+00,
     &  5.773502692d-1,-5.773502692d-1,-5.773502692d-1, 1.000000000d+00,
     &  5.773502692d-1, 5.773502692d-1,-5.773502692d-1, 1.000000000d+00,
     & -5.773502692d-1, 5.773502692d-1,-5.773502692d-1, 1.000000000d+00/
c
      data sh/
     & -3.110042340d-1,-3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     &  3.110042340d-1,-8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2, 8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2, 3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2,-8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     &  8.333333333d-2,-2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2, 2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     & -2.232909937d-2, 8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     & -3.110042340d-1,-8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1,-3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     &  8.333333333d-2, 3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2, 8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2,-2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2,-8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     &  2.232909937d-2, 8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     & -2.232909937d-2, 2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     & -8.333333333d-2,-8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     &  8.333333333d-2,-3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1, 3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     & -3.110042340d-1, 8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     & -2.232909937d-2,-2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     &  2.232909937d-2,-8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2, 8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2, 2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2,-3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2,-8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     &  3.110042340d-1, 8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     & -3.110042340d-1, 3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     & -2.232909937d-2,-8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2,-2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     &  8.333333333d-2, 2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2, 8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2,-8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     &  8.333333333d-2,-2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2, 2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     & -2.232909937d-2, 8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     & -3.110042340d-1,-3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     &  3.110042340d-1,-8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2, 8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2, 3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2,-2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2,-8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     &  2.232909937d-2, 8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     & -2.232909937d-2, 2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     & -3.110042340d-1,-8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1,-3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     &  8.333333333d-2, 3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2, 8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     & -2.232909937d-2,-2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     &  2.232909937d-2,-8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2, 8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2, 2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2,-8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     &  8.333333333d-2,-3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1, 3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     & -3.110042340d-1, 8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     & -2.232909937d-2,-8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2,-2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     &  8.333333333d-2, 2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2, 8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2,-3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2,-8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     &  3.110042340d-1, 8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     & -3.110042340d-1, 3.110042340d-1,-3.110042340d-1, 4.905626122d-1/
c
      data shj/
     & -3.110042340d-1,-3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     &  3.110042340d-1,-8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2, 8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2, 3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2,-8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     &  8.333333333d-2,-2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2, 2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     & -2.232909937d-2, 8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     & -3.110042340d-1,-8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1,-3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     &  8.333333333d-2, 3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2, 8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2,-2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2,-8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     &  2.232909937d-2, 8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     & -2.232909937d-2, 2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     & -8.333333333d-2,-8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     &  8.333333333d-2,-3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1, 3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     & -3.110042340d-1, 8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     & -2.232909937d-2,-2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     &  2.232909937d-2,-8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2, 8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2, 2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2,-3.110042340d-1, 8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2,-8.333333333d-2, 2.232909937d-2, 3.522081090d-2,
     &  3.110042340d-1, 8.333333333d-2, 8.333333333d-2, 1.314458558d-1,
     & -3.110042340d-1, 3.110042340d-1, 3.110042340d-1, 4.905626122d-1,
     & -2.232909937d-2,-8.333333333d-2,-8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2,-2.232909937d-2,-2.232909937d-2, 9.437387838d-3,
     &  8.333333333d-2, 2.232909937d-2,-8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2, 8.333333333d-2,-3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2,-8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     &  8.333333333d-2,-2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2, 2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     & -2.232909937d-2, 8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     & -3.110042340d-1,-3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     &  3.110042340d-1,-8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2, 8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     & -8.333333333d-2, 3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2,-2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2,-8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     &  2.232909937d-2, 8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     & -2.232909937d-2, 2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     & -3.110042340d-1,-8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1,-3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     &  8.333333333d-2, 3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     & -8.333333333d-2, 8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     & -2.232909937d-2,-2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     &  2.232909937d-2,-8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     &  8.333333333d-2, 8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2, 2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2,-8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     &  8.333333333d-2,-3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     &  3.110042340d-1, 3.110042340d-1,-3.110042340d-1, 4.905626122d-1,
     & -3.110042340d-1, 8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     & -2.232909937d-2,-8.333333333d-2, 8.333333333d-2, 3.522081090d-2,
     &  2.232909937d-2,-2.232909937d-2, 2.232909937d-2, 9.437387838d-3,
     &  8.333333333d-2, 2.232909937d-2, 8.333333333d-2, 3.522081090d-2,
     & -8.333333333d-2, 8.333333333d-2, 3.110042340d-1, 1.314458558d-1,
     & -8.333333333d-2,-3.110042340d-1,-8.333333333d-2, 1.314458558d-1,
     &  8.333333333d-2,-8.333333333d-2,-2.232909937d-2, 3.522081090d-2,
     &  3.110042340d-1, 8.333333333d-2,-8.333333333d-2, 1.314458558d-1,
     & -3.110042340d-1, 3.110042340d-1,-3.110042340d-1, 4.905626122d-1/
c
c... Note that, because of f77 requirements about statement order, it
c    is easiest if the interpolation information is broken up into 2
c    files.  This second file defines the array values.
c
c version
c $Id: f77_elem_interp_arrays_example.inc,v 1.1 2005/02/28 20:46:41 willic3 Exp $

c Generated automatically by Fortran77Mill on Mon Feb 28 11:48:22 2005

c End of file 