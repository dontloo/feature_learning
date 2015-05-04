% need to be reshaped in order to plot
function [ er, pred, lbl ] = test_cnn_on_one_img(cnn,data_file_name,lbl_file_name,para,U,S,avg,epsilon)
    im = im2double(imread(data_file_name, 'PNG'));
    % color space here
    if strcmp(para.color_space,'grayscale')
        d = rgb2gray(im);
    elseif strcmp(para.color_space,'hsv')
        d = rgb2hsv(im);
    elseif strcmp(para.color_space,'lab')
        d = rgb2lab(im)/100;
    else
        d = im;
    end
    classes = [0,128,255];

%     pred = pred_all (cnn,para,d,U,S,avg,epsilon);
%     pred = slice_and_pred_pxl(cnn,para,d,U,S,avg,epsilon);
    pred = pred_superpxl(cnn,para,im,d,U,S,avg,epsilon);

%     figure, imshow(im);
%     figure, imshow(mat2gray(pred, [1 3]));
    imwrite(mat2gray(pred, [1 3]),['/home/dontloo/Desktop/re/res/24.32_' data_file_name(end-24:end)]);
    pred = classes(pred);  
    lbl = imread(lbl_file_name, 'PGM');
    lbl = crop_im(lbl, para.img_m, para.img_n, floor(para.win_m/2), floor(para.win_n/2));
    bad = find(pred ~= lbl);
    er = numel(bad) / numel(lbl);
end

function [pred] = pred_superpxl(cnn,para,im,d,U,S,avg,epsilon)
    
    pred = zeros(para.img_m-para.win_m+1, para.img_n-para.win_n+1);
    
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);

    tmp = crop_im(im, para.img_m, para.img_n, m_ofst, n_ofst);
%     [centroids,res_im,no_clusters] = superpix_centroids_GBS(tmp, 6, 64);
%     [centroids,res_im,no_clusters] = superpix_centroids_VLSLIC(tmp, 16, 1200);
    [centroids,res_im,no_clusters] = superpix_centroids_SLIC(tmp, 320, 160);
    ofst_centroids(1,:)=centroids(1,:)+m_ofst-1;
    ofst_centroids(2,:)=centroids(2,:)+n_ofst-1;

    wins = zeros(para.win_m,para.win_n,para.no_chnl,no_clusters);
    for idx = 1:no_clusters
        wins(:,:,:,idx) = get_window(d,ofst_centroids(1,idx),ofst_centroids(2,idx),m_ofst,n_ofst);        
    end
    wins = pre_pro(wins,U,S,avg,epsilon,para);
    centroid_pred = my_cnntest(cnn, wins);
    for idx = 1:no_clusters
        pred(res_im==centroids(3,idx)) = centroid_pred(idx);
    end    
    figure, imshow(mat2gray(pred, [1 3]));
    figure, imshow(tmp);
    
%     %mrf denoise
%     denoised_pred = superpix_mrf_denoise(centroid_pred,res_im,no_clusters,1,10);
%     for idx = 1:no_clusters
%         pred(res_im==centroids(3,idx)) = denoised_pred(idx);
%     end   
%     figure, imshow(mat2gray(pred, [1 3]));
    
end

function [pred] = slice_and_pred_pxl(cnn,para,im,U,S,avg,epsilon)
    pred = zeros(para.img_m-para.win_m+1, para.img_n-para.win_n+1);

    for m_idx=1:para.img_m-para.win_m+1
        disp(m_idx);
        wins = zeros(para.win_m,para.win_n,para.no_chnl,para.img_n-para.win_n+1);
        for n_idx=1:para.img_n-para.win_n+1
            wins(:,:,:,n_idx) = im(m_idx:m_idx+para.win_m-1,n_idx:n_idx+para.win_n-1,:);
        end
        wins = pre_pro(wins,U,S,avg,epsilon,para);
        pred(m_idx,:) = my_cnntest(cnn, wins);
    end
end

function [pred] = pred_all(cnn,para,im,U,S,avg,epsilon)
   
    wins = zeros(para.win_m,para.win_n,para.no_chnl,(para.img_n-para.win_n+1)*(para.img_m-para.win_m+1));
    
    for m_idx=1:para.img_m-para.win_m+1
        for n_idx=1:para.img_n-para.win_n+1
            wins(:,:,:,(m_idx-1)*(para.img_n-para.win_n+1)+n_idx) = im(m_idx:m_idx+para.win_m-1,n_idx:n_idx+para.win_n-1,:);
        end
    end
    
    wins = pre_pro(wins,U,S,avg,epsilon,para);
    pred = my_cnntest(cnn, wins);
end