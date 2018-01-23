module io
use global
implicit none
contains

!-----------------------------------------------------------------------------------------
subroutine read_binfile(filename, data, n1, n2)

character(len=*), intent(in) :: filename
integer, intent(in) :: n1, n2
real                :: data(:,:)
integer :: i1,i

open(10,file=filename,access='direct',recl=n1*i4)

do i = 1, n2
   read(10, rec=i)(data(i1,i),i1=1,n1)
enddo
close(10)

end subroutine read_binfile
!-----------------------------------------------------------------------------------------

subroutine write_binfile(filename, data, n1, n2)

character(len=*), intent(in) :: filename
integer, intent(in) :: n1, n2
real, intent(in) :: data(:,:)
integer :: i,it

open(10,file=filename,access='direct',recl=n1*i4,status='replace')

do i = 1, n2
   write(10,rec=i)(data(it,i), it = 1, n1)
enddo
close(10)

end subroutine write_binfile
end module io 
