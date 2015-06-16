function [scae] = scae_train(scae, x, opts)
    
    [x,para] = cae_check(scae,x,opts);
    scae.L = zeros(opts.numepochs*para.bnum,1);
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
            scae = scae_ffbp(scae, batch_x, para);
%             [numdw,numdb,numdc] = cae_check_grad(cae, batch_x, para); % correct for multi channel input data
            scae = scae_update(scae, opts); % w w_tilde            
            scae.L((i-1)*para.bnum+j)=scae.loss;            
        end
        disp(mean(scae.L((i-1)*para.bnum+1:i*para.bnum)));
        toc;
    end    
end

function [scae] = scae_ffbp(scae, x, para)
    tmp = x;
    for layer=1:numel(scae)
        cae = scae{layer};
        x_noise = tmp.*(rand(size(tmp))>=cae.noise);
        cae = cae_up(cae, x_noise, para);
        cae = cae_pool(cae, para);
        tmp = cae.h_pool;
    end
    for layer=numel(scae):1
        cae = scae{layer};
        cae = cae_resize_pool(cae, para);
        cae = cae_down(cae, para);
        tmp = cae.o;
    end
    for layer=1:numel(scae)
        cae = cae_bp_up(cae, tmp, para);
    end
    for layer=numel(scae):1
        cae = cae_bp_down(cae, tmp, para);
    end           
end