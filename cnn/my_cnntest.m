function [h, a] = my_cnntest(net, x, y, no_chnls)
    net = my_cnnff(net, x, no_chnls);
    [~, h] = max(net.o);
    [~, a] = max(y);
end
