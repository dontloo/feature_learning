function [latent] = mrf_denoise(mc,observed,no_nodes,beta,eta)
    % weights can be trained
    la_mat =    [0 1 2;
                 1 0 1;
                 2 1 0];
    ol_mat =    [0 1 1;
                 1 0 1;
                 1 1 0];
    latent = observed;
    latent = ICM_pass(observed,latent,mc,beta,eta,la_mat,ol_mat,no_nodes);
end

function [latent] = ICM_pass(observed,latent,mc,beta,eta,la_mat,ol_mat,no_nodes)
    for i=1:no_nodes
        mc_i = mc(:,mc(i,:)==1);
        engy = zeros(1,3);
        for cl = 1:3
            latent(i) = cl;
            engy(cl) = beta*latent_cliques(latent,mc_i,la_mat)+eta*ol_mat(latent(i),observed(i));
        end
        [~,latent(i)] = min(engy);
    end
end

function [res] = latent_cliques(latent,cliques,agree_mat)
    m = size(cliques,2);
    res = 0;
    for i = 1:m
        c = cliques(:,i);
        [nodes,~] = find(c==1);
        vals = latent(nodes);
        nums = [sum(vals == 1) sum(vals == 2) sum(vals == 3)];
        res = res+nums*sum(agree_mat.*repmat(nums,3,1),2);
    end
end

function [en] = energy(observed,latent,mc,beta,eta,la_mat,ol_mat)
    % latent cliques
    lc = latent_cliques(latent,mc,la_mat);
    % observed-latent pairs
    linearInd = sub2ind(size(la_mat), observed, latent);
    ol = sum(ol_mat(linearInd));
    en = beta*lc+eta*ol;
end