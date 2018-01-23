!
!  Copyright (C) 2010 Center for Subsurface Imaging and Fluid Modeling (CSIM),
!  King Abdullah University of Science and Technology, All rights reserved.
!
!  Sponsors of CSIM are granted a non-exclusive, irrevocable royalty free
!  world-wide license to use this software and associated documentation files
!  (the "Software"), in their business, including the rights to modify and
!  distribute the Software to their affiliates, partners, clients or consultants
!  as necessary in the conduct of the sponsors business, all without accounting
!  to the King Abdullah University of Science and Technology, subject to the
!  following conditions:
!
!  The above copyright notice and this permission notice shall be included
!  in all copies or substantial portions of the Software.
!
!  Warranty Disclaimer:
!  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
!  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
!  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
!  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
!  DEALINGS IN THE SOFTWARE.
!

!
!  file:     string.f90
!  @version: 1.0
!  @author:  Chaiwoot Boonyasiriwat
!  email:    chaiwoot@kaust.edu.sa
!  date:     December 2009
!  purpose:  module for string utility
!

module string

implicit none
contains

subroutine filename(fname,str1,num,str2)

      implicit none
      character*(*) str1, str2
      character*200 fname, string, string_tmp, str
      character ch
      integer i, itb, len1, len2, len3, num, len_new, len_fname

      do i=1,200
        string_tmp(i:i)=' '
      enddo
      itb=1
      ch='0'
      call strlen(str1,len1)
      call strlen(str2,len2)
      len3=999
      string_tmp(1:len1)=str1(1:len1)
      call num2str(string,num,len3,len_new,itb,ch)
      len_fname=len1+len_new+len2
      string_tmp((len1+1):(len1+len_new))=string(1:len_new)
      string_tmp((len1+len_new+1):(len1+len_new+len2))=str2(1:len2)
      fname=string_tmp

end subroutine filename
 
!----------------------------------------------------------------------
subroutine itoa(number, str, str_len)
!     ITOA converts an interger 'number' to a string 'str'.
!     Written by Chaiwoot Boonyasiriwat (April 30, 2007)

      implicit none
      integer number, str_len
      character(*) str
      integer i, indx, n

      if (number .eq. 0) then
        str(1:1) = '0'
        str_len = 1
        return
      endif
      str_len = log10(dble(number))+1
      if (str_len.gt.0) then
        do i=1,str_len
          indx = str_len-i+1
          n = (number/10)*10
          str(indx:indx) = char(48+(number-n))
          number = n/10
        enddo
      endif
      write(*,*) str(1:str_len)

end subroutine itoa

!----------------------------------------------------------------------
subroutine get_num_new(x,nn,str,line,nl,is_suc)

      implicit none
      real x(nn)
      character*200 line(nl),line_tmp
      character*(*) str
      integer lenn, i, ii, j, ind, indeq, k, is_suc, nn, nl

      lenn=len(str)
      do i=1,nl
        line_tmp=line(i)
        ii=index(line_tmp,'#')
        if(ii.ne.0)then
          do j=ii,200
            line_tmp(j:j)=' '
          enddo
        endif
        ind=index(line_tmp,str(1:lenn))
        if(ind.ne.0)then
          indeq=index(line_tmp,'=')
          read(line_tmp(indeq+1:200),*,err=111,end=111)(x(k),k=1,nn)
          is_suc=1
          return
111       continue
          ind=0
        endif
      enddo
      is_suc=0

end subroutine get_num_new

!----------------------------------------------------------------------
subroutine get_str_new(str_new,str,line,nl,len_new)

      implicit none
      character*200 line(nl),line_tmp
      character*200 str_tmp,str_new
      character*(*) str
      integer lenn, len_new, nl, i, ii, j, is_found, indeq, ib1, ib2

      do i=1,200
        str_new(i:i)=' '
      enddo
      lenn=len(str)
      len_new=0
      do i=1,nl
        line_tmp=line(i)
        ii=index(line_tmp,'#')
        if(ii.ne.0)then
          do j=ii,200
            line_tmp(j:j)=' '
          enddo
        endif
        is_found=index(line_tmp,str(1:lenn))
        if(is_found.ne.0)then
          indeq=index(line_tmp,'=')
          read(line_tmp(indeq+1:200),'(a)',err=111,end=111)str_tmp
          ib1=200
          ib2=200
          do j=1,200
            if(str_tmp(j:j).ne.' '.and.ib1.eq.200)then
              ib1=j
            endif
            if(str_tmp(j:j).eq.' '.and.ib1.ne.200)then
              ib2=j-1
              go to 222
            endif
          enddo
222       continue
          if(ib1.eq.200)then
            len_new=0
            return
          endif
          len_new=ib2-ib1+1
          str_new(1:len_new)=str_tmp(ib1:ib2)
          return
111       continue
          len_new=0
          return
        endif
      enddo
end subroutine get_str_new

!----------------------------------------------------------------------
subroutine strlen(fname,lenn)

      implicit none
      character*(*) fname
      character*200 str
      integer nll, lenn, i

      nll=len(fname)
      lenn=0
      do i=1,nll
        if(fname(i:i).ne.' ')then
          lenn=lenn+1
        else if(lenn.ne.0)then
          return
        endif
      enddo
end subroutine strlen
 
!----------------------------------------------------------------------
subroutine num2str(string,num,lenstr,len_new,itb,ch)

      implicit none
      character ch
      character*200 string
      integer len_new, nnn, num, itb, iii, ii, iic, i, lenstr, i0

      if(lenstr.eq.0.or.num.lt.0)then
        len_new=0
        return
      endif
      if(num.eq.0)then
        nnn=1
      else
        nnn=(log10(dble(num)))+0.000000001+1
      endif
      iii=num
      if(lenstr.eq.999)then
        len_new=nnn
      else
        len_new=lenstr
      endif
      i0=ichar('0')
      do i=1,len_new
        string(i:i)=ch
      enddo
      do i=1,nnn
        ii=iii/10
        iic=iii-ii*10
        iii=ii
        if(itb.eq.1)then
          string((nnn-i+1):(nnn-i+1))=char(i0+iic)
        else
          if(len_new.ge.i)then
            string((len_new-i+1):(len_new-i+1))=char(i0+iic)
          endif
        endif
      enddo

end subroutine num2str

end module string

