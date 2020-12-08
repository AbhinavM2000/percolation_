clear all
width=4; % array size
depth=4; % array size
cluster=rand(width,depth);  % 
p=1;
cluster=cluster<p;

% for m=1:1:width
%     for n=1:1:depth
%         if rand<p
%         cluster(m,n)=1;
%         elseif rand>p
%         cluster(m,n)=0;
%         end
%     end
% end
cluster
width
depth
%finalpath=countpaths00(cluster,width,depth)
percolate=percolatefind00(cluster,width,depth)
cluster
%[Cluster_Label,num] = bwlabel(cluster,4) % Cluster_Label will be a cluster labelled matrix, num gives number of clusters