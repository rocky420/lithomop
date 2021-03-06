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
      subroutine invar(sdev,sinv1,steff,stn)
c
c...routine to compute deviatoric stress, stress invariant
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "rconsts.inc"
c
c...  subroutine arguments
c
      double precision sdev(6),stn(6),sinv1,steff
c
c...  intrinsic functions
c
      intrinsic sqrt
c
c...  external routines
c
      double precision sprod
      external sprod
c
c...  local variables
c
      double precision smean
c
cdebug      write(6,*) "Hello from invar_f!"
c
      sinv1=stn(1)+stn(2)+stn(3)
      smean=sinv1/three
      sdev(1)=stn(1)-smean
      sdev(2)=stn(2)-smean
      sdev(3)=stn(3)-smean
      sdev(4)=stn(4)
      sdev(5)=stn(5)
      sdev(6)=stn(6)
      steff=sqrt(sprod(sdev,sdev))
      return
      end
c
c version
c $Id: invar.f,v 1.3 2004/08/12 01:32:43 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
