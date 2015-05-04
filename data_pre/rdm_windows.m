data_dir = '/media/662CD4C02CD48D05/_backup/data/images/cyan_2/';
data_file_names = dir2filenames(data_dir);
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/cyan_2_lab/';
lbl_file_names = dir2filenames(lbl_dir);

para.img_m = 128;
para.img_n = 348;
para.win_m = 32;
para.win_n = 32;
% color space/ grasycale
para.no_chnl = 1;
para.color_space = 'grayscale';

[train_x,train_y] = load_rdm_win_blnc(data_file_names,lbl_file_names,1,264,para,25);
% [train_x] = load_rdm_win(data_file_names,1,942,para,32);
save('/media/662CD4C02CD48D05/_backup/data/train_data/cyan_2_264*3*25_Gray_blnc.mat');

% [test_x,test_y] = load_rdm_win(para.no_chnl,data_file_names,lbl_file_names,1,456,para,20);
% save('/media/662CD4C02CD48D05/_backup/data/test_data/test_643_4_456*20_RGB.mat');