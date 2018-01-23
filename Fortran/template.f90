program template

use global
use io
use mmi_mpi
use parser
use tydef

implicit none

real :: t1, t2

call cpu_time(t1)
call temp
call cpu_time(t2)
if (rank == 0) write(*,*) 'Runtime = ', (t2-t1)
if (rank == 0) write(*,*) 'Runtime = ', (t2-t1)/nsize

contains

subroutine temp

use string

type(param)          :: par
real,allocatable     :: vel(:,:)

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,nsize,ierr)

! Read in velocity model parameters: nx, nz, dx, filename
call readparamfile('parfile',par)

allocate(vel(par%nz,par%nx))

write (*,*) "nz = ", par%nz, "nx = ", par%nx
write (*,*) "velin = ", par%filein
write (*,*) "velout = ", par%fileout

call read_binfile(par%filein ,vel ,par%nz ,par%nx )

call filename(output, par%fileout, 1, '.bin')
call write_binfile(output,vel,par%nz, par%nx)

call MPI_Finalize(ierr)

deallocate(vel)

end subroutine temp

!-----------------------------------------------------------------------------------------
subroutine readparamfile(parfile, par)

use parser

character(len=*), intent(in) :: parfile
type(param), intent(out)     :: par

if (rank == 0) then
  call readParFile(parfile, 'NX',           par%nx,             0)
  call readParFile(parfile, 'NZ',           par%nz,             0)
  call readParFile(parfile, 'FILEIN',           par%filein,             'n/a')
  call readParFile(parfile, 'FILEOUT',           par%fileout,             'n/a')
endif

call MPI_BCAST(par%nx,1,             MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
call MPI_BCAST(par%nz,1,             MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
call MPI_BCAST(par%filein,100,             MPI_CHARACTER,0,MPI_COMM_WORLD,ierr)
call MPI_BCAST(par%fileout,100,             MPI_CHARACTER,0,MPI_COMM_WORLD,ierr)

end subroutine readparamfile

end program template

