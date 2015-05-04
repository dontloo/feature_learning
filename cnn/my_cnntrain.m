function net = my_cnntrain(net, argx, y, opts)
    % added
    [s1,s2,s3,s4] = size(argx);
    x = zeros(s1,s2,s4,s3);
    for channel_idx = 1:s3
        x(:,:,:,channel_idx) = reshape(argx(:,:,channel_idx,:),s1,s2,s4);
    end
    % added
    
    m = size(x, 3);
    numbatches = m / opts.batchsize;
    if rem(numbatches, 1) ~= 0
        error('numbatches not integer');
    end
    net.rL = [];
    net.err = [];
    for i = 1 : opts.numepochs
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);
        tic;
        kk = randperm(m);
        for l = 1 : numbatches
%             batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize), :);
            batch_y = y(:,    kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));

            net = my_cnnff(net, batch_x);
            net = cnnbp(net, batch_y);
            net = cnnapplygrads(net, opts);
            if isempty(net.rL)
                net.rL(1) = net.L;
            end
            net.rL(end + 1) = 0.99 * net.rL(end) + 0.01 * net.L;
            net.err(end + 1) = err_rate( net.o, batch_y );
        end
        toc;
    end
    
end


