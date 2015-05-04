function [h] = my_cnntest(net, argx)
    % added
    [s1,s2,s3,s4] = size(argx);
    x = zeros(s1,s2,s4,s3);
    for channel_idx = 1:s3
        x(:,:,:,channel_idx) = reshape(argx(:,:,channel_idx,:),s1,s2,s4);
    end
    % added
    
    net = my_cnnff(net, x);
    [~, h] = max(net.o);
end
