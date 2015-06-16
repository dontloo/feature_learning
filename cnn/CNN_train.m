name = 'cyan_40_40*3*25_RGB_blnc.mat';
load(['/media/662CD4C02CD48D05/_backup/data/train_data/' name]);
% PCA
load('/media/662CD4C02CD48D05/_backup/data/train_data/ZCA_road_all_942*1*32_RGB_rdm.mat');
para.prepro=1;
train_x = pre_pro(train_x,U,S,avg,epsilon,para);
% PCA
train_y = double(train_y);

%rand('state',0);
rng('default');

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 24, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
    struct('type', 'c', 'outputmaps', 24, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};
% CAE
% load('/media/662CD4C02CD48D05/_backup/data/train_res/24_5_2_CAE_s_road_all_942*1*32_RGB_rdm.mat');
% cnn = cae_setup_cnn(cae,cnn,train_x,train_y);
% CAE
cnn = my_cnnsetup(cnn, train_x, train_y, 3);

opts.alpha = 1;
opts.batchsize = 40;
opts.numepochs = 64;
cnn = my_cnntrain(cnn, train_x, train_y, opts);

%plot mean squared error
figure; plot(cnn.rL); 
figure; plot(cnn.err);
clear train_x train_y data_dir lbl_dir data_file_names lbl_file_names;
% save(['/media/662CD4C02CD48D05/_backup/data/train_res/CNN_RAW_15.24_' name]);
% save(['/media/662CD4C02CD48D05/_backup/data/train_res/CNN_ZCA_15.24_' name]);
save(['/media/662CD4C02CD48D05/_backup/data/train_res/CNN_ZCA_man_24.24_' name]);