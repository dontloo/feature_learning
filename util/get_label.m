% m_idx,n_idx should be the coordinates of the topleft corner of the window
function [res] = get_label(img_lbl,m_idx,n_idx,m_ofst,n_ofst)
    res = img_lbl(m_idx+m_ofst-1,n_idx+n_ofst-1);
end

