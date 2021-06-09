function [min_dist,cl1_xy,cl2_xy] = min_distance_bw_clusters(cl1_lb,cl2_lb,sorted_cords,count_array)
w=1;
hh=sum(count_array(2:cl1_lb))+1;
if(cl1_lb==1)
hh=1;
end
for i=hh:1:count_array(cl1_lb+1)+sum(count_array(2:cl1_lb))
cl1_xy(w,1)=sorted_cords(i, 2);
cl1_xy(w,2)=sorted_cords(i, 3);
w=w+1;
end
w=1;
gg=sum(count_array(2:cl2_lb))+1;
if(cl2_lb==1)
gg=1;
end
for i=gg:1:count_array(cl2_lb+1)+sum(count_array(2:cl2_lb))
cl2_xy(w,1)=sorted_cords(i, 2);
cl2_xy(w,2)=sorted_cords(i, 3);
w=w+1;
end
min_dist = min(min(pdist2(cl1_xy,cl2_xy)));
end