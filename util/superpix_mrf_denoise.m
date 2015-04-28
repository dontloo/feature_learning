function [denoised_pred] = superpix_mrf_denoise(centroid_pred,res_im,no_clusters,beta,eta)
    graph = build_graph(res_im, no_clusters);
    mc = maximalCliques(graph);
    denoised_pred = mrf_denoise(mc,centroid_pred,no_clusters,beta,eta);
end