tar_dir = '/media/662CD4C02CD48D05/_backup/data/images/l_manual/';
src_dir = '/media/662CD4C02CD48D05/_backup/data/images/l_gen/';
files1 = dir(tar_dir);
files2 = dir(src_dir);
summ = 0;
for idx = 3:length(files1)
    name1 = files1(idx).name;
    name2 = files2(idx).name;
    im1 = imread([tar_dir name1]);
    im2 = imread([src_dir name2]);
    summ = summ+sum(sum(im1~=im2));
end
summ = summ/((length(files1)-2)*128*348);