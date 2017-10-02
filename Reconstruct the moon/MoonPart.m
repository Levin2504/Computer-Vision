% import images first
part_b_0001=imread('part-b-0001.png');
part_b_0657=imread('part-b-0657.png');
part_b_1312=imread('part-b-1312.png');
part_b_1968=imread('part-b-1968.png');
part_b_2624=imread('part-b-2624.png');
part_b_3280=imread('part-b-3280.png');

Xpixel=429;
Ypixel=248;

I1 = zeros(Ypixel,Xpixel);
I2 = zeros(Ypixel,Xpixel);
I3 = zeros(Ypixel,Xpixel);
I4 = zeros(Ypixel,Xpixel);
I5 = zeros(Ypixel,Xpixel);
I6 = zeros(Ypixel,Xpixel);


for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
        I1(i,j)=double(part_b_0001(i,j))/255;
        I2(i,j)=double(part_b_0657(i,j))/255;
        I3(i,j)=double(part_b_1312(i,j))/255;
        I4(i,j)=double(part_b_1968(i,j))/255;
        I5(i,j)=double(part_b_2624(i,j))/255;
        I6(i,j)=double(part_b_3280(i,j))/255;
    end
end

I = cell(Ypixel,Xpixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
        I{i,j}=[I1(i,j),I2(i,j),I3(i,j),I4(i,j),I5(i,j),I6(i,j)]';    
    end
end

v1=[-276,121,72.83543094];
v2=[-215,93,203.0960364];
v3=[-102,42,289.7481665];
v4=[29,-15,308.3115308];
v5=[149,-68,263.2432335];
v6=[240,-106,165.1847451];

v1=v1/norm(v1);
v2=v2/norm(v2);
v3=v3/norm(v3);
v4=v4/norm(v4);
v5=v5/norm(v5);
v6=v6/norm(v6);


V=[v1;v2;v3;v4;v5;v6];



g={Ypixel,Xpixel};
N={Ypixel,Xpixel};
p=zeros(Ypixel,Xpixel);
q=zeros(Ypixel,Xpixel);
Rho=zeros(Ypixel,Xpixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)        
        g{i,j}=V\I{i,j};
        Rho(i,j)=norm(g{i,j});
        N{i,j}=g{i,j}/Rho(i,j);
        p(i,j)=N{i,j}(1)/N{i,j}(3);
        q(i,j)=N{i,j}(2)/N{i,j}(3);
    end
end

Z1=zeros(Ypixel,Xpixel);
Z2=zeros(Ypixel,Xpixel);
E=zeros(Ypixel,Xpixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
        if isnan(p(i,j))|| abs(p(i,j))>100 
            p(i,j)=0;
        end
        if isnan(q(i,j))|| abs(q(i,j))>100        
            q(i,j)=0;
        end
    end
end

errorcount =0;
for i=drange(2:Ypixel)
    for j=drange(2:Xpixel)
        E(i,j)=((p(i,j)-p(i-1,j))-(q(i,j)-q(i,j-1)))^2;
%         if E(i,j)>=10
%             E(i,j)=-5;
%             errorcount=errorcount+1;
%         end 
    end
end
errorrate2=errorcount/(Xpixel*Ypixel);
SortE=zeros(1,Xpixel*Ypixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
          SortE((i-1)*Xpixel+j) = E(i,j);
    end
end
SortE=sort(SortE);

for i=drange(2:Ypixel)
    for j=drange(2:Xpixel)
        if E(i,j)<=SortE(floor(Xpixel*Ypixel*0.95))
            E(i,j)=0;
        else
            E(i,j)=1;
        end 
    end
end
for i=drange(2,Ypixel)
    Z1(i,1)=Z1(i-1,1)+q(i,1);
    Z2(i,1)=Z2(i-1,1)+q(i,1);
end

for i=drange(1:Ypixel)
    for j=drange(2:Xpixel)
        Z1(i,j)=Z1(i,j-1)+p(i,j);
        if E(i,j)<=500
            Z2(i,j)=Z2(i,j-1)+p(i,j);
        else
            Z2(i,j)=Z2(i,j-1);
        end
    end
end

x=1:Ypixel;
y=1:Xpixel;

figure();
mesh(E(x,y));
axis tight;
figure();

figure();
surf(-Z2(x,y));

figure();
subplot(1,2,1);
h = fspecial('gaussian');
y = filter2(h, -Z2(x,y));
mesh(y);

subplot(1,2,2);
y2 = filter2(h, y);
mesh(y2);


h = surf(-Z2(x,y));
for i = 1:360; 
    axis manual;
    axis tight;
    rotate(h, [0 0 1], -1); 
    drawnow;
end;

figure();
mesh(Rho(x,y));

figure();

xvector=zeros(Ypixel,Xpixel);
yvector=zeros(Ypixel,Xpixel);

for i = drange(1:Ypixel)
    for j = drange(1:Xpixel)
        xvector(i,j) = N{i,j}(1);
        yvector(i,j) = N{i,j}(2);
    end
end

quiver(y,x,xvector(x,y),yvector(x,y));


axis square;
