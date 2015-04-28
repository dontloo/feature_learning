function [centroids,res_im,no_clusters] = superpix_centroids_GBS(im, fst_para, snd_para)
    [res_im,no_clusters] = super_pix(im, num2str(fst_para), num2str(snd_para));
    centroids = zeros(3,no_clusters);
    for idx=1:no_clusters
        [row,col] = find(res_im==idx);
        centroids(:,idx) = [mean(row) mean(col) idx];
%         centroids(:,idx) = [median(row) median(col) idx];        
    end    
    centroids = round(centroids);
end

function [res_im,no_clusters] = super_pix(im, fst_para, snd_para)
    tmp_dir = '/home/dontloo/Desktop/re/tmp/';
    delete([tmp_dir '*']);
    file_name = 'tmp.jpg';
    prefix = file_name(1,1:end-4);    
    tmp_name = [prefix '_tmp.ppm'];
    imwrite(im,[tmp_dir tmp_name]);
    out_name = [prefix '.ppm'];
    cmd = ['/home/dontloo/Desktop/re/my_segment/segment 0.8 ' fst_para ' ' snd_para ' ' tmp_dir tmp_name ' ' tmp_dir out_name];
    [status,cmdout] = system(cmd);    
    no_clusters = str2double(cmdout);
    res_im =  imread([tmp_dir prefix '.pgm'], 'PGM');    
end