dist = '/media/662CD4C02CD48D05/_backup/raw_data/train_849/';
tar = '/media/662CD4C02CD48D05/_backup/raw_data/train_849_4/';

% dist = '/media/662CD4C02CD48D05/_backup/data/images/train_849_lab_ref/';
% tar = '/media/662CD4C02CD48D05/_backup/data/images/train_849_4_lab/';

all_file = dir(dist);
for idx = 3:length(all_file)
    file_name = all_file(idx).name;
    tmp = imread([dist file_name]);
%     tmp = imresize(tmp, [128 348], 'nearest');
    tmp = imresize(tmp, 1/4);
    imwrite(tmp,[tar file_name]);
end