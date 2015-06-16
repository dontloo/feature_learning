function [cae] = cae_down(cae, para)
    % ks: kernel size, oc: output channels
    cae.o = zeros(para.m,para.m,cae.ic,para.bsze);
    for pt = 1:para.bsze
        for ic = 1:cae.ic
            for oc = 1:cae.oc
                cae.o(:,:,ic,pt) = cae.o(:,:,ic,pt) + conv2(cae.h_repl(:,:,oc,pt),cae.w_tilde(:,:,ic,oc),'full');
            end
            cae.o(:,:,ic,pt) = sigm(cae.o(:,:,ic,pt)+cae.c(ic));
        end        
    end
end