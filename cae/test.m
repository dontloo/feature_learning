load mnist_uint8;

train_x = double(reshape(train_x',28,28,60000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y');
test_y = double(test_y');

x = train_x(:,:,1);

% % for mading up d-channel data
% n = 20;
% d = 2;
% x = zeros(size(train_x,1),size(train_x,2),d,n);
% for i = 1:n
%     for ic = 1:d
%         x(:,:,ic,i) = train_x(:,:,d*(i-1)+ic);
%     end
% end

cae = cae_setup(2,6,5,2);

opts.alpha = 0.2;
opts.numepochs = 100;
opts.batchsize = 1;

cae = cae_train(cae, x, opts);
% cae_vis(cae);
% imshow(cae.o(:,:,1,1));