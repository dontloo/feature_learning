data_dir = '/media/662CD4C02CD48D05/_backup/data/images/road_test_4_lab/';
files = dir(data_dir);
for idx = 3:length(files)
    file_name = files(idx).name;
    suffix = file_name(5:end);
    movefile([data_dir files(idx).name], [data_dir suffix]);
end