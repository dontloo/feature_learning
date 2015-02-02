function [er_tr] = err_rate( pred, lab )
%NUM_ERRS Summary of this function goes here
%   Detailed explanation goes here
    [~, h] = max(pred);
    [~, a] = max(lab);
    bad = find(h ~= a);
    er_tr = numel(bad)/size(lab, 2);
end

