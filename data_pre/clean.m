% select corresponding images according to the labels available
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_lab';
data_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_cln/';
raw_data_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4/';

all_lbl = dir(lbl_dir);
for idx = 3:length(all_lbl)
    lbl_name = all_lbl(idx).name;
    prefix = lbl_name(5:end-4);
    data_name = [prefix '.png'];
    tmp = imread([raw_data_dir data_name], 'PNG');
    imwrite(tmp,[data_dir data_name]);
end