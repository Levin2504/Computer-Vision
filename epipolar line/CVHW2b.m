B0=30;%mm
f=22;%mm
density=417;%pixel/mm

p1=[3261,1787];
p2=[4794,1757];
p3=[4798,3295];
p4=[3279,3400];
p5=[2802,3130];
p6=[2785,1759];

P1=[3132,1801];
P2=[4670,1777];
P3=[4671,3315];
P4=[3145,3414];
P5=[2690,3143];
P6=[2676,1772];

d1=[P1(1)-p1(1),P1(2)-p1(2)];
d2=[P2(1)-p2(1),P2(2)-p2(2)];
d3=[P3(1)-p3(1),P3(2)-p3(2)];
d4=[P4(1)-p4(1),P4(2)-p4(2)];
d5=[P5(1)-p5(1),P5(2)-p5(2)];
d6=[P6(1)-p6(1),P6(2)-p6(2)];

Z1=B0*f/sqrt(d1(1)^2+d1(2)^2)*density;
Z2=B0*f/sqrt(d2(1)^2+d2(2)^2)*density;
Z3=B0*f/sqrt(d3(1)^2+d3(2)^2)*density;
Z4=B0*f/sqrt(d4(1)^2+d4(2)^2)*density;
Z5=B0*f/sqrt(d5(1)^2+d5(2)^2)*density;
Z6=B0*f/sqrt(d6(1)^2+d6(2)^2)*density;

X1=-Z1*p1(1)/f/density;
X2=-Z2*p2(1)/f/density;
X3=-Z3*p3(1)/f/density;
X4=-Z4*p4(1)/f/density;
X5=-Z5*p5(1)/f/density;
X6=-Z6*p6(1)/f/density;

Y1=-Z1*(p1(2)+(P1(2)-p1(2))/2)/f/density;
Y2=-Z2*(p2(2)+(P2(2)-p2(2))/2)/f/density;
Y3=-Z3*(p3(2)+(P3(2)-p3(2))/2)/f/density;
Y4=-Z4*(p4(2)+(P4(2)-p4(2))/2)/f/density;
Y5=-Z5*(p5(2)+(P5(2)-p5(2))/2)/f/density;
Y6=-Z6*(p6(2)+(P6(2)-p6(2))/2)/f/density;

hold on;

plot3([-X1,-X2],[Y1,Y2],[Z1,Z2]);
plot3([-X2,-X3],[Y2,Y3],[Z2,Z3]);
plot3([-X3,-X4],[Y3,Y4],[Z3,Z4]);
plot3([-X4,-X5],[Y4,Y5],[Z4,Z5]);
plot3([-X5,-X6],[Y5,Y6],[Z5,Z6]);
plot3([-X6,-X1],[Y6,Y1],[Z6,Z1]);
plot3([-X4,-X1],[Y4,Y1],[Z4,Z1]);
xlabel('X');ylabel('Y');zlabel('Z');

axis equal;
