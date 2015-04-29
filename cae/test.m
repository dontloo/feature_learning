load mnist_uint8;

train_x = double(reshape(train_x',28,28,60000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y');
test_y = double(test_y');

x = train_x(:,:,1:10000);

% % for making up d-channel data
% n = 400;
% d = 3;
% x = zeros(size(train_x,1),size(train_x,2),d,n);
% for i = 1:n
%     for ic = 1:d
%         x(:,:,ic,i) = train_x(:,:,d*(i-1)+ic);
%     end
% end

% input channels | output channels | kernel size | pool size | noise
cae = cae_setup(1,6,5,2,0.25);

opts.alpha = 0.3;
opts.numepochs = 10;
opts.batchsize = 1000;

cae = cae_train(cae, x, opts);
cae_vis(cae);
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
opts.numepochs = 200;

cnn = cae_setup_cnn(cae,cnn,train_x,train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);
figure; plot(cnn.rL);
[er1, bad1] = cnntest(cnn, test_x, test_y);

cnn = cnnsetup(cnn, train_x, train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);
figure; plot(cnn.rL);
[er2, bad2] = cnntest(cnn, test_x, test_y);

