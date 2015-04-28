function [centroids,labels,numlabels] = superpix_centroids_SLIC(img, num_pixels, regularizer)  
    [labels, numlabels] = slicmex(img,num_pixels,regularizer);
    
%     [sx,sy]=vl_grad(double(labels), 'type', 'forward') ;
%     s = find(sx | sy) ;
%     imp = img;
%     imp([s s+numel(img(:,:,1)) s+2*numel(img(:,:,1))]) = 0 ;
%     figure, imagesc(imp) ; axis image off ; hold on ;
    
    labels = labels+1;
    centroids = zeros(3,numlabels);
    for idx=1:numlabels
        [row,col] = find(labels==idx);
        centroids(:,idx) = [mean(row) mean(col) idx];     
    end    
    centroids = round(centroids);
end