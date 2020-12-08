function[no_paths]= percolatefind00(cluster,width,depth)
no_paths=0;
i=1;
    while(i<=width)
        no_paths
        no_paths=no_paths+percolatefind01(1,i,cluster,0,width,depth);
        i=i+1;
        %if no_paths==1
            %break
        %end
    end
end    
