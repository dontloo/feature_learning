function [ data,label ] = load_im_gray(data_file_names,lbl_files_names,arg_start,arg_end,para)
    n_im = arg_end-arg_start+1;
%     rgb = 3;
%     data = nan(para.img_m,para.img_n,rgb,arg_end-arg_start+1);
    data = nan(para.img_m,para.img_n,n_im);
    label = nan(para.img_m,para.img_n,n_im);
    
    for idx = arg_start:arg_end
        data_file_name = data_file_names{idx};
        lbl_file_name = lbl_files_names{idx};
        
        d = imread(data_file_name, 'PNG');
        l = imread(lbl_file_name, 'PGM');
        % rgb here
        data(:,:,idx-arg_start+1) = rgb2gray(d);
        label(:,:,idx-arg_start+1) = l;
    end
end

