The EKF algorithm has two main steps:
Prediction Step:
* Process model predicts future state and covariance based on the current state, control inputs, system dynamics, and noise models
* Process model includes position, velocity, orientation, sensor biases, and transformation matrices
* Outputs predicted state and covariance

Update Step:
* Incorporate measurements from the Vicon system
* Vicon provides position and orientation measurements as ground truth
* The measurement model relates measurements to the state
* Kalman gain balances predicted and measured states
* Updated state and covariance computed using Kalman gain and measurement residue
