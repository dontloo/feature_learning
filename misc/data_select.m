data_dir = '/media/662CD4C02CD48D05/_backup/raw_data/train_raw/2011_09_26/';
dest_dir = '/media/662CD4C02CD48D05/_backup/raw_data/road_all/';
all_foldrs = dir(data_dir);
for idx = 3:length(all_foldrs)
    disp(idx);
    folder_name = all_foldrs(idx).name;
    sub_dir = [data_dir folder_name '/image_02/data/'];
    prefix = folder_name(end-11:end-7);
    imgs = dir(sub_dir);
    for im_idx = 3:5:length(imgs)
        copyfile([sub_dir imgs(im_idx).name],[dest_dir prefix imgs(im_idx).name]);
    end
end