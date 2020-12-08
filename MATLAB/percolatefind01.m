function[path_out]= percolatefind01(r,c,cluster,dir,width,depth)
path_out=0;


if (r<=width) &&  (c<=depth) && (cluster(r,c)==1) && (r>=1) && (c>=1) 
cluster(r,c)
    if(r==width)
        path_out=1;
    end
if(r~=width)  
         if(dir==-1)&& (c>=1) && (cluster(r,c)==1)
if(c==1)
 path_out=percolatefind01(r+1,c,cluster,0,width,depth);
end
         if(c~=1)
            path_out=percolatefind01(r,c-1,cluster,-1,width,depth)+percolatefind01(r+1,c,cluster,0,width,depth);
         end
       
         end

        if(dir==1)&& (c>=1) && (cluster(r,c)==1)
if(c==1)
 path_out=percolatefind01(r+1,c,cluster,0,width,depth)+percolatefind01(r,c+1,cluster,1,width,depth);
end
if(c~=1)
            path_out=percolatefind01(r,c+1,cluster,1,width,depth)+percolatefind01(r+1,c,cluster,0,width,depth);
end

        end 



if(dir==0)&& (c>=1) && (cluster(r,c)==1)
if(c~=1)
path_out=percolatefind01(r,c-1,cluster,-1,width,depth)+percolatefind01(r+1,c,cluster,0,width,depth)+percolatefind01(r,c+1,cluster,1,width,depth);
end
if(c==1)
path_out=percolatefind01(r+1,c,cluster,0,width,depth)+percolatefind01(r,c+1,cluster,1,width,depth);
end       
end
        
end
end
