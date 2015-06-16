% data_dir = '/media/662CD4C02CD48D05/_backup/data/images/cyan_40/';
% data_file_names = dir2filenames(data_dir);
% lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/cyan_40_lab/';
% lbl_file_names = dir2filenames(lbl_dir);

data_dir = '/home/dontloo/Desktop/cv/proj/data/';
data_file_names = dir2filenames(data_dir);

para.img_m = 120;
para.img_n = 160;
para.win_m = 16;
para.win_n = 16;
% color space/ grasycale
para.no_chnl = 3;
para.color_space = 'rgb';

% [train_x,train_y] = load_rdm_win_blnc(data_file_names,lbl_file_names,1,40,para,25);
train_x = load_rdm_win(data_file_names,1,150,para,100);
% save('/media/662CD4C02CD48D05/_backup/data/train_data/cyan_40_40*3*25_RGB_blnc.mat');

save('/home/dontloo/Desktop/cv/proj/patch150_100.mat');

% [test_x, test_y]= load_rdm_win_lab(data_file_names,lbl_file_names,1,20,para,100);
% save('/media/662CD4C02CD48D05/_backup/data/test_data/cyan_20_20*100_RGB.mat');