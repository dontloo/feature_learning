function cae = cae_resize_pool(cae, para)
    if cae.ps>=2
        cae.h_repl = zeros(size(cae.h));        
        cae.h_mask = zeros(size(cae.h));
        for i = 1:para.pgrds
            for j = 1:para.pgrds
                tmp = repmat(cae.h_pool(i,j,:,:),cae.ps,cae.ps);
                cae.h_repl((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:) = tmp;
                mask = (cae.h((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:)==tmp);
                cae.h_mask((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:) = mask./repmat(sum(sum(mask)),cae.ps,cae.ps);
            end
        end
    else
        cae.h_repl = cae.h; 
    end
end