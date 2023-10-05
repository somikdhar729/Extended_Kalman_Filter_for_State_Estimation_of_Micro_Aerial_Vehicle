# Extended_Kalman_Filter_for_State_Estimation_of_Micro_Aerial_Vehicle
This projects implements Extended Kalman Filter for Micro Aerial Vehicle to estimate the position, orientation and velocity. Control inputs are provided from on board IMU and measurement update is obtained from VICON system. The model is being tested on three datasets preprepared for testing.

# Process Flow
1. Developed state space system for the dynamic model
2. Computed the Jacobian to handle the non linearity by approximating around the mean values.
3. Implement discete form of EKF to be implemented in MaATLAB

# Explanation
State Estimation using Extended Kalman Filter with Measurement Model utilizing Position and Orientation from the Vicon system. The vicon data serves as the ground truth for updating the EKF estimates. The process model is essential for predicting the future state based on its current state and control inputs. The process model’s intuition can be broken down into the following components:
• Position, Velocity, and Orientation: The position (X), velocity (V), and orientation (phi, theta, psi) are part
of the state vector.
• Angular Velocity and Acceleration: These are the inputs to the process model.
• Transformation Matrices: The function uses two transformation matrices: G and R. The G matrix transforms the angular velocity from the body frame to the Euler angles’ time derivatives. The R matrix rotates the
acceleration vector from the body frame to the world frame.
• Sensor Biases: The process model considers biases in angular velocity (n_bg) and acceleration (n_ba) measurements. These biases are part of the state vector and are estimated by the EKF.
• State Derivative (x_dot): The state derivative represents the rate of change of the state variables. The process model combines the position, velocity, orientation, and biases, along with the inputs (angular velocity and acceleration) to compute the state derivative.
• Linearized Process Model (A_t) and Noise Input Matrix (U_t): The linearized process model, represented by the Jacobian matrix A_t, captures the partial derivatives of the non-linear process model with respect to
the state variables. U_t is the noise input matrix that links the process noise to the state variables. These matrices are used to propagate the state covariance in the EKF.



The process model captures the system dynamics and provides a basis for predicting its future state. The EKF algorithm then refines these predictions by incorporating the measurements from the Vicon system, resulting in improved state estimation. The primary goal of this step is to incorporate the measurements obtained from the Vicon system into the EKF to correct the predicted state and covariance of the system. The intuition can be explained through the following components: 
• Measurement (z_t): The measurement vector z_t contains the data from the Vicon system, which serves as the ground truth. z_t contains position and orientation measurements.
• Predicted State and Covariance (uEst and covarEst): These variables are the outputs from the prediction step of the EKF algorithm. They represent the predicted state of the system and the associated uncertainty (covariance). 
• Measurement Model (C_t): The matrix C_t represents the linearized measurement model, which captures the relationship between the true state of the system and the measurements. In this case, C_t is a matrix that selects the position, orientation components from the state vector.

