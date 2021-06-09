function [ctr_dist] = dist_bw_centers(cl1_lb,cl2_lb,adjusted_coc)

cl_1_xy(1,1)=adjusted_coc(cl1_lb, 1);
cl_1_xy(1,2)=adjusted_coc(cl1_lb, 2);

cl_2_xy(1,1)=adjusted_coc(cl2_lb, 1);
cl_2_xy(1,2)=adjusted_coc(cl2_lb, 2);

ctr_dist = pdist2(cl_1_xy,cl_2_xy);
end