function CNN_test
    clear;
%     run('/home/dontloo/Desktop/re/matlab/vlfeat-0.9.20/toolbox/vl_setup');
%     load('/media/662CD4C02CD48D05/_backup/data/train_res/ZCA_train_849_4_232*3*8_RGB_blnc.mat');
    load('/media/662CD4C02CD48D05/_backup/data/train_res/8.12_ZCA_train_849_4_400*3*4_LAB_blnc.mat');
%     load('/media/662CD4C02CD48D05/_backup/data/test_data/test_643_4_456*20_RGB.mat');
    
    % 09_26_0005_0000000000
    % 09_26_0001_0000000000
    % 09_26_0001_0000000045
    % 09_26_0014_0000000180
    % 09_26_0051_0000000190
    % 09_29_0026_0000000110
    % 09_26_0106_0000000205
    % 09_26_0096_0000000160
    % 09_26_0059_0000000250
    im_path = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_cln/09_26_0014_0000000180.png';
    lbl_path = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_lab/lbl_09_26_0014_0000000180.pgm';
    [er, pred, lbl_path] = test_cnn_on_one_img(cnn, im_path, lbl_path,para,U,S,avg,epsilon);
%     [er, pred, lbl] = test_cnn_on_one_img(cnn,data_file_names{1},lbl_file_names{1},para,U,S,avg,epsilon);
    % imshow(mat2gray(pred, [1 3]));
    % imshow(mat2gray(truth, [1 3]));
    % imwrite(mat2gray(pred, [1 3]), '/home/dontloo/Desktop/re/res/4_1_pred.png');

    % can not fit in memory
    % [er, bad] = cnntest(cnn, train_x, train_y);

%     [er,pred,lbl] = batch_test(456, test_x, test_y, cnn,U,S,avg,epsilon,para);
%     my_plot(test_x,pred,lbl_path,para);
    disp(er);

    assert(er<0.12, 'Too big error');
end

function my_plot(test_x,pred,lbl,para)
    sky_idx = pred == 3;
    sky_pts = reshape(get_mid(test_x(:,:,:,sky_idx),floor(para.win_m/2),floor(para.win_m/2)),3,[]);
    figure; scatter3(sky_pts(1,:),sky_pts(2,:),sky_pts(3,:));
    bad_idx = pred~=lbl;
    bad_pts = reshape(get_mid(test_x(:,:,:,bad_idx),floor(para.win_m/2),floor(para.win_m/2)),3,[]);
    figure; scatter3(bad_pts(1,:),bad_pts(2,:),bad_pts(3,:));
end

function [er,pred,truth] = batch_test(batch_size, test_x, test_y, cnn,U,S,avg,epsilon,para)
    itr_no = size(test_y,2)/batch_size;
    er = 0;
    pred = zeros(1,size(test_y,2));
    truth = zeros(1,size(test_y,2));
    
    for itr = 1:itr_no
        x = test_x(:,:,:,(itr-1)*batch_size+1:itr*batch_size);
        x = pre_pro(x,U,S,avg,epsilon,para);
        y = test_y(:,(itr-1)*batch_size+1:itr*batch_size);
        [p, t] = my_cnntest(cnn, x, y, para.no_chnl);
        pred((itr-1)*batch_size+1:itr*batch_size) = p;
        truth((itr-1)*batch_size+1:itr*batch_size) = t;
        bad = find(p ~= t);
        e = numel(bad) / numel(t);
        disp(e);
        er = er+e;
    end
    er = er/itr_no;
end
