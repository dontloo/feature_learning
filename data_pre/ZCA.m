clear;
% lbl_dir = '/home/dontloo/Desktop/re/data/lab_img_03/';
% data_dir = '/home/dontloo/Desktop/re/data/img_03/';
% data_file_names = dir2filenames(data_dir);
% lbl_files_names = dir2filenames(lbl_dir);
% para.img_m = 375;
% para.img_n = 1242;
% n_im = 60;
% [x,y] = load_im_gray(data_file_names,lbl_files_names,1,n_im,para);
name_zca = 'rdm_windows_425*3*80gray_blnc.mat';
load(['/home/dontloo/Desktop/re/data/train_data/' name]);
x = reshape(train_x,para.win_m*para.win_n,size(train_x,3));
avg = mean(x, 2);
x = x - repmat(avg, 1, size(x, 2));
% avg = mean(x, 1);
% x = x - repmat(avg, size(x, 1), 1);
sigma = x * x' / size(x, 2);
% ref: PCA by SVD
% http://stackoverflow.com/questions/3181593/matlab-is-running-out-of-memory-but-it-should-not-be
% http://au.mathworks.com/help/stats/princomp.html 'econ'
[U,S,V] = svd(sigma);
epsilon = 1;
xZCAwhite = U * diag(1./sqrt(diag(S) + epsilon)) * U' * x;
train_x = reshape(xZCAwhite,para.win_m,para.win_n,size(xZCAwhite,2));

% xTilde = U(:,1:n_im-1)' * x;
% xPCAwhite = diag(1./sqrt(diag(S) + epsilon)) * U' * x;
clear xZCAwhite x;
save(['/home/dontloo/Desktop/re/data/train_data/ZCA_' name]);
clear train_x train_y data_dir lbl_dir data_file_names lbl_file_names;
save(['/home/dontloo/Desktop/re/data/pre_pro/ZCA_' name]);
% tmp = reshape(xZCAwhite(1,:),para.img_m,para.img_n);
% imshow(mat2gray(tmp));