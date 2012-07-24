function dDCM = DCM_derivative(wx,wy,wz,A)
  if isempty(A)
    A = eye(3);
  end
  
  dA = [0, -wz, wy;
        wz, 0, -wx;
        -wy, wx, 0];
    
  dDCM = dA*A;
end