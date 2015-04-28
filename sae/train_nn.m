sae_name = 'unlbl_849*32_RGB_blnc.mat';
load(['/media/662CD4C02CD48D05/_backup/data/train_res/sae_2_' sae_name]);
tain_name = 'train_849_4_400*3*4_RGB_blnc.mat';
load(['/media/662CD4C02CD48D05/_backup/data/train_data/' tain_name]);
train_x = (double(reshape(train_x,dim,[]))/255)';
train_y = double(train_y');
% Use the SDAE to initialize a FFNN
nn = nnsetup([dim 100 size(train_y,2)]);
nn.activation_function              = 'sigm';
nn.learningRate                     = 1;
nn.W{1} = sae.ae{1}.W{1};
% nn.W{2} = sae.ae{2}.W{2};

% Train the FFNN
opts.numepochs = 800;
opts.batchsize = 600;
nn = nntrain(nn, train_x, train_y, opts);

% test_643_4_cln/
% test_643_4_lab/
% 09_26_0005_0000000000
% 09_26_0001_0000000000
% 09_26_0001_0000000045
% 09_26_0014_0000000180
% 09_26_0051_0000000190
% 09_29_0026_0000000110
% 09_26_0106_0000000205
% 09_26_0096_0000000160

% train_849_4_cln/
% train_849_4_lab/
% 09_26_0002_0000000000
% 09_28_0001_0000000000
im_path = '/media/662CD4C02CD48D05/_backup/data/images/train_849_4_cln/09_26_0002_0000000000.png';
lbl_path = '/media/662CD4C02CD48D05/_backup/data/images/train_849_4_lab/lbl_09_26_0002_0000000000.pgm';
func = @(x)nnpredict(nn, x);
[er, pred, lbl] = test_on_one_img(func,para,im_path,lbl_path);

pred = nnpredict(nn, train_x(2401:end,:));

[er, bad] = nntest(nn, train_x, train_y);
assert(er < 0.16, 'Too big error');
