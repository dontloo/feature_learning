function [cae] = cae_up(cae, x, para)
    % ks: kernel size, oc: output channels
    cae.h = zeros(para.m-cae.ks+1,para.m-cae.ks+1,cae.oc,para.bsze);
    for pt = 1:para.bsze
        for oc = 1:cae.oc
            for ic = 1:cae.ic
                cae.h(:,:,oc,pt) = cae.h(:,:,oc,pt) + conv2(x(:,:,ic,pt),cae.w(:,:,ic,oc),'valid');
            end
            cae.h(:,:,oc,pt) = sigm(cae.h(:,:,oc,pt)+cae.b(oc));
        end        
    end
end