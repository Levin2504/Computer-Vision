% import images as real1, real2, real3, real4 first

I1 = zeros(460,460);
I2 = zeros(460,460);
I3 = zeros(460,460);
I4 = zeros(460,460);


for i=drange(1:460)
    for j=drange(1:460)
        I1(i,j)=double(real1(i,j))/255;
        I2(i,j)=double(real2(i,j))/255;
        I3(i,j)=double(real3(i,j))/255;
        I4(i,j)=double(real4(i,j))/255;
    end
end

I = {460,460};

for i=drange(1:460)
    for j=drange(1:460)
        I{i,j}=[I1(i,j),I2(i,j),I4(i,j)]';    
    end
end

v1=[0.38359,0.236647,0.89266];
v2=[0.372825,-0.303914,0.87672];
v3=[-0.250814,-0.34752,0.903505];
v4=[-0.203844,0.096308,0.974255];

v1=v1/norm(v1);
v2=v2/norm(v2);
v3=v3/norm(v3);
v4=v4/norm(v4);
V=[v1;v2;v4];

g={460,460};
N={460,460};
p=zeros(460,460);
q=zeros(460,460);
Rho=zeros(460,460);

for i=drange(1:460)
    for j=drange(1:460)
        g{i,j}=linsolve(V,I{i,j});
        Rho(i,j)=norm(g{i,j});
        N{i,j}=g{i,j}/Rho(i,j);
        p(i,j)=N{i,j}(1)/N{i,j}(3);
        q(i,j)=N{i,j}(2)/N{i,j}(3);
    end
end

Z=zeros(460,460);

for i=drange(2,460)
    Z(i,1)=Z(i-1,1)+q(i,1);
end

for i=drange(1:460)
    for j=drange(2:460)
        Z(i,j)=Z(i,j-1)+p(i,j);
    end
end

x=1:460;
y=1:460;

for i=drange(1:460)
    for j=drange(1:460)
        if Z(i,j)>0        
        Z(i,j)=0;
        end
    end
end

mesh(-Z(x,y));
figure();
mesh(Rho(x,y));

figure();

xvector=zeros(460,460);
yvector=zeros(460,460);

for i = drange(1:460)
    for j = drange(1:460)
        xvector(i,j) = N{i,j}(1);
        yvector(i,j) = N{i,j}(2);
    end
end

quiver(x,y,xvector(x,y),yvector(x,y));

axis tight;
axis square;