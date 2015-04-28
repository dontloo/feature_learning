
data_dir = '/media/662CD4C02CD48D05/_backup/raw_data/train_849_4/';
data_file_names = dir2filenames(data_dir);

para.img_m = 128;
para.img_n = 348;
para.win_m = 32;
para.win_n = 32;
%rgb
para.no_chnl = 3;

[train_x] = gen_wins(data_file_names,para,64);
train_x = train_x(:,:,:,randperm(size(train_x,4)));
% imshow(train_x(:,:,:,10000))
save('/media/662CD4C02CD48D05/_backup/data/train_data/unlbl_849*64_RGB_blnc.mat');