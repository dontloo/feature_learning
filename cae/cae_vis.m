function cae_vis(cae)
    tmp = zeros(cae.ks*cae.ic,cae.ks*cae.oc);
    for ic = 1:cae.ic
        for oc = 1:cae.oc
            tmp(cae.ks*(ic-1)+1:cae.ks*ic,cae.ks*(oc-1)+1:cae.ks*oc) = cae.w(:,:,ic,oc);
        end
    end
    imshow(imresize(tmp,10,'nearest'));
end