function [centroids,res_im,no_clusters] = superpix_centroids_VLSLIC(im, regionSize, regularizer)
% run('/home/dontloo/Desktop/re/matlab/vlfeat-0.9.20/toolbox/vl_setup');    
    [res_im, no_clusters] = super_pix(im, regionSize, regularizer);
    centroids = zeros(3,no_clusters);
    for idx=1:no_clusters
        [row,col] = find(res_im==idx);
        centroids(:,idx) = [mean(row) mean(col) idx];
%         centroids(:,idx) = [median(row) median(col) idx];        
    end    
    centroids = round(centroids);
end

function [res_im,no_clusters] = super_pix(im, regionSize, regularizer)
    % IM contains the image in RGB format as before
%     res_im = vl_slic(single(im), regionSize, regularizer);
    imlab = vl_xyz2lab(vl_rgb2xyz(im));
    res_im = vl_slic(single(imlab), regionSize, regularizer);
    [sx,sy]=vl_grad(double(res_im), 'type', 'forward') ;
    s = find(sx | sy) ;
    imp = im ;
    imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
    figure, imagesc(imp) ; axis image off ; hold on ;
    res_im = res_im+1;
    no_clusters = max(res_im(:));
end