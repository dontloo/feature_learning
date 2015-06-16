function [cae] = cae_bp_up(cae, x, para)
    if cae.ps>=2        
        % dmaxpool(sigmoid(h'))/dsigmoid(h')
        % non-max terms are zero, if duplicate max values, normalize equally. 
        % resize
        cae.dh_pool = zeros(size(cae.h_pool));
        for i = 1:para.pgrds
            for j = 1:para.pgrds      
                cae.dh_pool(i,j,:,:) = sum(sum(cae.dh((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:)));
            end
        end
    end
    if cae.ps>=2 
        % max
        for i = 1:para.pgrds
            for j = 1:para.pgrds      
                cae.dh((i-1)*cae.ps+1:i*cae.ps,(j-1)*cae.ps+1:j*cae.ps,:,:) = repmat(cae.dh_pool(i,j,:,:),cae.ps,cae.ps);
            end
        end
        cae.dh = cae.dh.*cae.h_mask;
    end
    % dsigmoid(h')/dh'
    cae.dh = cae.dh.*(cae.h.*(1-cae.h)); 
    % dloss/db = sigma(dh')
    cae.db = reshape(sum(sum(cae.dh)),[size(cae.b) para.bsze]);
    % dloss/dw = x~*dh'+dy'~*h
    cae.dw = zeros([size(cae.w) para.bsze]);
    cae.dy_tilde = flip(flip(cae.dy,1),2);
    x_tilde = flip(flip(x,1),2);
    for pt = 1:para.bsze
        for oc = 1:cae.oc
            for ic = 1:cae.ic                
                % x~*dh+dy~*h, perfect                
                cae.dw(:,:,ic,oc,pt) = conv2(x_tilde(:,:,ic,pt),cae.dh(:,:,oc,pt),'valid')+conv2(cae.dy_tilde(:,:,ic,pt),cae.h_repl(:,:,oc,pt),'valid');
            end
        end        
    end    
    
    cae.dc = sum(cae.dc,3);
    cae.db = sum(cae.db,3);
    cae.dw = sum(cae.dw,5);    
end