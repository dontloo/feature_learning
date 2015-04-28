function [loss] = my_nneval(nn, loss, train_x, train_y, opts)
%NNEVAL evaluates performance of neural network
% Returns a updated loss struct
assert(nargin == 5, 'Wrong number of arguments');

nn.testing = 1;
% training performance
nn                    = batch_nnff(nn, train_x, train_y, opts);
loss.train.e(end + 1) = nn.L;

nn.testing = 0;
%calc misclassification rate if softmax
if strcmp(nn.output,'softmax')
    [er_train, dummy]           = nntest(nn, train_x, train_y);
    loss.train.e_frac(end+1)    = er_train;
end

end
