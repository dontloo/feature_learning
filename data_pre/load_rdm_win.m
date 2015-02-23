% [ground, vertical, sky]
% position of windows and labels need to be checked carefully
function [wins,win_lbls] = load_rdm_win(no_chnls,data_file_names,lbl_files_names,arg_start,arg_end,para,win_im)
    n_im = arg_end-arg_start+1;
    
    wins = zeros(para.win_m,para.win_n,no_chnls,win_im*n_im,'uint8');
    win_lbls = zeros(3,win_im*n_im,'uint8');
    calsses = [0,128,255];
    
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);
    
    % process one image per iteration in case of running out of memory
    for idx = 1:arg_end-arg_start+1
        disp(idx);
        data_file_name = data_file_names{arg_start+idx-1};
        lbl_file_name = lbl_files_names{arg_start+idx-1};
        
        % rgb here
        d = imread(data_file_name, 'PNG');
        if no_chnls==1
            d = rgb2gray(d);
        end
        l = imread(lbl_file_name, 'PGM');
        
        [x,y] = window_slice_rdm_blnc(d,l,para,win_im,calsses,m_ofst,n_ofst,no_chnls);
        wins(:,:,:,(idx-1)*win_im+1:idx*win_im) = x;
        win_lbls(:,(idx-1)*win_im+1:idx*win_im) = y;
    end
end

function [wins,win_lbls] = window_slice_rdm_blnc(data,label,para,win_im,calsses,m_ofst,n_ofst,no_chnls)
    wins = zeros(para.win_m,para.win_n,no_chnls,win_im,'uint8');
    win_lbls = zeros(3,win_im,'uint8');
    for idx = 1:win_im
        m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
        n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
        y = calsses==label(m_idx,n_idx);
        wins(:,:,:,idx) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
        win_lbls(:,idx) = y;
    end
end