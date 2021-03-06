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
      subroutine write_subiter(nprevdflag,kw,idout,ofile)
c
c...subroutine to write parameters controlling the subiteration
c   process
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer nprevdflag,kw,idout
      character ofile*(*)
c
c...  local variables
c
      if(idout.gt.0) then
        call open_append_stop(kw,ofile,"old","","write_subiter")
        write(kw,700) nprevdflag
        close(kw)
      end if
c
      return
c
700   format(///' l i n e a r   s o l u t i o n   ',
     & 'i n f o r m a t i o n'//,5x,
     & ' initial solution flag  . . . . . . . .(nprevdflag) =',i5,//,5x,
     & '    eq.0,  use zero initial guess                    ',/,5x,
     & '    eq.1,  use displacements from previous step      ')
      end
