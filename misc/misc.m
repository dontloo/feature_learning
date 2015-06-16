load('/media/662CD4C02CD48D05/_backup/data/train_res/CNN_RAW_man_24.24_cyan_40_40*3*25_RGB_blnc.mat');
figure; plot(cnn.rL); 
figure; plot(cnn.err);
load('/media/662CD4C02CD48D05/_backup/data/train_res/CNN_CAE_man_24.24_cyan_40_40*3*25_RGB_blnc.mat');
figure; plot(cnn.rL); 
figure; plot(cnn.err);
num_batches = size(cnn.err,2)/opts.numepochs;
disp(mean(cnn.err(end-num_batches+1:end)));

load('/media/662CD4C02CD48D05/_backup/data/train_res/24_5_2_CAE_s_road_all_942*1*32_RGB_rdm.mat');
% cae_vis(cae, [], 0)
n = 8;
w = zeros((cae.ks+2)*3,(cae.ks+2)*n,3);
for oc = 0:(cae.oc-1)
    x = oc - n.*floor(oc./n);
    y = floor(oc./n);
    tmp = cae.w(:,:,:,oc+1);
    tmp = (tmp-min(tmp(:)))/(max(tmp(:))-min(tmp(:)));
    w((cae.ks+2)*y+2:(cae.ks+2)*(y+1)-1,(cae.ks+2)*x+2:(cae.ks+2)*(x+1)-1,:) = tmp;
end
figure,imshow(imresize(w,10,'nearest'));