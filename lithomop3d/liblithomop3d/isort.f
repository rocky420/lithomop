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
      subroutine isort(n,ia)
c
c...  subroutine to sort an integer array.  Adapted from Numerical
c     Recipes.
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer n
      integer ia(n)
c
c... local variables
c
      integer l,ir,iia,j,i
c
      if(n.le.1) return
      l=n/2+1
      ir=n
10    continue
        if(l.gt.1)then
          l=l-1
          iia=ia(l)
        else
          iia=ia(ir)
          ia(ir)=ia(1)
          ir=ir-1
          if(ir.eq.1)then
            ia(1)=iia
            return
          end if
        end if
        i=l
        j=l+l
20      if(j.le.ir)then
          if(j.lt.ir)then
            if(ia(j).lt.ia(j+1))j=j+1
          end if
          if(iia.lt.ia(j))then
            ia(i)=ia(j)
            i=j
            j=j+j
          else
            j=ir+1
          end if
        go to 20
        end if
        ia(i)=iia
      go to 10
      end
c
c version
c $Id: isort.f,v 1.1 2004/04/14 21:18:30 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
