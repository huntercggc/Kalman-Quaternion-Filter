function [q,w,wb] = Kalman_itterate(z)
  % Paramaters:
  % P = State covariance matrix
  % x = State variables
  % z = Measurement
  % u = Input
  % n = Number of itterations
  
  persistent x_est P n;
  
  dt = 1/200;
  
  % Tuning paramaters
  Q = [5, 0, 0, 0, 0, 0, 0, 0, 0, 0;
       0, 5, 0, 0, 0, 0, 0, 0, 0, 0;
       0, 0, 5, 0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 5, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 100, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 100, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 100, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0;
       0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0;
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1];
  
  R = [1000, 0, 0, 0, 0, 0, 0, 0, 0;
       0, 1000, 0, 0, 0, 0, 0, 0, 0;
       0, 0, 1000, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 1000, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 1000, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 1000, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 1000, 0, 0;
       0, 0, 0, 0, 0, 0, 0, 1000, 0;
       0, 0, 0, 0, 0, 0, 0, 0, 1000]; 
   
  % Startup conditions
  % P will converge after a few itterations
  if isempty(P)
    P = eye(length(Q))*10;
     
    x_est = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]';
    
    n = 1;
  else
    n = n+1;    % Good for measuring state covariance convergance
  end
  
  % State vector:
  %   x = [q0;
  %        q1;
  %        q2;
  %        q3;
  %        wx;
  %        wy;
  %        wz;
  %        wxb;
  %        wyb;
  %        wzb];
  
  
  q0 = x_est(1);
  q1 = x_est(2);
  q2 = x_est(3);
  q3 = x_est(4);
  wx = x_est(5);
  wy = x_est(6);
  wz = x_est(7);
  wxb = x_est(8);
  wyb = x_est(9);
  wzb = x_est(10);
  
  % Constants and model specific parameters
  A = [         1, -(dt*wx)/2, -(dt*wy)/2, -(dt*wz)/2, -(dt*q1)/2, -(dt*q2)/2, -(dt*q3)/2, 0, 0, 0;
        (dt*wx)/2,          1, -(dt*wz)/2,  (dt*wy)/2,  (dt*q0)/2,  (dt*q3)/2, -(dt*q2)/2, 0, 0, 0;
        (dt*wy)/2,  (dt*wz)/2,          1, -(dt*wx)/2, -(dt*q3)/2,  (dt*q0)/2,  (dt*q1)/2, 0, 0, 0;
        (dt*wz)/2, -(dt*wy)/2,  (dt*wx)/2,          1,  (dt*q2)/2, -(dt*q1)/2,  (dt*q0)/2, 0, 0, 0;
                0,          0,          0,          0,          1,          0,          0, 0, 0, 0;
                0,          0,          0,          0,          0,          1,          0, 0, 0, 0;
                0,          0,          0,          0,          0,          0,          1, 0, 0, 0;
                0,          0,          0,          0,          0,          0,          0, 1, 0, 0;
                0,          0,          0,          0,          0,          0,          0, 0, 1, 0;
                0,          0,          0,          0,          0,          0,          0, 0, 0, 1];
   
  % ----------------------------
  %  Kalman Filter starts here!
  % ----------------------------
  
  % Model prediction
  x_est = [q0 - (dt*q1*wx)/2 - (dt*q2*wy)/2 - (dt*q3*wz)/2
           q1 + (dt*q0*wx)/2 - (dt*q2*wz)/2 + (dt*q3*wy)/2;
           q2 + (dt*q0*wy)/2 + (dt*q1*wz)/2 - (dt*q3*wx)/2;
           q3 + (dt*q0*wz)/2 - (dt*q1*wy)/2 + (dt*q2*wx)/2;
                                                        wx;
                                                        wy;
                                                        wz;
                                                        wxb;
                                                        wyb;
                                                        wzb];

  % Re-normalize Quaternion
  qnorm = sqrt(x_est(1)^2 + x_est(2)^2 + x_est(3)^2 + x_est(4)^2);
  x_est(1) = x_est(1)/qnorm;
  x_est(2) = x_est(2)/qnorm;
  x_est(3) = x_est(3)/qnorm;
  x_est(4) = x_est(4)/qnorm;
  
  
  % State covariance matrix update based on model
  P = A*P*A' + Q;
  
  % Model and measurement differences
  q0 = x_est(1);
  q1 = x_est(2);
  q2 = x_est(3);
  q3 = x_est(4);
  
  R = [q0^2+q1^2-q2^2-q3^2, 2*(q1*q2-q0*q3), 2*(q1*q3+q0*q2);
       2*(q1*q2+q0*q3), q0^2-q1^2+q2^2-q3^2, 2*(q2*q3-q0*q1);
       2*(q1*q3-q0*q2), 2*(q2*q3+q0*q1), q0^2-q1^2-q2^2+q3^2] * [z(7); z(8); z(9)];
   
  bx = sqrt(R(1)^2 + R(2)^2);
  bz = R(3);
  
  h = [                                      2*q0*q2 - 2*q1*q3;
                                           - 2*q0*q1 - 2*q2*q3;
                                   - q0^2 + q1^2 + q2^2 - q3^2;
                                                      wx + wxb;
                                                      wy + wyb;
                                                      wz + wzb;
       bx*(q0^2 + q1^2 - q2^2 - q3^2) - bz*(2*q0*q2 - 2*q1*q3);
               bz*(2*q0*q1 + 2*q2*q3) - bx*(2*q0*q3 - 2*q1*q2);
       bz*(q0^2 - q1^2 - q2^2 + q3^2) + bx*(2*q0*q2 + 2*q1*q3)];
   
  y = z - h; % + v_k
  
  % The H matrix maps the measurement to the states
  H = [             2*q2,             -2*q3,                2*q0,             -2*q1, 0, 0, 0, 0, 0, 0;
                   -2*q1,             -2*q0,               -2*q3,             -2*q2, 0, 0, 0, 0, 0, 0;
                   -2*q0,              2*q1,                2*q2,             -2*q3, 0, 0, 0, 0, 0, 0;
                       0,                 0,                   0,                 0, 1, 0, 0, 1, 0, 0;
                       0,                 0,                   0,                 0, 0, 1, 0, 0, 1, 0;
                       0,                 0,                   0,                 0, 0, 0, 1, 0, 0, 1;
       2*bx*q0 - 2*bz*q2, 2*bx*q1 + 2*bz*q3, - 2*bx*q2 - 2*bz*q0, 2*bz*q1 - 2*bx*q3, 0, 0, 0, 0, 0, 0;
       2*bz*q1 - 2*bx*q3, 2*bx*q2 + 2*bz*q0,   2*bx*q1 + 2*bz*q3, 2*bz*q2 - 2*bx*q0, 0, 0, 0, 0, 0, 0;
       2*bx*q2 + 2*bz*q0, 2*bx*q3 - 2*bz*q1,   2*bx*q0 - 2*bz*q2, 2*bx*q1 + 2*bz*q3, 0, 0, 0, 0, 0, 0]; 
    
  % Measurement covariance update
  S = H*P*H' + R;
  
  % Calculate Kalman gain
  K = P*H'/S;
  
  % Corrected model prediction
  x_est = x_est + K*y;      % Output state vector
  
  % Re-normalize Quaternion
  qnorm = sqrt(x_est(1)^2 + x_est(2)^2 + x_est(3)^2 + x_est(4)^2);
  x_est(1) = x_est(1)/qnorm;
  x_est(2) = x_est(2)/qnorm;
  x_est(3) = x_est(3)/qnorm;
  x_est(4) = x_est(4)/qnorm;
  
  % Update state covariance with new knowledge
  I = eye(length(P));
  P = (I - K*H)*P;  % Output state covariance
  
  q = [x_est(1);
       x_est(2);
       x_est(3);
       x_est(4)];
   
  w = [x_est(5);
       x_est(6);
       x_est(7)];
   
  wb = [x_est(8);
        x_est(9);
        x_est(10)];
  
  % ----------------------------
  %  Kalman Filter ends here!
  % ----------------------------
  
end