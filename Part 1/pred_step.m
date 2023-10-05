 function [covarEst,uEst] = pred_step(uPrev,covarPrev,angVel,acc,dt)
%covarPrev and uPrev are the previous mean and covariance respectively
%angVel is the angular velocity
%acc is the acceleration
%dt is the sampling time


X = [uPrev(1),uPrev(2),uPrev(3)]; % Position
orientation = [uPrev(4),uPrev(5),uPrev(6)]; % Orientation: phi,theta,psi
V = [uPrev(7),uPrev(8),uPrev(9)]; % Velocity
phi = orientation(1);
theta = orientation(2);
psi = orientation(3);

G = [cos(theta)*cos(psi) -sin(psi) 0;cos(theta)*sin(psi) cos(psi) 0;-sin(theta) 0 1];

R = [cos(psi)*cos(theta), cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi), cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi);
    sin(psi)*cos(theta), sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi), sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi);
    -sin(theta), cos(theta)*sin(phi), cos(theta)*cos(phi)];
g = [0 0 -9.81]';
x3 = V';
n_bg = 0.00001*randn(3,1);

n_ba =  0.001 * randn(3, 1);

gbx = uPrev(10);
gby = uPrev(11);
gbz = uPrev(12);
abx = uPrev(13);
aby = uPrev(14);
abz = uPrev(15);
x_dot = [x3;(G^-1)*(angVel-uPrev(10:12));g+R*(acc - uPrev(13:15));n_bg;n_ba];


acc_x = acc(1);
acc_y = acc(2);
acc_z = acc(3);
angVel_x = angVel(1);
angVel_y = angVel(2);
angVel_z = angVel(3);
A_t =[
 
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 1, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 1, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 1,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                               - (cos(psi)*(cos(psi)^2*sin(theta) + sin(psi)^2*sin(theta))*(gbx - angVel_x))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2)^2 - (sin(psi)*(cos(psi)^2*sin(theta) + sin(psi)^2*sin(theta))*(gby - angVel_y))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2)^2,                       (sin(psi)*(gbx - angVel_x))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2) - (cos(psi)*(gby - angVel_y))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2), 0, 0, 0,              -cos(psi)/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2),              -sin(psi)/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2),  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                   (sin(psi)*(gby - angVel_y))/(cos(psi)^2 + sin(psi)^2) + (cos(psi)*(gbx - angVel_x))/(cos(psi)^2 + sin(psi)^2), 0, 0, 0,                                     sin(psi)/(cos(psi)^2 + sin(psi)^2),                                    -cos(psi)/(cos(psi)^2 + sin(psi)^2),  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0, - (cos(psi)*cos(theta)*(gbx - angVel_x))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2) - (cos(theta)*sin(psi)*(gby - angVel_y))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2) - (cos(psi)*sin(theta)*(cos(psi)^2*sin(theta) + sin(psi)^2*sin(theta))*(gbx - angVel_x))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2)^2 - (sin(psi)*sin(theta)*(cos(psi)^2*sin(theta) + sin(psi)^2*sin(theta))*(gby - angVel_y))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2)^2, (sin(psi)*sin(theta)*(gbx - angVel_x))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2) - (cos(psi)*sin(theta)*(gby - angVel_y))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2), 0, 0, 0, -(cos(psi)*sin(theta))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2), -(sin(psi)*sin(theta))/(cos(psi)^2*cos(theta) + cos(theta)*sin(psi)^2), -1,                    0,                                                  0,                                                  0]
[0, 0, 0, - (sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta))*(aby - acc_y) - (cos(phi)*sin(psi) - cos(psi)*sin(phi)*sin(theta))*(abz - acc_z),                                                                                                                                                                                                                                                                                                                            cos(psi)*sin(theta)*(abx - acc_x) - cos(phi)*cos(psi)*cos(theta)*(abz - acc_z) - cos(psi)*cos(theta)*sin(phi)*(aby - acc_y),  (cos(phi)*cos(psi) + sin(phi)*sin(psi)*sin(theta))*(aby - acc_y) - (cos(psi)*sin(phi) - cos(phi)*sin(psi)*sin(theta))*(abz - acc_z) + cos(theta)*sin(psi)*(abx - acc_x), 0, 0, 0,                                                                      0,                                                                      0,  0, -cos(psi)*cos(theta),   cos(phi)*sin(psi) - cos(psi)*sin(phi)*sin(theta), - sin(phi)*sin(psi) - cos(phi)*cos(psi)*sin(theta)]
[0, 0, 0,   (cos(psi)*sin(phi) - cos(phi)*sin(psi)*sin(theta))*(aby - acc_y) + (cos(phi)*cos(psi) + sin(phi)*sin(psi)*sin(theta))*(abz - acc_z),                                                                                                                                                                                                                                                                                                                            sin(psi)*sin(theta)*(abx - acc_x) - cos(phi)*cos(theta)*sin(psi)*(abz - acc_z) - cos(theta)*sin(phi)*sin(psi)*(aby - acc_y),  (cos(phi)*sin(psi) - cos(psi)*sin(phi)*sin(theta))*(aby - acc_y) - (sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta))*(abz - acc_z) - cos(psi)*cos(theta)*(abx - acc_x), 0, 0, 0,                                                                      0,                                                                      0,  0, -cos(theta)*sin(psi), - cos(phi)*cos(psi) - sin(phi)*sin(psi)*sin(theta),   cos(psi)*sin(phi) - cos(phi)*sin(psi)*sin(theta)]
[0, 0, 0,                                                                 cos(theta)*sin(phi)*(abz - acc_z) - cos(phi)*cos(theta)*(aby - acc_y),                                                                                                                                                                                                                                                                                                                                                       cos(theta)*(abx - acc_x) + cos(phi)*sin(theta)*(abz - acc_z) + sin(phi)*sin(theta)*(aby - acc_y),                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,           sin(theta),                               -cos(theta)*sin(phi),                               -cos(phi)*cos(theta)]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
[0, 0, 0,                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                   0,                                                                                                                                                                     0, 0, 0, 0,                                                                      0,                                                                      0,  0,                    0,                                                  0,                                                  0]
 
];
U_t =  [
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0]
[1, 0, 0, 0, 0, 0]
[0, 1, 0, 0, 0, 0]
[0, 0, 1, 0, 0, 0]
[0, 0, 0, 1, 0, 0]
[0, 0, 0, 0, 1, 0]
[0, 0, 0, 0, 0, 1]];


Ft = eye(15) + dt*A_t;


Vt = U_t;

Q_d = 1*dt*diag([0.005,0.005,0.005,0.00045,0.00045,0.00045]);

uEst = uPrev + dt*x_dot;
covarEst = Ft * covarPrev * Ft' + Vt*Q_d * Vt';

end

