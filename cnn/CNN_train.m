% load mnist_uint8;
% train_x = double(reshape(train_x',28,28,60000))/255;
% test_x = double(reshape(test_x',28,28,10000))/255;
% train_y = double(train_y');
% test_y = double(test_y');
clear;
% name = 'ZCA_train_849_425*3*20_RGB_blnc.mat';
name = 'ZCA_train_849_4_400*3*4_LAB_blnc.mat';

load(['/media/662CD4C02CD48D05/_backup/data/train_data/' name]);
train_x = double(train_x);
train_y = double(train_y);

%% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
%will run 1 epoch in about 200 second and get around 11% error. 
%With 100 epochs you'll get around 1.2% error

%rand('state',0);
rng('default');

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 8, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
%     struct('type', 'c', 'outputmaps', 32, 'kernelsize', 4) %convolution layer
%     struct('type', 's', 'scale', 2) %subsampling layer
};
cnn = my_cnnsetup(cnn, train_x, train_y, 3);

opts.alpha = 1;
opts.batchsize = 400;
opts.numepochs = 120;
opts.inputmaps = 3;
% cnn = cnntrain(cnn, train_x, train_y, opts);
cnn = my_cnntrain(cnn, train_x, train_y, opts);

%plot mean squared error
figure; plot(cnn.rL); 
figure; plot(cnn.err);
clear train_x train_y data_dir lbl_dir data_file_names lbl_file_names;
save(['/media/662CD4C02CD48D05/_backup/data/train_res/8.12_' name]);
