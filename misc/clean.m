% select corresponding images according to the labels available
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/l_manual/';
data_dir = '/media/662CD4C02CD48D05/_backup/data/images/l_gen/';
raw_data_dir = '/media/662CD4C02CD48D05/_backup/data/images/tmp/';

all_lbl = dir(lbl_dir);
for idx = 3:length(all_lbl)
    lbl_name = all_lbl(idx).name;
    prefix = lbl_name(1:end-4);
    data_name = [prefix '.pgm'];
    tmp = imread([raw_data_dir data_name]);
    imwrite(tmp,[data_dir data_name]);
end