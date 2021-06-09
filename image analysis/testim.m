%#ok<*NOPTS>
%------------------------------------------------------------------------
                           %USEFUL VARIABLE NAMES
%------------------------------------------------------------------------
%I -> image that is to be processed
%I2 -> the second image (for finding average threshold)
%num -> number of clusters
%lvl -> average threshold for both images
%Iclean -> binary matrix of I
%occupied -> number of occupied sites
%count_array -> number of elements in each cluster (size of clusters)
%imhei,imwdh -> pixel dimensions of the input image
%sorted_cords -> coordinates of elements sorted according to cluster label
%adjusted_coc -> rounded off coordinates of center of clusters
%red,green,blue -> 0-255 values to find colour corresponding to threshold
%Cluster_Label_Im -> binary matrix after labelling
%center_of_clusters -> coordinates of center of each cluster
%dist_bw_centers(M,N,adjusted_coc)-> distance b/w centers of clusters M,N
%min_distance_bw_clusters(M,N,sorted_cords,count_array)-> min. distance b/w clusters M,N
%------------------------------------------------------------------------

clear vars;

%--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!
                        % NEED TO ADJUST BELOW LINES BEFORE RUNNING
%--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!---!--!--!--!--!--!--!--!--!--!--!--!--!

%SELECT ONE OF THE 2 LINES BELOW,(IMAGE TO BE PROCESSED)
I = imread('pure00.jpg');
%I = imread('annealed00.jpg');


%SELECT ANNEALED/PURE ACCORDING TO WHAT YOU SELECTED ABOVE
imwdh = 512; imhei = 510; %pure
%imwdh = 530; imhei = 511; %annealed


%SELECT I2 AS THE ONE YOU DID NOT SELECT ABOVE
%I2 = imread('pure00.jpg');
I2 = imread('annealed00.jpg');

%--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!---!--!--!--!--!--!--!--!--!--!--!--!--!





%-----------------------------------------------------------------------------------------------------
% NOTE: UNCOMMENT LINE 104 IF YOU WANT TO SEE THE BINARY IMAGE AS OUTPUT (slower run-time)
%-----------------------------------------------------------------------------------------------------






%____________________________________________________________________________________________________%
                                %FINDING THE THRESHOLD WITH GREYTHRESH
%----------------------------------------------------------------------------------------------------%
%Below code is for finding the average threshold 'lvl' for both images
redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);
RL= graythresh(redChannel);
GL= graythresh(greenChannel);
BL= graythresh(blueChannel);
redChannel2 = I2(:, :, 1);
greenChannel2 = I2(:, :, 2);
blueChannel2 = I2(:, :, 3);
RL2= graythresh(redChannel2);
GL2= graythresh(greenChannel2);
BL2= graythresh(blueChannel2);

lvl=(RL*RL + BL*BL + GL*GL)/(RL+GL+BL); %Weighted average of RGB layers for first image
lvl2=(RL2*RL2 + BL2*BL2 + GL2*GL2)/(RL2+GL2+BL2); %Weighted average of RGB layers for second image


lvl=(lvl+lvl2)/2; %Average threshold for both images
thresh_lvl=lvl

%____________________________________________________________________________________________________%
                                %FINDING THE THRESHOLD 'COLOUR'
%----------------------------------------------------------------------------------------------------%
%This is converting layer thresholds into 0-255 values
R1=255*RL;
G1=255*GL;
B1=255*BL;
R2=255*RL2;
G2=255*GL2;
B2=255*BL2;

%Everething below this shade of rgb is black in both images
red=round((R1+R2)/2);
green=round((G1+G2)/2);
blue=round((B1+B2)/2);

RGB_thresh=[red,green,blue]

%____________________________________________________________________________________________________%
                            %BINARY IMAGE OBTAINED AS PER THRESHOLD 'lvl'
%----------------------------------------------------------------------------------------------------%
%binary image obtained
Iclean = im2bw(I,lvl);
%imshow(Iclean);
%____________________________________________________________________________________________________%



%____________________________________________________________________________________________________%
                                %FINDING THE SITE OCCUPATION PROBABILITY
%----------------------------------------------------------------------------------------------------%

%To find SOP
occupied=0;
for x=1:1:imhei
for y=1:1:imwdh
if(Iclean(x,y)==1)
occupied=occupied+1;
end
end
end
sop=occupied/(imhei*imwdh)
%____________________________________________________________________________________________________%




%____________________________________________________________________________________________________%
                                        %LABELLING THE CLUSTER
%----------------------------------------------------------------------------------------------------%

%cluster labelling
[Cluster_Label_Im,num] = bwlabel(Iclean,4);
%____________________________________________________________________________________________________%




%____________________________________________________________________________________________________%
            %FINDING X,Y CO-ORDINATES OF ALL CLUSTER ELEMENTS(SORTED BY CLUSTER NAME)
%----------------------------------------------------------------------------------------------------%

fileId = fopen('cord_out.txt', 'w'); %WILL CONTAIN COORDINATES OF ALL CLUSTER ELEMENTS
for x=1:1:imhei
for y=1:1:imwdh
k=Cluster_Label_Im(x,y);
if(k~=0)
fprintf(fileId, '%d %d %d\n', k,x,y);
end
end
end
fclose(fileId);

%SORTING BY CLUSTER NUMBER/LABEL BELOW
cords = readmatrix('cord_out.txt');
sorted_cords = sortrows(cords,1); %<<- sorted_cords contains (cluster_label, x, y) values, open to see
fileId1 = fopen('sorted_cords.txt', 'w');
writematrix(sorted_cords,'sorted_cords.txt')
%____________________________________________________________________________________________________%




%____________________________________________________________________________________________________%
               %FINDING THE CENTER OF EACH CLUSTER AND THE SIZE OF EACH CLUSTER
%----------------------------------------------------------------------------------------------------%

count_array=zeros(num); %<<- will contain size of all clusters
%Finding center of each cluster and size of each cluster below
CC=0;
i=1;
x=1;
y=1;
count=1;
loopvar=1;
i=1;
av=0;
sumx=0;
sumy=0;
fileId4 = fopen('xd_out.txt', 'w');
fileId5 = fopen('yd_out.txt', 'w');
fileId6 = fopen('mdst_clstrs_out.txt', 'w');
while(count<occupied)

if(sorted_cords(loopvar,1)==i&& i<occupied)
av=av+1;
sumx=sumx+sorted_cords(loopvar,2);
sumy=sumy+sorted_cords(loopvar,3);
loopvar=loopvar+1;
CC=CC+1;
end
if(sorted_cords(loopvar,1)~=i&& i<occupied) 
fprintf(fileId4, '%d\n', sumx/av);
fprintf(fileId5, '%d\n', sumy/av);
sumx=0;
sumy=0;
av=0;
i=i+1;
count_array(i)=CC; %<<- size of each cluster array, (dont take the first zero value...offset by +1, open the array to see what I mean)
CC=0;
end
count=count+1;
end

%Coordinates of center of all clusters present in center_of_clusters
a=dlmread('xd_out.txt');
b=dlmread('yd_out.txt');
center_of_clusters=[a,b];
adjusted_coc=round(center_of_clusters); 
%____________________________________________________________________________________________________%




%____________________________________________________________________________________________________%
  %FINDING SIGNIFICANT CLUSTERS BY EXCLUDING CLUSTERS WITH SIZE LESS THAN THE AVERAGE CLUSTER SIZE
%----------------------------------------------------------------------------------------------------%

%List of clusters with more than average cluster size 
%i.e, significant clusters are listed inside sig_clusters
sig_clusters=zeros(num);
av_clstr_size=round(mean(count_array(:,1)));
j=1;
for i=1:1:num
if(count_array(i,1)>av_clstr_size)
sig_clusters(j)=i; 
j=j+1;
end
end
%____________________________________________________________________________________________________%




%____________________________________________________________________________________________________%
                                    %SOME USEFUL FUNCTIONS
%----------------------------------------------------------------------------------------------------%
M=2408;
N=272;

%____________________________________________________________________________________________________%
% BELOW LIES THE THE FUNCTION THAT FINDS MIN DISTANCE BETWEEN 2 CLUSTERS M,N 
%----------------------------------------------------------------------------------------------------%
[min_dist,cl1_xy,cl2_xy] = min_distance_bw_clusters(M,N,sorted_cords,count_array);

min_dist %->> MINIMUM DISTANCE

%____________________________________________________________________________________________________%
% BELOW LIES THE THE FUNCTION THAT FINDS DISTANCE BW CENTERS OF CLUSTERS M,N
%----------------------------------------------------------------------------------------------------%
ctr_dist = dist_bw_centers(M,N,adjusted_coc);

ctr_dist %->> DISTANCE B/W CENTERS


%____________________________________________:p______________________________________________________%


    