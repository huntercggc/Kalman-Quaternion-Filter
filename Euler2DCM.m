function R = Euler2DCM(x1,x2,x3)
R = [cos(x2)*cos(x3), cos(x1)*sin(x3)+sin(x1)*sin(x2)*cos(x3), sin(x1)*sin(x3)-cos(x1)*sin(x2)*cos(x3);
    -cos(x2)*sin(x3), cos(x1)*cos(x3)-sin(x1)*sin(x2)*sin(x3), sin(x1)*cos(x3)+cos(x1)*sin(x2)*sin(x3);
    sin(x2), -sin(x1)*cos(x2), cos(x1)*cos(x2)];
  