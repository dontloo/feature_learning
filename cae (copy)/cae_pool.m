function cae = cae_pool(cae, para)
    % ps: pool size
    if cae.ps>=2
        cae.h_pool = zeros(size(cae.h)./[cae.ps cae.ps 1 1]);
        for i = 1:para.pgrds
            for j = 1:para.pgrds
                grid = cae.h((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:);
                cae.h_pool(i,j,:,:) = max(max(grid));
%                 mx = repmat(max(max(grid)),cae.ps,cae.ps);
%                 cae.h_repl((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:) = mx;
%                 mask = (grid==mx);
%                 cae.h_mask((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:) = mask./repmat(sum(sum(mask)),cae.ps,cae.ps);
            end
        end        
    end
end