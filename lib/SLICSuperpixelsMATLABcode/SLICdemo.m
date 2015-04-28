%======================================================================
%SLIC demo
% Copyright (C) 2015 Ecole Polytechnique Federale de Lausanne
% File created by Radhakrishna Achanta
% Please also read the copyright notice in the file slicmex.c 
%======================================================================
%Input parameters are:
%[1] 8 bit images (color or grayscale)
%[2] Number of required superpixels (optional, default is 200)
%[3] Compactness factor (optional, default is 10)
%
%Ouputs are:
%[1] labels (in raster scan order)
%[2] number of labels in the image (same as the number of returned
%superpixels
%
%NOTES:
%[1] number of returned superpixels may be different from the input
%number of superpixels.
%[2] you must compile the C file using mex slicme.c before using the code
%below
%======================================================================
img = imread('/media/662CD4C02CD48D05/_backup/data/images/test_643_4_cln/09_26_0001_0000000000.png');
[labels, numlabels] = slicmex(img,100,20);%numlabels is the same as number of superpixels
figure,imagesc(labels); axis image off ; hold on ;

