% load mnist_uint8;
% train_x = double(reshape(train_x',28,28,60000))/255;
% test_x = double(reshape(test_x',28,28,10000))/255;
% train_y = double(train_y');
% test_y = double(test_y');
name = 'ZCA_rdm_windows_425*3*80gray_blnc.mat';
load(['/home/dontloo/Desktop/re/data/train_data/' name]);
% train_x = train_x(:,:,1:1000);
% train_y = train_y(:,1:1000);

%% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
%will run 1 epoch in about 200 second and get around 11% error. 
%With 100 epochs you'll get around 1.2% error

%rand('state',0);
rng('default');

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 8, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
    struct('type', 'c', 'outputmaps', 4, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};
cnn = cnnsetup(cnn, train_x, train_y);

opts.alpha = 1;
opts.batchsize = 1000;
opts.numepochs = 40;
% cnn = cnntrain(cnn, train_x, train_y, opts);
cnn = my_cnntrain(cnn, train_x, train_y, opts);

%plot mean squared error
figure; plot(cnn.rL); 
figure; plot(cnn.err);
save(['/home/dontloo/Desktop/re/data/train_res/' name]);
