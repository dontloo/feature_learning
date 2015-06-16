% name_zca = 'road_all_942*1*32_RGB_rdm.mat';
% load(['/media/662CD4C02CD48D05/_backup/data/train_data/' name_zca]);

load('/home/dontloo/Desktop/cv/proj/patch150_100.mat');
x = reshape(train_x,para.win_m*para.win_n*para.no_chnl,size(train_x,4));

% http://deeplearning.stanford.edu/wiki/index.php/UFLDL_Tutorial
avg = mean(x, 2);
x = x - repmat(avg, 1, size(x, 2));
sigma = x * x' / size(x, 2);
% ref: PCA by SVD
% http://stackoverflow.com/questions/3181593/matlab-is-running-out-of-memory-but-it-should-not-be
% http://au.mathworks.com/help/stats/princomp.html 'econ'
[U,S,V] = svd(sigma);
epsilon = 1e-5;
% To make each of our input features have unit variance
x = U * diag(1./sqrt(diag(S) + epsilon)) * U' * x;
train_x = reshape(x,para.win_m,para.win_n,para.no_chnl,size(x,2));
clear x;
% save(['/media/662CD4C02CD48D05/_backup/data/train_data/ZCA_' name_zca]);
save('/home/dontloo/Desktop/cv/proj/ZCA_patch150_100.mat')