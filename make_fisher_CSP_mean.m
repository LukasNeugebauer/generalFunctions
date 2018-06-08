function [out] = make_fisher_CSP_mean(sph_X,p,CSP_coord)
%function [out] = make_fisher_CSP_mean(X,[amp,kappa],CSP_coord)
%basically the same as make_fisher but parameters are given in a different
%way which is necessary for optimization procedures
%
%probably not necessary though... 

out = make_fisher(sph_X,[p,CSP_coord]);