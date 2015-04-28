name = 'unlbl_849*64_RGB_blnc.mat';
load(['/media/662CD4C02CD48D05/_backup/data/train_data/' name]);
dim = para.win_m*para.win_n*para.no_chnl;
train_x = double(reshape(train_x,dim,[]))/255;
train_x = train_x';
% % imshow(reshape(train_x(1,:),32,32,3))

%%  ex1 train a 100 hidden unit SDAE and use it to initialize a FFNN
%  Setup and train a stacked denoising autoencoder (SDAE)
rand('state',0)
no_hidden = 10^2;
sae = saesetup([dim no_hidden no_hidden]);
sae.ae{1}.activation_function       = 'sigm';
sae.ae{1}.learningRate              = 1;
sae.ae{1}.inputZeroMaskedFraction   = 0.25;
sae.ae{2}.activation_function       = 'sigm';
sae.ae{2}.learningRate              = 1;
sae.ae{2}.inputZeroMaskedFraction   = 0.25;
opts.numepochs = 2000;
opts.batchsize = 849*4;
sae = my_saetrain(sae, train_x, opts);
my_visualize(sae.ae{1}.W{1}(:,2:end)',para.win_m,para.win_n,para.no_chnl,no_hidden);
save(['/media/662CD4C02CD48D05/_backup/data/train_res/sae_2_' name]);
