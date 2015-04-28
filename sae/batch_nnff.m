function [nn] = batch_nnff( nn, train_x, train_y, opts )
    m = size(train_x, 1);
    batchsize = opts.batchsize;
    numbatches = m/batchsize;
    L = 0;
    a = cell(nn.n);
    a{2} = zeros(m,nn.size(2));

    kk = randperm(m);
	for l = 1 : numbatches
        batch_x = train_x(kk((l - 1) * batchsize + 1 : l * batchsize), :);
        batch_y = train_y(kk((l - 1) * batchsize + 1 : l * batchsize), :);
        nn = nnff(nn, batch_x, batch_y);
        
        a{2}((l - 1) * batchsize + 1 : l * batchsize,:) = nn.a{2}(:,2:end);        
        L = L+nn.L;
	end
    nn.L = L/numbatches;
    nn.a = a;
end

