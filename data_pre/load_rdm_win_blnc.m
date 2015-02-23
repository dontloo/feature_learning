% [ground, vertical, sky]
% position of windows and labels need to be checked carefully
function [wins,win_lbls] = load_rdm_win_blnc(no_chnls,data_file_names,lbl_files_names,arg_start,arg_end,para,win_im_cl)
    n_im = arg_end-arg_start+1;
    
    wins = zeros(para.win_m,para.win_n,no_chnls,win_im_cl*n_im*3,'uint8');
    win_lbls = zeros(3,win_im_cl*n_im*3,'uint8');
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
        
        [x,y] = window_slice_rdm_blnc(d,l,para,win_im_cl,calsses,m_ofst,n_ofst,no_chnls);
        wins(:,:,:,(idx-1)*win_im_cl*3+1:idx*win_im_cl*3) = x;
        win_lbls(:,(idx-1)*win_im_cl*3+1:idx*win_im_cl*3) = y;
    end
end

function [wins,win_lbls] = window_slice_rdm_blnc(data,label,para,win_im_cl,calsses,m_ofst,n_ofst,no_chnls)
    wins = zeros(para.win_m,para.win_n,no_chnls,win_im_cl*3,'uint8');
    win_lbls = zeros(3,win_im_cl*3,'uint8');
    ctr = [0,0,0];
    while sum(ctr == win_im_cl)~=3
        m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
        n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
        % check
        y = calsses==label(m_idx,n_idx);
        if ismember(win_im_cl+1,y+ctr)
        else
            ctr = ctr + y;
            wins(:,:,:,sum(ctr)) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
            win_lbls(:,sum(ctr)) = y;
        end
    end
end