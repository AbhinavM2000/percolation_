integer function getkey(inp1,inp2,m) 
	
	real :: inp1,inp2,rno1,rno2,rno3
	integer :: key
	character(8)  :: date
	character(10) :: time
	character(5)  :: zone
	call date_and_time(date,time,zone)
	call date_and_time(DATE=date,ZONE=zone)
	call date_and_time(TIME=time)
	read( date, '(f10.0)' )  rno1
	read( time, '(f10.0)' )  rno2
	read( zone, '(f10.0)' )  rno3

!Current date and time are used as seed for the random number generator

	rno3=rno1/rno3+rno2
	rno3=rno3+m
	rno3=rand(int(rno3))
	
	
!rno3 now contains a random number between 0 and 1	
   
	if (rno3 .GE. 0 .AND. rno3 .LE. inp1) then
	key = 0 !Cell is empty
	end if
   
	if (rno3 .GE. inp1 .AND. rno3 .LT. 1) then
	key=1 !Cell is populated
	end if
	getkey = key !key is returned
	key=0
end function getkey


program perc
implicit none 
   
integer, dimension (:,:), allocatable :: darray   
!dimension is 2, but size is determined at runtime   

integer :: s1,s2,i,j,key,getkey,m=0
real::inp1, inp2
print*, "Enter site occupation probability:"     
read*, inp1 
inp2=1-inp1
print*, "Enter the dimensions of the array:"     
read*, s1 
s2=s1
allocate ( darray(s1,s1) )
! dynamically allocate the array    
	 
do i = 1, s1           
	do j = 1, s2
		m=m+50
		key=getkey(inp1,inp2,m)
		
		print *, key
		if (key .EQ. 0) then
			darray(i,j)=0 !set array elements
			end if
		if (key .EQ. 1) then
			darray(i,j)=1  !set array elements
		end if
END DO
END DO
! populated the cells of the array according to probability using getkey()      


OPEN(UNIT=1,FILE="data1.txt",FORM="FORMATTED",STATUS="OLD")  !open textfile
do i = 1, s1   
		write(UNIT=1,FMT="(A)",advance="yes") " "	!put linebreak 
	print*," " 	!put linebreak in console
      do j = 1, s2
		if(darray(i,j).EQ.1) then
		write(UNIT=1,FMT="(A)",advance="no") "1" !write to txt
		end if
		if(darray(i,j).EQ.0) then
		write(UNIT=1,FMT="(A)",advance="no") "0" !write to txt
		end if
		write(UNIT=1,FMT="(A)",advance="no") " " !space	write(*,"(I2)",advance="no") darray(i,j) !output matrix to console
	write(*,"(A)",advance="no") " " !space
END DO
END DO
print*," " !linebreak
close(1)
PAUSE
end program perc

