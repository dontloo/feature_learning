function CNN_test
    load('/media/662CD4C02CD48D05/_backup/data/train_res/CNN_ZCA_15.24_cyan_2_264*3*5_RGB_blnc.mat');
    U=0;S=0;avg=0;epsilon=0;
    
    load('/media/662CD4C02CD48D05/_backup/data/test_data/cyan_20_20*100_RGB.mat');
    para.prepro = 0;
    % ZCA
    para.prepro = 1;
    load('/media/662CD4C02CD48D05/_backup/data/train_data/ZCA_road_all_942*1*32_RGB_rdm.mat');
    % ZCA
    err = image_test('/media/662CD4C02CD48D05/_backup/data/images/cyan_20/', '/media/662CD4C02CD48D05/_backup/data/images/cyan_20_lab/',cnn,para,U,S,avg,epsilon);
%     [er,pred,lbl] = batch_test(2000, test_x, test_y, cnn,U,S,avg,epsilon,para);
    disp(err);
%     % my_plot(test_x,pred,lbl,para);
    

    % road_test_4/
    % 0015_0000000000
    % road_test_4_lab/
    % 0032_0000000020
   end

function err = image_test(im_folder, lbl_folder, cnn,para,U,S,avg,epsilon)
    im_files = dir(im_folder);
    lbl_files = dir(lbl_folder);
    err = 0;
    for idx = 3:length(im_files)
        im_path = [im_folder im_files(idx).name];
        lbl_path = [lbl_folder lbl_files(idx).name];
        err = err + test_cnn_on_one_img(cnn, im_path, lbl_path,para,U,S,avg,epsilon);
        disp(idx);
    end   
    err = err/(length(im_files)-2);
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
        [p] = my_cnntest(cnn, x);
        [~, t] = max(y);
        pred((itr-1)*batch_size+1:itr*batch_size) = p;
        truth((itr-1)*batch_size+1:itr*batch_size) = t;
        bad = find(p ~= t);
        e = numel(bad) / numel(t);
        disp(e);
        er = er+e;
    end
    er = er/itr_no;
end
