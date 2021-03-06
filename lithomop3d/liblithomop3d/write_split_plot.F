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
      subroutine write_split_plot(idftn,numflt,kp,idsk,pfile)
c
c...  subroutine to write out each split node.
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer numflt,kp,idsk
      integer idftn(numflt)
      character pfile*(*)
c
c...  local variables
c
      integer i
c
c...  write results to plot file, if requested
c
      if(idsk.eq.1) then
        call open_append_stop(kp,pfile,"old","",
     &                        "write_split_plot")
        write(kp,"(i7)") numflt
        close(kp)
      else if(idsk.eq.2) then
        call open_append_stop(kp,pfile,"old","unformatted",
     &                        "write_split_plot")
        write(kp) numflt
        if(numflt.ne.0) write(kp) (idftn(i),i=1,numflt)
        close(kp)
      end if
c
      return
      end
c
c version
c $Id: write_split_plot.F,v 1.1 2005/08/05 19:58:06 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
