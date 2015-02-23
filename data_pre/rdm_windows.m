data_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_cln/';
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_lab/';

data_file_names = dir2filenames(data_dir);
lbl_file_names = dir2filenames(lbl_dir);
% para.img_m = 512;
% para.img_n = 1392;
para.img_m = 128;
para.img_n = 348;
para.win_m = 32;
para.win_n = 32;
%rgb
para.no_chnl = 3;

% [train_x,train_y] = load_rdm_win_blnc(para.no_chnl,data_file_names,lbl_file_names,1,232,para,8);
% save('/media/662CD4C02CD48D05/_backup/data/train_data/train_849_4_232*3*8_RGB_blnc.mat');

[test_x,test_y] = load_rdm_win(para.no_chnl,data_file_names,lbl_file_names,1,456,para,20);
save('/media/662CD4C02CD48D05/_backup/data/test_data/test_643_4_456*20_RGB.mat');