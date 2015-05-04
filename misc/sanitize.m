% select corresponding images according to the labels available
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/train_849_4_lab/';

all_lbl = dir(lbl_dir);
for idx = 3:length(all_lbl)
    tmp = imread([lbl_dir all_lbl(idx).name]);
    [row, col] = find(tmp~=0 & tmp~=128 & tmp~=255);
    if(sum(row)>0)
        disp(all_lbl(idx).name);
    end
end