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
 
Q = q+dt/2*[-q1, -q2, -q3;
q0, q3, -q2;
-q3, q0, q1;
q2, -q1, q0]*w
 
f = [q0 - (dt*q1*wx)/2 - (dt*q2*wy)/2 - (dt*q3*wz)/2;
     q1 + (dt*q0*wx)/2 - (dt*q2*wz)/2 + (dt*q3*wy)/2;
     q2 + (dt*q0*wy)/2 + (dt*q1*wz)/2 - (dt*q3*wx)/2;
     q3 + (dt*q0*wz)/2 - (dt*q1*wy)/2 + (dt*q2*wx)/2;
     wx;
     wy;
     wz;
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
