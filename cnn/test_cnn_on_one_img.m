% need to be reshaped in order to plot
function [ er, pred, truth ] = test_cnn_on_one_img(cnn,data_file_name,lbl_file_name,para,U,S,avg,epsilon)
    d = imread(data_file_name, 'PNG');
    % rgb here
    d = rgb2gray(d);
    l = imread(lbl_file_name, 'PGM');
    
    [er,pred,truth] = slice_and_test(cnn,para,d,l,U,S,avg,epsilon);
end

function [er,pred,truth] = slice_and_test(cnn,para,img,img_lbl,U,S,avg,epsilon)
    
%     rgb = 3;
%     data = nan(para.img_m,para.img_n,rgb,arg_end-arg_start+1);
    pred = zeros(para.img_m-para.win_m, para.img_n-para.win_n);
    truth = zeros(para.img_m-para.win_m, para.img_n-para.win_n);
    
    m_ofst = floor(para.win_m/2);
    n_ofst = floor(para.win_n/2);

    calsses = [0,128,255];

    for n_idx=1:para.img_n-para.win_n
        wins = zeros(para.win_m,para.win_n,para.img_m-para.win_m);
        win_lbls = zeros(3,para.img_m-para.win_m);
        for m_idx=1:para.img_m-para.win_m
            wins(:,:,m_idx) = img(m_idx:m_idx+para.win_m-1,n_idx:n_idx+para.win_n-1);
            win_lbls(:,m_idx) = calsses==get_label(img_lbl,m_idx,n_idx,m_ofst,n_ofst);
        end
        wins = pre_pro(wins,U,S,avg,epsilon,para);
        [p, t] = my_cnntest(cnn, wins, win_lbls);
        pred(:,n_idx) = p;
        truth(:,n_idx) = t;
    end
    
    bad = find(pred ~= truth);
    er = numel(bad) / numel(truth);
end

function [h, a] = my_cnntest(net, x, y)
    net = cnnff(net, x);
    [~, h] = max(net.o);
    [~, a] = max(y);
end
