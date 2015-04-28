function [wins] = win_slice_rdm(data,para,win_im)
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);
    wins = zeros(para.win_m,para.win_n,para.no_chnl,win_im,'uint8');
    for idx = 1:win_im
        m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
        n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
        wins(:,:,:,idx) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
    end
end
