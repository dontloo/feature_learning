function [cae] = cae_bp_down(cae, x, para)
    % o = sigmoid(y'), y' = sigma(maxpool(sigmoid(h'))*W~)+c, h' = W*x+b
    % y', h' are pre-activation terms
    cae.err = (cae.o-x);
    cae.loss = 1/2 * sum(cae.err(:) .^2 )/para.bsze;

    % dloss/dy' = (y-x)(y(1-y))
    cae.dy = cae.err.*(cae.o.*(1-cae.o))/para.bsze;
    % dloss/dc = sigma(dy')
    cae.dc = reshape(sum(sum(cae.dy)),[size(cae.c) para.bsze]);
    % dloss/dmaxpool(sigmoid(h')) = sigma(dy'*W)
    cae.dh = zeros(size(cae.h));
    for pt = 1:para.bsze
        for oc = 1:cae.oc
            for ic = 1:cae.ic
                cae.dh(:,:,oc,pt) = cae.dh(:,:,oc,pt)+conv2(cae.dy(:,:,ic,pt),cae.w(:,:,ic,oc),'valid');
            end                   
        end        
    end    
end
