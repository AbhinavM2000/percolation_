NUM_RUNS = 11; %number of runs
SIZE = 10; %size of the matrix
data = zeros(3, NUM_RUNS);
for i=1:NUM_RUNS
    [p_c, num_clusters] = pc_HK_spanning_clstr(SIZE);
    data(1, i) = uint32(i);
    data(2, i) = p_c;
    data(3, i) = uint32(num_clusters);
end
filename = strcat(int2str(NUM_RUNS), '.txt');
fileId = fopen(filename, 'w');
fprintf(fileId, '%d %f %d\n', data);