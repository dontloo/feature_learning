load('/media/662CD4C02CD48D05/_backup/data/train_res/15_5_2_CAE_road_all_942*1*32_RGB_rdm.mat');
w = zeros((cae.ks+2)*3,(cae.ks+2)*5,3);
for oc = 0:(cae.oc-1)
    x = oc - 5.*floor(oc./5);
    y = floor(oc./5);
    w((cae.ks+2)*y+2:(cae.ks+2)*(y+1)-1,(cae.ks+2)*x+2:(cae.ks+2)*(x+1)-1,:) = cae.w(:,:,:,oc+1);
end
%     figure,imshow(imresize(w,10,'nearest'));
figure,imshow(imresize((w-min(w(:)))/(max(w(:))-min(w(:))),10,'nearest'));
figure,imshow(imresize((w-min(w(:))),10,'nearest'));