data_dir = '/media/662CD4C02CD48D05/_backup/raw_data/test_643/';
% data_dir = '/media/662CD4C02CD48D05/_backup/raw_data/train_849/';

output_dir = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4/';
% output_dir = '/media/662CD4C02CD48D05/_backup/data/images/train_849_4/';

scale = 1/4;
all_files = dir(data_dir);
for idx = 3:length(all_files)
    file_name = all_files(idx).name;
    im = imread([data_dir file_name], 'PNG');
    im = imresize(im, scale);
    imwrite(im, [output_dir file_name]);
end