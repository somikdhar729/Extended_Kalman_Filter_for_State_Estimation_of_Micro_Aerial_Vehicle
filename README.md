# Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle
This project implements an Extended Kalman Filter for Micro Aerial Vehicle to estimate the position, orientation, and velocity. Control inputs are provided from onboard IMU and measurement update is obtained from the VICON system. The model is being tested on three datasets prepared for testing.

# Process Flow
1. Developed state-space system for the dynamic model
2. Computed the Jacobian to handle the nonlinearity by approximating around the mean values.
3. Implement a discrete form of EKF to be implemented in Matlab

# Explanation
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

# Results
## Part 1: Measurement update will be given by the position and orientation from VICON
### Dataset 1
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset1.png?raw=true)

### Dataset 4
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset4.png?raw=true)

### Dataset 9
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset9.png?raw=true)


## Part 2: Measurement update will be given by using only the velocity from VICON
### Dataset 1
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset1_part_2.png?raw=true)

### Dataset 4
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset4_part_2.png?raw=true)

### Dataset 9
![alt text](https://github.com/somikdhar729/Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle/blob/main/KALMAN_FILTER_Dataset9_part_2.png?raw=true)
