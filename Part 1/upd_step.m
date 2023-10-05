function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively

Ct = 1*[eye(6),zeros(6,9)];

R = 0.1*diag([0.0001,0.0001,0.0001,0.001,0.001,0.001]);
Kt = covarEst*Ct'*(Ct*covarEst*Ct'+R)^-1;
covar_curr = covarEst - Kt*Ct*covarEst;

uCurr = uEst + Kt*(z_t - uEst(1:6,:));

end