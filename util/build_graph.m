function [graph] = build_graph(res_im, no_clusters)
    graph = zeros(no_clusters, no_clusters);
    [m,n] = size(res_im);
    for x = 2:m-1
        for y = 2:n-1
            node = res_im(x,y);
            neighbours = unique_neighbours(x,y,res_im);
            if size(neighbours)>0
                graph(node,neighbours) = 1;
                graph(neighbours,node) = 1;
            end
        end
    end
end

function [neighbours] = unique_neighbours(x,y,res_im)
    neighbours = zeros(1,4);
    neighbours(1) = res_im(x-1,y);
    neighbours(2) = res_im(x+1,y);
    neighbours(3) = res_im(x,y-1);
    neighbours(4) = res_im(x,y+1);
    neighbours = unique(neighbours);
    neighbours = neighbours(neighbours~=res_im(x,y));
end
