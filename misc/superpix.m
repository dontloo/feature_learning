im_path = '/media/662CD4C02CD48D05/_backup/data/images/cyan_20/0016_0000000250.png';
im = im2double(imread(im_path));
run('/home/dontloo/Desktop/re/matlab/lib/vlfeat-0.9.20/toolbox/vl_setup');
% regionSize = 16;
% regularizer = 1000;
% imlab = vl_xyz2lab(vl_rgb2xyz(im));
% res_im = vl_slic(single(imlab), regionSize, regularizer);
[res_im, numlabels] = slicmex(im2uint8(im),320,16);
res_im = double(res_im);
for i=0:numlabels
    res_im(res_im==i) = rand();
end
% figure,
% subplot(1,2,1), imshow(res_im);
% subplot(1,2,2), imshow(im);
% IM contains the image in RGB format as before
[sx,sy]=vl_grad(double(res_im), 'type', 'forward') ;
s = find(sx | sy) ;
imp = im ;
imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
figure, imagesc(imp) ; axis image off ; hold on ;
imwrite(imp,'super.png');