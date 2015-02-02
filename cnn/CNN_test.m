function CNN_test
    clear;
    load('/home/dontloo/Desktop/re/data/train_res/ZCA_rdm_windows_425*3*80gray_blnc_test.mat');
    % preprocess parameters
    load('/home/dontloo/Desktop/re/data/pre_pro/ZCA_rdm_windows_425*3*80gray_blnc.mat');

%     load('/home/dontloo/Desktop/re/data/test_data/rdm_windows_425*256gray_02.mat');
    % load('/home/dontloo/Desktop/re/data/test_data/02_rdm_windows_60*100gray.mat');

    [er, pred, truth] = test_cnn_on_one_img(cnn,'/home/dontloo/Desktop/re/res/09_26_0005_0000000005.png','/home/dontloo/Desktop/re/res/lbl_09_26_0005_0000000005.pgm',para,U,S,avg,epsilon);
    %[er, pred, truth] = test_cnn_on_one_img(cnn,data_file_names{1},lbl_file_names{1},para,U,S,avg,epsilon);
    % imshow(mat2gray(pred, [1 3]));
    % imshow(mat2gray(truth, [1 3]));
    imwrite(mat2gray(pred, [1 3]), '/home/dontloo/Desktop/re/res/2_5_pred.png');

    % can not fit in memory
    % [er, bad] = cnntest(cnn, train_x, train_y);

%     er = batch_test(3200, test_x, test_y, cnn,U,S,avg,epsilon,para);
%     disp(er);

    assert(er<0.12, 'Too big error');
end

function er = batch_test(batch_size, test_x, test_y, cnn,U,S,avg,epsilon,para)
    itr_no = size(test_x,3)/batch_size;
    er = 0;
    for idx = 1:itr_no
        x = test_x(:,:,(idx-1)*batch_size+1:idx*batch_size);
        x = pre_pro(x,U,S,avg,epsilon,para);
        [e, bad] = cnntest(cnn, x, test_y(:,(idx-1)*batch_size+1:idx*batch_size));
        disp(e);
        er = er+e;
    end
    er = er/itr_no;
end
