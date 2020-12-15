
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


function count_paths(matrix2,s1,s2) result(printer) !sum is being returned
implicit none
   integer:: i, path_finder,sum,matrix2(s1,s2),s1,s2,printer
   printer=0
   sum=0
   do i = 1,s1
      sum = sum+ path_finder(1, i,matrix2,0,s1,s2) !initial direction set as down, so no restrictions
!path count is incremented by 1 if u=1 is returned by path-finder function
      if(sum.GT.0) then
	printer=1
      exit
      endif
   end do
end function count_paths

recursive function path_finder (r ,c,matrix2,dir,s1,s2) result(u) !u is being returned
implicit none
	integer:: r,c,u,matrix2(s1,s2),r1,c1,dir,s1,s2
	u=0
	
	!Reset u for the next iteration
   if (r.LE.s1 .AND. c.LE.s2 .AND. matrix2(r,c).EQ.1 .AND. r.GE.1 .AND. c.GE.1 ) then	
!check if row,coloumn in bounds and whether cell contains ‘1’
	if(r.EQ.s1) then
	u=1 !u = 1 if we’ve reached the last row
	else 
	
	
!following the path of occupied sites downwards and laterally
	if(dir.EQ.-1)Then
	u=path_finder(r,c-1,matrix2,-1,s1,s2)+path_finder(r+1,c,matrix2,0,s1,s2)
	endif
	if(dir.EQ.1)then
	u=path_finder(r,c+1,matrix2,1,s1,s2)+path_finder(r+1,c,matrix2,0,s1,s2)
	endif
	if(dir.EQ.0)then
	u=path_finder(r,c-1,matrix2,-1,s1,s2)+path_finder(r+1,c,matrix2,0,s1,s2)+path_finder(r,c+1,matrix2,1,s1,s2)
	endif
	
	
	end if
   end if
end function path_finder


program path
integer, dimension (:,:), allocatable :: darray   
!dimension is 2, but size is determined at runtime   

integer :: s1,s2,i,j,key,getkey,m=0,count_paths
real::inp1, inp2,x
inp1=1-inp2
print*, "Enter the dimensions of the array:"     
read*, s1 
s2=s1
allocate ( darray(s1,s1) )
! dynamically allocate the array    
print*, "Enter the step size (0-1):"  
read*, x
print*, "Enter number of iterations(for averaging) :"  
read*, av
cprob=0
OPEN(UNIT=1,FILE="data1.txt",position='append',FORM="FORMATTED",STATUS="OLD")  !open textfile
write(1,*)"Step size : ",x," Array size : ",s1
write(1,*)"------------------------------------"
close(1)
do g=1,av,1
do inp2=0.00,1.00,x

inp1=1-inp2



do i = 1, s1           
	do j = 1, s2
		m=m+50
		key=getkey(inp1,inp2,m)
		
		!print *, key
		if (key .EQ. 0) then
			darray(i,j)=0 !set array elements
			end if
		if (key .EQ. 1) then
			darray(i,j)=1  !set array elements
		end if
END DO
END DO


p=count_paths(darray,s1,s2)	!calling the function to count paths
!print*, p

if(p.EQ.1)then
cprob=cprob+inp2
OPEN(UNIT=1,FILE="data1.txt",position='append',FORM="FORMATTED",STATUS="OLD")  !open textfile
write(1,*)" ",inp2
!print*, "p is 1"
exit
endif
end do
end do
cprob=cprob/av
OPEN(UNIT=1,FILE="data1.txt",position='append',FORM="FORMATTED",STATUS="OLD")  !open textfile
write(1,*)"Critical probability : ",cprob
close(1)

print*, "Data sucessfuly written to data1.txt. Critical probability :  ",cprob

end program path
