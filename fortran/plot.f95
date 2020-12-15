function count_paths(matrix2,s1,s2) result(sum) 
implicit none
	integer:: i,matrix2(5,5),s1,s2
	real(kind=8):: sum,floodfill
	sum=0
	do i = 1,5
		sum = sum+floodfill(1, i,matrix2,s1,s2)
	end do
end function count_paths




recursive function floodfill(r ,c,matrix1,s1,s2) result(u)
implicit none
	integer:: r,c,matrix1(5,5),r1,c1,s1,s2
	real(kind=8):: u	
	u=0
	if (r.LE.5 .AND. c.LE.5 .AND. r.GE.1 .AND. c.GE.1 .AND. matrix1(r,c).EQ.1 ) then !.AND. r.GE.1 .AND. c.GE.1 excluded due to error: stack overflow
		if(r.EQ.5) then
			u=1
		else 
			r1=r
			c1=c
			u= floodfill(r1 + 1, c1,matrix1,s1,s2) + floodfill(r1 + 1, c1 + 1,matrix1,s1,s2) + floodfill(r1 + 1, c1 - 1,matrix1,s1,s2)
		end if
	end if
end function floodfill





integer function getkey(inp1,inp2,inp3)
	!IMPLICIT NONE
	real :: inp1,inp2,inp3,sdr1,sdr2,sdr3
	integer :: key,m=0
	character(8)  :: date
	character(10) :: time
	character(5)  :: zone
	call date_and_time(date,time,zone)
	call date_and_time(DATE=date,ZONE=zone)
	call date_and_time(TIME=time)
	read( date, '(f10.0)' )  sdr1
	read( time, '(f10.0)' )  sdr2
	read( zone, '(f10.0)' )  sdr3
	sdr3=sdr1/sdr3+sdr2+m
	sdr3=rand(int(sdr3))
	!print *,sdr3 
	m=m+31 !recently chenged from +
	if (sdr3 .GT. 0 .AND. sdr3 .LE. inp1) THEN
		key = 1 !blocked
	end if
	if (sdr3 .GE. inp1 .AND. sdr3 .LE. inp1+inp2) then
		key = 2 !empty
	end if
	if (sdr3 .GE. inp1+inp2 .AND. sdr3 .LT. 1) then
		key=3 !percolation material
	end if
	!print *, inp1,inp2,inp3
	getkey = key
	key=0
end function getkey




program perc
implicit none 
!dimension is 2, but size is determined at runtime  
!integer, dimension (:,:), allocatable :: darry
integer :: s1,s2,i,j,key,getkey,darry1(5,5)
real(kind=8) :: p,count_paths
real::inp1, inp2 ,inp3,g,h,t1,t2,mn
!print*, "Enter p1, p2 and p3:"     
!read*, inp1, inp2 ,inp3
!print*, "Enter the dimensions of the array:"     
!read*, s1, s2  
inp1=0  
inp2=0
inp3=0
s1=5
s2=5
mn=1000
do inp2=0.35,0.9,0.01
inp3=1-inp2
if(inp3.LE.0) then
exit
end if
! allocate memory      
!allocate ( darry1(s1,s2) )
do i = 1, s1           
	do j = 1, s2
		key=getkey(inp1,inp2,inp3)
		!print *, key
		if (key .EQ. 1) then
			darry1(i,j)=2
			end if
		if (key .EQ. 2) then
			darry1(i,j)=0
			end if
		if (key .EQ. 3) then
			darry1(i,j)=1  !input array elements
		end if
	END DO
END DO
p=count_paths(darry1,s1,s2)
OPEN(UNIT=1,FILE="data1.txt",position='append',FORM="FORMATTED",STATUS="OLD")  !open textfile


!write(1,*)inp2,",",inp3
!write(1,*) " "

!do i = 1, s1   
	!write(1,*) inp2,inp3,p
		!write(UNIT=1,FMT="(A)",advance="yes") " "	!put linebreak in txt
	!print*," " 	!put linebreak in console
      !do j = 1, s2
		!if(darry1(i,j).EQ.1) then
		!write(UNIT=1,FMT="(A)",advance="no") "#" !write to txt
		!end if
		!if(darry1(i,j).EQ.0) then
		!write(UNIT=1,FMT="(A)",advance="no") "X" !write to txt
		!end if
		!if(darry1(i,j).EQ.2) then
		!write(UNIT=1,FMT="(A)",advance="no") "O" !write to txt
		!end if
		!write(UNIT=1,FMT="(A)",advance="no") " " !write to txt
	!write(*,"(I2)",advance="no") darry1(i,j)
	!write(*,"(A)",advance="no") " " !write to console
!END DO
!END DO
!print*,darry1
!print*," " !linebreak
print*,p
!end do
write(1,*)inp2,",",p
end do
write(1,*)inp2,",",p
close(1)
!PAUSE
end program perc