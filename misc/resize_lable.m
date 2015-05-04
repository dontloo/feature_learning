dist = '/media/662CD4C02CD48D05/_backup/raw_data/road_all/';
tar = '/media/662CD4C02CD48D05/_backup/raw_data/road_all_4/';

all_file = dir(dist);
for idx = 3:length(all_file)
    file_name = all_file(idx).name;
    tmp = imread([dist file_name]);
    if size(tmp,1)~=512
        disp('~');
    end
%     tmp = imresize(tmp, 1/4, 'nearest');
    tmp = imresize(tmp, 1/4);
    imwrite(tmp,[tar file_name]);
end