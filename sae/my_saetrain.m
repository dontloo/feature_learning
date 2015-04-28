function sae = my_saetrain(sae, x, opts)
    for i = 1 : numel(sae.ae);
        disp(['Training AE ' num2str(i) '/' num2str(numel(sae.ae))]);
        sae.ae{i} = my_nntrain(sae.ae{i}, x, x, opts);
        t = batch_nnff(sae.ae{i}, x, x, opts);
        x = t.a{2};
    end
end
