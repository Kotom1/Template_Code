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
!  file:     mmi_mpi.f90
!  @version: 1.0
!  @author:  Chaiwoot Boonyasiriwat
!  email:    chaiwoot@kaust.edu.sa
!  date:     December 2009
!  purpose:  module for MPI
!

module mmi_mpi

implicit none
include 'mpif.h'
integer  :: root, rank, nsize, tag, status(MPI_STATUS_SIZE), ierr, sendtag, recvtag, currentShot, &
            source_tag, data_tag, terminate_tag, result_tag, slave, count, req(12), st(MPI_STATUS_SIZE,12)

contains

!------------------------------------------------------------------------------
subroutine init_mpi

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,nsize,ierr)

end subroutine init_mpi

!------------------------------------------------------------------------------
subroutine stop_mpi

call MPI_Finalize(ierr)

end subroutine stop_mpi

!-----------------------------------------------------------------------------------------
! Static load balancing
!
! Purpose: Assign starting and ending shot numbers to an MPI process
!
! Modified from the original version written by Jianming Sheng
!
! is1 = starting shot number of the original list of shot numbers
! is2 = ending shot number of the original list of shot numbers
! is_begin = starting shot number for an MPI process
! is2_end = ending shot number for an MPI process
!
subroutine get_assigned(is1, is2, is_begin, is_end)

integer, intent(in)  :: is1, is2
integer, intent(out) :: is_begin, is_end
integer              :: nnn, ii1, ii2

if(nsize == 1)then
  is_begin = is1
  is_end = is2
  return
endif

nnn = is2-is1+1
ii1 = int(nnn/nsize)
if(ii1 == 0)then
  is_begin = is1+rank
  is_end = is_begin
  return
endif

ii2=nnn-ii1*nsize
if(rank < (nsize-ii2))then
  is_begin = is1+rank*ii1
  is_end = is1+(rank+1)*ii1-1
else 
  is_begin = is1+ii2+rank*ii1+rank-nsize
  is_end = is1+ii2+(rank+1)*ii1+rank-nsize
endif

end subroutine get_assigned

!-----------------------------------------------------------------------------------------
subroutine get_assigned_general(is1, is2, job_id, total_job, is_begin, is_end)

integer, intent(in)  :: is1, is2, job_id, total_job
integer, intent(out) :: is_begin, is_end
integer              :: nnn, ii1, ii2

if(total_job == 1)then
  is_begin = is1
  is_end = is2
  return
endif

nnn = is2-is1+1
ii1 = int(nnn/total_job)
if(ii1 == 0)then
  is_begin = is1+job_id
  is_end = is_begin
  return
endif

ii2=nnn-ii1*total_job
if(job_id < (total_job-ii2))then
  is_begin = is1+job_id*ii1
  is_end = is1+(job_id+1)*ii1-1
else 
  is_begin = is1+ii2+job_id*ii1+job_id-total_job
  is_end = is1+ii2+(job_id+1)*ii1+job_id-total_job
endif

end subroutine get_assigned_general

!---------------------------------------------------------------------------------------
subroutine message(msg)

character(*), intent(in) :: msg

if (rank == 0) write(*,*) msg

end subroutine message

end module mmi_mpi

