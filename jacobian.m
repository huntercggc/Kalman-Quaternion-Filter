syms q0 q1 q2 q3 g bx bz wx wy wz wxb wyb wzb dt real;

q = [q0;
     q1;
     q2;
     q3];

R = [q0^2+q1^2-q2^2-q3^2, 2*(q1*q2-q0*q3), 2*(q1*q3+q0*q2);
    2*(q1*q2+q0*q3), q0^2-q1^2+q2^2-q3^2, 2*(q2*q3-q0*q1);
    2*(q1*q3-q0*q2), 2*(q2*q3+q0*q1), q0^2-q1^2-q2^2+q3^2];

a = [0;
     0;
     -1];
m = [bx;
     0;
     bz];

x = [q;
     wx;
     wy;
     wz;
     wxb;
     wyb;
     wzb];

w = [wx;
     wy;
     wz];
 
Q = q-dt/2*[-q1, -q2, -q3;
q0, q3, -q2;
-q3, q0, q1;
q2, -q1, q0]*w;
 
f = [Q;
     w;
     wxb;
     wyb;
     wzb]
 
h1 = R'*a;
h2 = R'*m;
h = [h1;
     wx+wxb;
     wy+wyb;
     wz+wzb;
     h2]

Ak = jacobian(f,x)
Ck = jacobian(h,x)
