function model = tak_clf_L2loss_FL_ADMM_FFT_train(X, y, option)
%% model = tak_clf_L2loss_FL_ADMM_FFT_train(X, y, option)
%==============================================================================%
% Update 08/18/2015
% - removed "graphInfo" part; let tak_FL_regr_ADMM_FFT_over_relax compute
%   these info from "brain_mask" internally
%------------------------------------------------------------------------------%
% Train Fused-Lasso penalized squared-loss regression classifier
% - basically a wrapper to tak_FL_regr_ADMM_FFT_over_relax.m
%------------------------------------------------------------------------------%
%==============================================================================%
% 08/15/2015
%%
% warning('code still in progress')
if ~exist('option','var'), option = []; end
if ~isfield(option,'over_relax')
    option.over_relax = false;
end

%| L1 penalty parameter
lam = option.lam;

%| GraphNet penalty parameter
gam = option.gam;

if ~isfield(option,'rho')
    option.rho = 1; % ADMM parameter
end

%%%% removed 08/18/2015 %%%%
% [C_circ,augmat, bmask, NSIZE] = tak_ibis_Ccirc_bmask(option.brain_mask);
% graphInfo.C = C_circ;
% graphInfo.A = augmat;
% graphInfo.b = bmask;
% graphInfo.NSIZE = NSIZE;
%%

if option.over_relax
    model.w = tak_FL_regr_ADMM_FFT_over_relax(X,y,lam,gam,option);
else
    model.w = tak_FL_regr_ADMM_FFT(X,y,lam,gam,option);
end