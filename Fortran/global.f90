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
!  file:     global.f90
!  @version: 1.0
!  @author:  Chaiwoot Boonyasiriwat
!  email:    chaiwoot@kaust.edu.sa
!  date:     December 2009
!  purpose:  module that defines global variables or constants
!

module global

implicit none

! Constants
real(4), parameter :: pi        = 3.14159265358979
real(4), parameter :: twopi     = 2.0*pi

! Type of job
character(len=200) :: jobtype, input, output, parfile

! Record length unit
integer, parameter :: i4 = 4

! FD coefficients
real, parameter :: c1_2nd_order = -2.5
real, parameter :: c2_2nd_order = 4.0/3.0
real, parameter :: c3_2nd_order = -1.0/12.0
real, parameter :: c1_8th = -205.0/72.0
real, parameter :: c2_8th = 8.0/5.0
real, parameter :: c3_8th = -1.0/5.0
real, parameter :: c4_8th = 8.0/315.0
real, parameter :: c5_8th = -1.0/560.0

real, parameter :: c1_staggered = 9.0/8.0
real, parameter :: c2_staggered = -1.0/24.0

real, parameter :: c1_stag_6th = 1.171875000000000
real, parameter :: c2_stag_6th = -6.5104166666666687E-002
real, parameter :: c3_stag_6th = 4.6875000000000009E-003
end module global

