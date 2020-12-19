function[spanflag]= spancheck2d(Cluster_Label,i,j)

spanflag=0;
for n=1:1:i
    for k=1:1:j
        if(Cluster_Label(1,n)>0 && Cluster_Label(1,n)==Cluster_Label(i,k))
            spanflag=1;
            break   
        end
    end
end