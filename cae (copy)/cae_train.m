function [cae] = cae_train(cae, x, opts)
    
    [x,para] = cae_check(cae,x,opts);
    cae.L = zeros(opts.numepochs*para.bnum,1);
    for i=1:opts.numepochs
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);
        tic;
        if opts.shuffle==1
            idx = randperm(para.pnum);
        else
            idx = linspace(1,para.pnum,para.pnum);
        end
        for j = 1 : para.bnum
            batch_x = x(:,:,:,idx((j-1)*para.bsze+1:j*para.bsze));            
            cae = cae_ffbp(cae, batch_x, para);
%             [numdw,numdb,numdc] = cae_check_grad(cae, batch_x, para); % correct for multi channel input data
            cae = cae_update(cae, opts); % w w_tilde            
            cae.L((i-1)*para.bnum+j)=cae.loss;            
        end
        disp(mean(cae.L((i-1)*para.bnum+1:i*para.bnum)));
        toc;
    end    
end

function [cae] = cae_ffbp(cae, x, para)
    x_noise = x.*(rand(size(x))>=cae.noise);
    cae = cae_up(cae, x_noise, para);
    cae = cae_pool(cae, para);
    cae = cae_resize_pool(cae, para);
    cae = cae_down(cae, para);
    cae = cae_bp_down(cae, x, para);
    cae = cae_bp_up(cae, x, para);
end

function [numdw,numdb,numdc] = cae_check_grad(cae, x, para)
    epsilon = 1e-5;
    
    numdw = zeros(size(cae.dw));
    numdc = zeros(size(cae.dc));
    numdb = zeros(size(cae.db));
    
    % dc
    for ic = 1:cae.ic
        cae_h = cae;                    
        cae_h.c(ic) = cae_h.c(ic)+epsilon;
        cae_h = cae_ffbp(cae_h,x,para);

        cae_l = cae;
        cae_l.c(ic) = cae_l.c(ic)-epsilon;
        cae_l = cae_ffbp(cae_l,x,para);
        
        numdc(ic) = (cae_h.loss - cae_l.loss) / (2 * epsilon);
    end
    % db
    for oc = 1:cae.oc
        cae_h = cae;                    
        cae_h.b(oc) = cae_h.b(oc)+epsilon;
        cae_h = cae_ffbp(cae_h,x,para);

        cae_l = cae;
        cae_l.b(oc) = cae_l.b(oc)-epsilon;
        cae_l = cae_ffbp(cae_l,x,para);
        
        numdb(oc) = (cae_h.loss - cae_l.loss) / (2 * epsilon);
    end
    % dw
    for ic = 1:cae.ic
        for oc = 1:cae.oc
            for m = 1:cae.ks
                for n = 1:cae.ks
                    cae_h = cae;                            
                    cae_h.w(m,n,ic,oc) = cae_h.w(m,n,ic,oc)+epsilon;
                    cae_h.w_tilde(cae.ks+1-m,cae.ks+1-n,ic,oc) = cae_h.w_tilde(cae.ks+1-m,cae.ks+1-n,ic,oc)+epsilon;                                                     
                    cae_h = cae_ffbp(cae_h,x,para);
                    
                    cae_l = cae;
                    cae_l.w(m,n,ic,oc) = cae_l.w(m,n,ic,oc)-epsilon;
                    cae_l.w_tilde(cae.ks+1-m,cae.ks+1-n,ic,oc) = cae_l.w_tilde(cae.ks+1-m,cae.ks+1-n,ic,oc)-epsilon;    
                    cae_l = cae_ffbp(cae_l,x,para);
                    
                    numdw(m,n,ic,oc) = (cae_h.loss - cae_l.loss) / (2 * epsilon);
                end
            end           
        end
    end
end

function [x,para] = cae_check(cae, x, opts)

    para.m = size(x,1);
    para.pnum = size(x,4); % number of data points
    para.pgrds = (para.m-cae.ks+1)/cae.ps; % pool grids
    para.bsze = opts.batchsize; % batch size
    para.bnum = para.pnum/para.bsze; % number of batches
    
    if size(x,3)~=cae.ic
        error('number of input chanels doesn''t match');
    end
    
    if cae.ks>para.m
        error('too large kernel');
    end
    
    if floor(para.pgrds)~=para.pgrds
        error('sides of hidden representations should be divisible by pool size')
    end
    
    if floor(para.bnum)~=para.bnum
        error('number of data points should be divisible by batch size.');
    end
end