function q = qMult(q1,q2)
  Q = [q1(1), -q1(2), -q1(3), -q1(4);
       q1(2),  q1(1), -q1(4),  q1(3);
       q1(3),  q1(4),  q1(1), -q1(2);
       q1(4), -q1(3),  q1(2),  q1(1)];
  
  q = Q*q2;
end