% lbl_dir = '/home/dontloo/Desktop/re/data/2011_09_26_drive_0005_lab/';
% data_dir = '/home/dontloo/Desktop/re/data/2011_09_26_drive_0005_cln/';
lbl_dir = '/home/dontloo/Desktop/re/data/test_643_lab_ref/';
data_dir = '/home/dontloo/Desktop/re/data/test_643_ref_cln/';
data_file_names = dir2filenames(data_dir);
lbl_file_names = dir2filenames(lbl_dir);
para.img_m = 512;
para.img_n = 1392;
% para.img_m = 375;
% para.img_n = 1242;
para.win_m = 32;
para.win_n = 32;

% [train_x,train_y] = load_rdm_win_gray_blnc(data_file_names,lbl_file_names,1,425,para,80);
% save('/home/dontloo/Desktop/re/data/train_data/rdm_windows_425*3*80gray_blnc.mat');

[test_x,test_y] = load_rdm_win_gray(data_file_names,lbl_file_names,1,425,para,256);
save('/home/dontloo/Desktop/re/data/test_data/rdm_windows_425*256gray_02.mat');