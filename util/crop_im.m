function [ res_im ] = crop_im(im, m, n, m_ofst, n_ofst)
    res_im = im(m_ofst:m-m_ofst,n_ofst:n-n_ofst,:);
end

