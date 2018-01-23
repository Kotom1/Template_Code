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
!  file:     parser.f90
!  @version: 1.0
!  @author:  Chaiwoot Boonyasiriwat
!  email:    chaiwoot@kaust.edu.sa
!  date:     December 2009
!  purpose:  module that contains utility subroutines for reading input
!            parameters
!

module parser

implicit none

integer, private, parameter :: cdim=4096
integer, private, parameter :: nline=1000

interface readCmd
  module procedure readCmdString
  module procedure readCmdInteger
  module procedure readCmdReal
end interface

interface readParFile
  module procedure readParFileString
  module procedure readParFileInteger
  module procedure readParFileReal
end interface

contains

!------------------------------------------------------------------------------
subroutine readCmdString(keyword, cvalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: keyword
  character(*), intent(out)          :: cvalue
  character(*), intent(in), optional :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument

  ! There is no input argument.
  if (iargc() == 0) then
    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! There is a default value.
    if (present(default)) then
      cvalue = default
    endif
  else
    do i=1,iargc()
      call getarg(i,argument)
      if (argument(1:len(keyword)) == keyword) then
        cvalue = argument(len(keyword)+2:len_trim(argument))
        goto 100
      endif
    enddo

    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! Use the default value.
    if (present(default)) then
      cvalue = default
    endif
    100 continue
  endif

end subroutine readCmdString

!--------------------------------------------------------------------
subroutine readCmdInteger(keyword, ivalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: keyword
  integer,      intent(out)          :: ivalue
  integer,      intent(in), optional :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument

  ! There is no input argument.
  if (iargc() == 0) then
    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! There is a default value.
    if (present(default)) then
      ivalue = default
    endif
  else
    do i=1,iargc()
      call getarg(i,argument)
      if (argument(1:len(keyword)) == keyword) then
        read(argument(len(keyword)+2:len_trim(argument)),*) ivalue
        goto 100
      endif
    enddo

    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! Use the default value.
    if (present(default)) then
      ivalue = default
    endif
    100 continue
  endif

end subroutine readCmdInteger

!--------------------------------------------------------------------
subroutine readCmdReal(keyword, fvalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: keyword
  real,         intent(out)          :: fvalue
  real,         intent(in), optional :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument

  ! There is no input argument.
  if (iargc() == 0) then
    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! There is a default value.
    if (present(default)) then
      fvalue = default
    endif
  else
    do i=1,iargc()
      call getarg(i,argument)
      if (argument(1:len(keyword)) == keyword) then
        read(argument(len(keyword)+2:len_trim(argument)),*) fvalue
        goto 100
      endif
    enddo

    if (present(required)) then
      if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
    endif

    ! Use the default value.
    if (present(default)) then
      fvalue = default
    endif
    100 continue
  endif

end subroutine readCmdReal

!--------------------------------------------------------------------
subroutine readParFileString(filename, keyword, cvalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: filename, keyword
  character(*), intent(out)          :: cvalue
  character(*), intent(in), optional :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument
  character(200)                     :: line

  open(10,file=filename,form='formatted',status='old')
  do i=1,nline
    read(10,'(a)',end=100) line
    if (line(1:len(keyword)) == keyword) then
      cvalue = line(len(keyword)+2:len_trim(line))
      goto 200
    endif
  enddo
  100 continue

  if (present(required)) then
    if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
  endif

  ! Use the default value.
  if (present(default)) then
    cvalue = default
  else
    cvalue = 'n/a'
  endif
  200 continue
  close(10)

end subroutine readParFileString

!------------------------------------------------------------------------------
subroutine readParFileInteger(filename, keyword, ivalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: filename, keyword
  integer, intent(out)               :: ivalue
  integer, intent(in), optional      :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument
  character(200)                     :: line

  open(10,file=filename,form='formatted',status='old')
  do i=1,nline
    read(10,'(a)',end=100) line
    if (line(1:len(keyword)) == keyword) then
      read(line(len(keyword)+2:len_trim(line)),*) ivalue
      goto 200
    endif
  enddo
  100 continue

  if (present(required)) then
    if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
  endif

  ! Use the default value.
  if (present(default)) then
    ivalue = default
  endif
  200 continue
  close(10)

end subroutine readParFileInteger

!------------------------------------------------------------------------------
subroutine readParFileReal(filename, keyword, fvalue, default, required)
  implicit none
  logical,      intent(in), optional :: required
  character(*), intent(in)           :: filename, keyword
  real, intent(out)                  :: fvalue
  real, intent(in), optional         :: default
  integer                            :: iargc, i
  character(cdim)                    :: argument
  character(200)                     :: line

  open(10,file=filename,form='formatted',status='old')
  do i=1,nline
    read(10,'(a)',end=100) line
    if (line(1:len(keyword)) == keyword) then
      read(line(len(keyword)+2:len_trim(line)),*) fvalue
      goto 200
    endif
  enddo
  100 continue

  if (present(required)) then
    if (required) write(*,*) 'Parameter ', trim(keyword), ' is missing!'
  endif

  ! Use the default value.
  if (present(default)) then
    fvalue = default
  endif

  200 continue
  close(10)

end subroutine readParFileReal

end module parser
!------------------------------------------------------------------------------


