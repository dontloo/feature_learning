function [cae] = cae_update(cae, opts)
    cae.b = cae.b - opts.alpha*cae.db;
    cae.c = cae.c - opts.alpha*cae.dc;
    cae.w = cae.w - opts.alpha*cae.dw;
    cae.w_tilde = flip(flip(cae.w,1),2);
end