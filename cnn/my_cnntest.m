function [h] = my_cnntest(net, x, no_chnls)
    net = my_cnnff(net, x, no_chnls);
    [~, h] = max(net.o);
end
