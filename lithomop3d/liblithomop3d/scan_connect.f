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
      subroutine scan_connect(neni,infmatmod,infmat,ivflist,
     & maxvfamilies,numat,numelv,nvfamilies,ietypev,kr,cfile,ierr,
     & errstrng)
c
c...  subroutine to perform an initial scan of the element connectivity
c     file to determine the total number of elements and the number of
c     elements of each material type.  At present, each material type
c     is assumed to represent an 'element family', and only a single
c     element type is allowed.  In the near future, families will be
c     defined by material model (not type) and element type.
c
c     Note that the variable netypesi (and the associated arrays) only
c     defines the number of 'primitive' element types, and does not
c     include the infinite element permutations.  This makes input much
c     simpler, since there are then only 10 element types to define.
c
c     Error codes:
c         0:  No error
c         1:  Error opening input file
c         3:  Read error
c       106:  Illegal element type
c       101:  Attempt to use undefined material model
c       107:  Illegal material type
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "nshape.inc"
      include "materials.inc"
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer maxvfamilies,numat,numelv,nvfamilies,ietypev,kr,ierr
      integer neni(netypesi),infmatmod(6,nmatmodmax),infmat(numat)
      integer ivflist(3,maxvfamilies)
      character cfile*(*),errstrng*(*)
c
c...  local variables
c
      integer j,n,ietype,ietypel,imat,infin
      integer ien(20)
c
cdebug      write(6,*) "Hello from scan_connect_f!"
c
c...  open input file
c
cdebug      write(6,*) "maxvfamilies:",maxvfamilies
      ierr=izero
      numelv=izero
      ietypev=izero
      nvfamilies=izero
      call ifill(ivflist,izero,ithree*maxvfamilies)
      open(kr,file=cfile,status="old",err=20)
c
c... scan the file, counting the number of entries for each type of
c    material (element family).
c    Note:  Due to speed considerations, we are not allowing the option
c    of putting comments within the list.  To do this, we
c    would need to scan each line twice to determine whether it was a
c    comment.
c
      call pskip(kr)
      read(kr,*,end=10,err=30) n,ietypel,imat,infin,
     & (ien(j),j=1,neni(ietypel))
      call infcmp(ietypel,ietypev,infin)
      backspace(kr)
      if(ietypel.le.izero.or.ietypel.gt.netypesi) then
        ierr=106
        errstrng="scan_connect"
        return
      end if
 40   continue
        read(kr,*,end=10,err=30) n,ietype,imat,infin,
     &   (ien(j),j=1,neni(ietype))
c
        if(ietype.ne.ietypel) then
          ierr=106
          errstrng="scan_connect"
          return
        end if
c
        if(imat.le.izero.or.imat.gt.numat) then
          ierr=107
          errstrng="scan_connect"
          return
        end if
c
        ivflist(1,imat)=ivflist(1,imat)+ione
        ivflist(2,imat)=imat
        ivflist(3,imat)=infmat(imat)
        numelv=numelv+ione
c
        go to 40
c
c...  normal return
c
 10   continue
        close(kr)
c
c...  determine the number of element families
c
        do j=1,maxvfamilies
cdebug          write(6,*) "j,ivflist(1,j),ivflist(2,j):"
cdebug          write(6,*) j,ivflist(1,j),ivflist(2,j)
          if(ivflist(1,j).ne.izero) nvfamilies=nvfamilies+1
        end do
cdebug        write(6,*) "nvfamilies:",nvfamilies
        return
c
c...  error opening file
c
 20   continue
        close(kr)
	ierr=1
        return
c
c...  read error
c
 30   continue
        ierr=3
        close(kr)
        return
c
      end
c
c version
c $Id: scan_connect.f,v 1.6 2005/04/01 23:24:41 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
