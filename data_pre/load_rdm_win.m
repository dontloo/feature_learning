% [ground, vertical, sky]
% position of windows and labels need to be checked carefully
function [wins] = load_rdm_win(data_file_names,arg_start,arg_end,para,win_im)
    n_im = arg_end-arg_start+1;
    
    wins = zeros(para.win_m,para.win_n,para.no_chnl,win_im*n_im);
    
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);
    
    % process one image per iteration in case of running out of memory
    for idx = 1:arg_end-arg_start+1
        disp(idx);
        data_file_name = data_file_names{arg_start+idx-1};
        
        % color space here
        d = im2double(imread(data_file_name));
        if strcmp(para.color_space,'gray')
            d = rgb2gray(d);
        elseif strcmp(para.color_space,'hsv')
            d = rgb2hsv(d);
        elseif strcmp(para.color_space,'lab')
            d = rgb2lab(d)/100;
        end
        
        [x] = window_slice_rdm(d,para,win_im,m_ofst,n_ofst,para.no_chnl);
        wins(:,:,:,(idx-1)*win_im+1:idx*win_im) = x;
    end
end

function [wins] = window_slice_rdm(data,para,win_im,m_ofst,n_ofst,no_chnls)
    wins = zeros(para.win_m,para.win_n,no_chnls,win_im);
    for idx = 1:win_im
        m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
        n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
        wins(:,:,:,idx) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
    end
end