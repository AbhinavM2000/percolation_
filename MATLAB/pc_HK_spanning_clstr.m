%%%==============
%%% simple function for random cluster
%%%===============
function[p_c, num_clusters] = pc_HK_spanning_clstr(size)
    clear vars
    p=0.00;
    i=size; % array size
    j=size; % array size
    %cluster=rand(i,j); %random matrix i*j
    chk_span=0;%true if there is a path
    while(chk_span==0)
        p=p+0.0001;
        cluster=rand(i,j); %random matrix i*j entries unif(0,1)
        cluster=cluster<p; % site occupation probability p
        [Cluster_Label,num] = bwlabel(cluster,4); % Cluster_Label will be a cluster labelled matrix, num gives number of clusters
        chk_span=spancheck2d(Cluster_Label,i,j); %returns true if there is a path
    end
    p_c = p;
    num_clusters = num;
end
