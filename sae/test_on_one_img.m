function [er, pred, lbl] = test_on_one_img(func,para,data_file_name,lbl_file_name)
    im = imread(data_file_name, 'PNG');
    % rgb here
    if para.no_chnl==1
        im = rgb2gray(im);
    end
    classes = [0,128,255];
    lbl = imread(lbl_file_name, 'PGM');
    lbl = crop_im(lbl, para.img_m, para.img_n, floor(para.win_m/2), floor(para.win_n/2));
    pred = slice_and_pred_pxl(func,para,im);
    imshow(mat2gray(pred, [1 3]));
    pred = classes(pred);    
    bad = find(pred ~= lbl);
    er = numel(bad) / numel(lbl);
end

function [pred] = slice_and_pred_pxl(func,para,im)
    pred = zeros(para.img_m-para.win_m+1, para.img_n-para.win_n+1);
    dim = para.win_m*para.win_n*para.no_chnl;
    for m_idx=1:para.img_m-para.win_m+1
        disp(m_idx);
        wins = zeros(para.win_m,para.win_n,para.no_chnl,para.img_m-para.win_m);
        for n_idx=1:para.img_n-para.win_n+1
            wins(:,:,:,n_idx) = im(m_idx:m_idx+para.win_m-1,n_idx:n_idx+para.win_n-1,:);
        end        
        wins = (double(reshape(wins,dim,[]))/255)';
        pred(m_idx,:) = func(wins);
    end
end