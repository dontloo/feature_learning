function [wins] = gen_wins(data_file_names,para,win_im )
    no_im = size(data_file_names,1);
    wins = zeros(para.win_m,para.win_n,para.no_chnl,win_im*no_im,'uint8');
    % process one image per iteration in case of running out of memory
    for idx = 1:no_im
        disp(idx);
        data_file_name = data_file_names{idx};
        % rgb here
        d = imread(data_file_name, 'PNG');
        if para.no_chnl==1
            d = rgb2gray(d);
        end
        wins(:,:,:,(idx-1)*win_im+1:idx*win_im) = win_slice_rdm(d,para,win_im);
    end
end

