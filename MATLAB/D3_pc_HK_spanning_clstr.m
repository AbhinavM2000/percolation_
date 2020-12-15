p=0;
i=5;
j=5;
k=5;
cluster3D=rand(i,j,k); 

chk_span_3D=0;
while(chk_span_3D==0) 
p=p+0.01;
cluster3D=rand(i,j,k); 
cluster3D=cluster3D<p; % site occupied as per p
[Cluster_Label_3D,num] = bwlabeln(cluster3D,6); % Cluster_Label will be a cluster labelled matrix, num gives number of clusters
chk_span_3D=spancheck3d(Cluster_Label_3D,i,j,k);
end
p
