% select corresponding images according to the labels available
lbl_dir = '/media/662CD4C02CD48D05/_backup/data/images/cyan_40_lab/';

all_lbl = dir(lbl_dir);
for idx = 3:length(all_lbl)
    tmp = rgb2gray(imread([lbl_dir all_lbl(idx).name]));
    tmp(tmp<55)=0;
    tmp(tmp>200)=255;
    tmp(tmp~=0&tmp~=255)=128;
    [row, col] = find(tmp~=0 & tmp~=128 & tmp~=255);
    if(sum(row)>0)
        disp(all_lbl(idx).name);
    else
        imwrite(tmp,[lbl_dir all_lbl(idx).name]);
    end    
end