function my_visualize(X,m,n,chnl,no_hid)
    X = reshape(X,m,n,chnl,no_hid);
    mm = [min(X(:)) max(X(:))];
    no_sq = sqrt(no_hid);
    suqares = zeros(m*no_sq,n*no_sq,chnl);
    for i=1:no_sq
        for j=1:no_sq
            suqares((i-1)*m+1:i*m,(j-1)*n+1:j*n,:) = X(:,:,:,(i-1)*no_sq+j);
        end
    end
    imagesc(suqares, [mm(1) mm(2)]);
end

