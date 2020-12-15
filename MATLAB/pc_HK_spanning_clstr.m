%%%==============
%%% simple code for random cluster
%%%===============
clear vars
p=0.00;
i=10; % array size
j=10; % array size
cluster=rand(i,j);  
chk_span=0;
while(chk_span==0) 
p=p+0.0001;
cluster=rand(i,j); 
cluster=cluster<p; % site occupied as per p
[Cluster_Label,num] = bwlabel(cluster,4); % Cluster_Label will be a cluster labelled matrix, num gives number of clusters
chk_span=spancheck2d(Cluster_Label,i,j);
end
p