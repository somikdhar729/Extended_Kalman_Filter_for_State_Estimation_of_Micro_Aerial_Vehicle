function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively

Ct = [zeros(3,6),eye(3),zeros(3,6)];

R = 10*diag([1,1,0.05]);

Kt = covarEst*Ct'*(Ct*covarEst*Ct'+R)^-1;
covar_curr = covarEst - Kt*Ct*covarEst;

uCurr = uEst + Kt*(z_t - uEst(7:9,:));


end