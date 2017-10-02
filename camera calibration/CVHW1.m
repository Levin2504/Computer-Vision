P1=[0,34,210,1]';
P2=[0,34,150,1]';
P3=[0,64,90,1]';
P4=[0,94,180,1]';
P5=[64,0,150,1]';
P6=[64,0,210,1]';
P7=[94,0,150,1]';
P8=[124,0,90,1]';

p1=[2680,936,1]';
p2=[2672,1510,1]';
p3=[2872,2130,1]';
p4=[3141,1367,1]';
p5=[1952,1580,1]';
p6=[1935,987,1]';
p7=[1699,1648,1]';
p8=[1458,2290,1]';

% the second image
% p1=[2487,808,1]';
% p2=[2485,1383,1]';
% p3=[2742,1962,1]';
% p4=[3043,1176,1]';
% p5=[1871,1536,1]';
% p6=[1842,924,1]';
% p7=[1694,1634,1]';
% p8=[1508,2337,1]';


zero=[0,0,0,0];

P=[P1',zero,-p1(1)*P1';zero,P1',-p1(2)*P1';
   P2',zero,-p2(1)*P2';zero,P2',-p2(2)*P2';
   P3',zero,-p3(1)*P3';zero,P3',-p3(2)*P3';
   P4',zero,-p4(1)*P4';zero,P4',-p4(2)*P4';
   P5',zero,-p5(1)*P5';zero,P5',-p5(2)*P5';
   P6',zero,-p6(1)*P6';zero,P6',-p6(2)*P6';
   P7',zero,-p7(1)*P7';zero,P7',-p7(2)*P7';
   P8',zero,-p8(1)*P8';zero,P8',-p8(2)*P8';];


[V, D] =eig(P'*P);
m=[V(1,1),V(2,1),V(3,1),V(4,1);
   V(5,1),V(6,1),V(7,1),V(8,1);
   V(9,1),V(10,1),V(11,1),V(12,1)];

disp 'the projection matrix is:';
disp (m);

a1=[V(1,1);V(2,1);V(3,1)];
a2=[V(5,1);V(6,1);V(7,1)];
a3=[V(9,1);V(10,1);V(11,1)];


    e=-1;
    Rho=e/norm(a3);
    r3=Rho*a3;
    x0=Rho^2*dot(a1,a3);
    y0=Rho^2*dot(a2,a3);
        
    theta=acos(-dot(cross(a1,a3),cross(a2,a3))/(norm(cross(a1,a3))*norm(cross(a2,a3))));
    alpha=Rho^2*norm(cross(a1,a3))*sin(theta);
    beta=Rho^2*norm(cross(a2,a3))*sin(theta);    
    
    K=[alpha,-alpha*cot(theta),x0;0,beta/sin(theta),y0;0,0,1];
    
    r1=Rho^2*sin(theta)/beta*cross(a2,a3);
    r2=cross(r3,r1);
    R=[r1,r2,r3];
    
    b=[V(4,1),V(8,1),V(12,1)]';
    t=Rho*inv(K)*b;
    
    
    
    format shortG;
    
    fprintf('\nx0=%d pixel\n',x0);
    fprintf('y0=%d pixel\n',y0);
    fprintf('alpha=%d\n',alpha);
    fprintf('beta=%d\n',beta);
    fprintf('theta=%d\n',theta);
    skew=abs((theta-pi/2)/pi*90);
    fprintf('skew=%d degree\n\n',skew);
    
    disp 'Matrix K:';
    disp (K);
    disp 'Matrix R:';
    disp (R);
    disp 'translation t:';
    disp (t);
    format long;

