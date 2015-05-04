load mnist_uint8;

train_x = double(reshape(train_x',28,28,60000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y');
test_y = double(test_y');

x = train_x(:,:,1:6000);
x = align_data(x);
% input channels | output channels | kernel size | pool size | noise
cae = cae_setup(1,12,7,2,0);

opts.alpha = 0.03;
opts.numepochs = 8;
opts.batchsize = 100;
opts.shuffle = 1;
cae = cae_train(cae, x, opts);

cae_vis(cae,x);
% random select, display
% figure,imshow(cae.o(:,:,1,1));

train_x = train_x(:,:,end-99:end);
train_y = train_y(:,end-99:end);
cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
};
opts.alpha = 1;
opts.batchsize = 50;
opts.numepochs = 400;

cnn = cae_setup_cnn(cae,cnn,train_x,train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);
figure; plot(cnn.rL);
[er1, bad1] = cnntest(cnn, test_x, test_y);

cnn = cnnsetup(cnn, train_x, train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);
figure; plot(cnn.rL);
[er2, bad2] = cnntest(cnn, test_x, test_y);

