function [pixel] = get_mid(window,m_ofst,n_ofst)
    pixel = window(m_ofst-1,n_ofst-1,:,:);
end