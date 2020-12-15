function[spanflag]= spancheck3d(Cluster_Label_3D,i,j,k)

spanflag=0;

for n=1:1:i
for o=1:1:j
if(Cluster_Label_3D(n,o,1)==Cluster_Label_3D(n,o,k)&&Cluster_Label_3D(n,o,1)>0)
spanflag=1;
break

end
end 
end
end