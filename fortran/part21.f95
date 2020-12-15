function count_paths(matrix2) result(sum) !sum is being returned
implicit none
   integer:: i, path_finder,sum,matrix2(4,4)
   sum=0
   do i = 1,4
      sum = sum+ path_finder(1, i,matrix2,0) !initial direction set as down, so no restrictions
!path count is incremented by 1 if u=1 is returned by path-finder function
   end do
end function count_paths

recursive function path_finder (r ,c,matrix2,dir) result(u) !u is being returned
implicit none
	integer:: r,c,u,matrix2(4,4),r1,c1,dir
	u=0
	
	!Reset u for the next iteration
   if (r.LE.4 .AND. c.LE.4 .AND. matrix2(r,c).EQ.1 .AND. r.GE.1 .AND. c.GE.1 ) then	
!check if row,coloumn in bounds and whether cell contains ‘1’
	if(r.EQ.4) then
	u=1 !u = 1 if we’ve reached the last row
	else 
	
	
!following the path of occupied sites downwards and laterally
	if(dir.EQ.-1)Then
	u=path_finder(r,c-1,matrix2,-1)+path_finder(r+1,c,matrix2,0)
	endif
	if(dir.EQ.1)then
	u=path_finder(r,c+1,matrix2,1)+path_finder(r+1,c,matrix2,0)
	endif
	if(dir.EQ.0)then
	u=path_finder(r,c-1,matrix2,-1)+path_finder(r+1,c,matrix2,0)+path_finder(r,c+1,matrix2,1)
	endif
	
	
	end if
   end if
end function path_finder


program path

implicit none  
integer darray(4,4)  
integer :: i,j,count_paths,p,element
print*,"Enter the 4x4 array "
do i = 1, 4         
	do j = 1, 4
		read*,element
		darray(i,j)=element	!input array 
END DO
END DO
p=count_paths(darray)	!calling the function to count paths
print*,"Number of Paths = ",p
close(1)
PAUSE

end program path
