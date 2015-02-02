% [ground, vertical, sky]
% position of windows and labels need to be checked carefully
function [wins,win_lbls] = load_rdm_win_gray_blnc(data_file_names,lbl_files_names,arg_start,arg_end,para,win_im_cl)
    n_im = arg_end-arg_start+1;
    
    wins = zeros(para.win_m,para.win_n,win_im_cl*n_im*3);
    win_lbls = zeros(3,win_im_cl*n_im*3);
    calsses = [0,128,255];
    
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);
    
    % process one image per iteration in case of running out of memory
    for idx = 1:arg_end-arg_start+1
        data_file_name = data_file_names{arg_start+idx-1};
        lbl_file_name = lbl_files_names{arg_start+idx-1};
        
        % rgb here
        d = rgb2gray(imread(data_file_name, 'PNG'));
        l = imread(lbl_file_name, 'PGM');
        
        [x,y] = window_slice_rdm_blnc(d,l,para,win_im_cl,calsses,m_ofst,n_ofst);
        wins(:,:,(idx-1)*win_im_cl*3+1:idx*win_im_cl*3) = x;
        win_lbls(:,(idx-1)*win_im_cl*3+1:idx*win_im_cl*3) = y;
    end
end

function [wins,win_lbls] = window_slice_rdm_blnc(data,label,para,win_im_cl,calsses,m_ofst,n_ofst)
    wins = zeros(para.win_m,para.win_n,win_im_cl*3);
    win_lbls = zeros(3,win_im_cl*3);
    ctr = [0,0,0];
    while sum(ctr == win_im_cl)~=3
        m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
        n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
        % check
        y = calsses==label(m_idx,n_idx);
        if ismember(win_im_cl+1,y+ctr)
        else
            ctr = ctr + y;
            wins(:,:,sum(ctr)) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
            win_lbls(:,sum(ctr)) = y;
        end
    end
       
end

% function [data,label] = load_rdm_win_gray_blnc(data_file_names,lbl_files_names,arg_start,arg_end,para,win_per_im_per_cl)
%     n_im = arg_end-arg_start+1;
% %     rgb = 3;
% %     data = nan(para.img_m,para.img_n,rgb,arg_end-arg_start+1);
%     data = nan(para.img_m,para.img_n,n_im);
%     label = nan(para.img_m,para.img_n,n_im);
%     
%     % process one image per iteration in case of running out of memory
%     for idx = arg_start:arg_end
%         data_file_name = data_file_names{idx};
%         lbl_file_name = lbl_files_names{idx};
%         
%         d = imread(data_file_name, 'PNG');
%         l = imread(lbl_file_name, 'PGM');
%         % rgb here
%         data(:,:,idx-arg_start+1) = rgb2gray(d);
%         label(:,:,idx-arg_start+1) = l;
%     end
%     
%     [data,label] = window_slice_rdm(data,label,para,n_im,win_per_im_per_cl);
% end
% 
% function [wins,win_lbls] = window_slice_rdm(data,label,para,n_im,win_im_cl)
% 
%     wins = zeros(para.win_m,para.win_n,win_im_cl*n_im*3);
%     win_lbls = zeros(3,win_im_cl*n_im*3);
%     calsses = [0,128,255];
%     
%     m_ofst = floor(para.win_m/2);
%     n_ofst = floor(para.win_n/2);
%     
%     for im_idx=1:n_im
%         [x,y] = window_slice_rdm_blnc(data(:,:,im_idx),label(:,:,im_idx),para,win_im_cl,calsses,m_ofst,n_ofst);
%         wins(:,:,(im_idx-1)*win_im_cl*3+1:im_idx*win_im_cl*3) = x;
%         win_lbls(:,(im_idx-1)*win_im_cl*3+1:im_idx*win_im_cl*3) = y;
%     end
% end
% 
% function [wins,win_lbls] = window_slice_rdm_blnc(data,label,para,win_im_cl,calsses,m_ofst,n_ofst)
%     wins = zeros(para.win_m,para.win_n,win_im_cl*3);
%     win_lbls = zeros(3,win_im_cl*3);
%     ctr = [0,0,0];
%     while sum(ctr == win_im_cl)~=3
%         m_idx = randi([m_ofst+1,para.img_m-m_ofst]);
%         n_idx = randi([n_ofst+1,para.img_n-n_ofst]);
%         % check
%         y = calsses==label(m_idx,n_idx);
%         if ismember(win_im_cl+1,y+ctr)
%         else
%             ctr = ctr + y;
%             wins(:,:,sum(ctr)) = get_window(data,m_idx,n_idx,m_ofst,n_ofst);
%             win_lbls(:,sum(ctr)) = y;
%         end
%     end
%        
% end