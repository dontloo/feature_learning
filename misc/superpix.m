run('/home/dontloo/Desktop/re/matlab/vlfeat-0.9.20/toolbox/vl_setup');
im_path = '/media/662CD4C02CD48D05/_backup/data/images/test_643_4_cln/09_26_0051_0000000190.png';
im = imread(im_path);
regionSize = 16;
regularizer = 1000;
imlab = vl_xyz2lab(vl_rgb2xyz(im));
res_im = vl_slic(single(imlab), regionSize, regularizer);
% IM contains the image in RGB format as before
[sx,sy]=vl_grad(double(res_im), 'type', 'forward') ;
s = find(sx | sy) ;
imp = im ;
imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
figure, imagesc(imp) ; axis image off ; hold on ;