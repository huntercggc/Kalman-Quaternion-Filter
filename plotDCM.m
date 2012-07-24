function [] = plotDCM(R)
  e0 = [0, 0, 0];
  e1 = [1, 0, 0];
  e2 = [0, 1, 0];
  e3 = [0, 0, 1];
  
  arrow3d(e0, e1, 1, 'line');
  arrow3d(e0, e2, 1, 'line');
  arrow3d(e0, e3, 1, 'line');
  
  arrow3d(e0, R(1,:));
  arrow3d(e0, R(2,:));
  arrow3d(e0, R(3,:));
 