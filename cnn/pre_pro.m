function [x] = pre_pro(x,U,S,avg,epsilon,para)
    if para.prepro==1
        x = reshape(x,para.win_m*para.win_n*para.no_chnl,size(x,4));
        x = x - repmat(avg, 1, size(x, 2));    
        x = U * diag(1./sqrt(diag(S) + epsilon)) * U' * x;
        x = reshape(x,para.win_m,para.win_n,para.no_chnl,size(x,2));
    end
end