function [pixel] = get_mid(arg_window,m_ofst,n_ofst)
    pixel = arg_window(m_ofst-1,n_ofst-1,:,:);
end