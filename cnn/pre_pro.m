function [x] = pre_pro(x,U,S,avg,epsilon,para)
    x = reshape(x,para.win_m*para.win_n,size(x,3));
    x = x - repmat(avg, 1, size(x, 2));    
    x = U * diag(1./sqrt(diag(S) + epsilon)) * U' * x;
    x = reshape(x,para.win_m,para.win_n,size(x,2));
end