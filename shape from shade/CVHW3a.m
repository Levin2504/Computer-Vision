% import images as im1, im2, im3, im4 first

I1 = zeros(100,100);
I2 = zeros(100,100);
I4 = zeros(100,100);


for i=drange(1:100)
    for j=drange(1:100)
        I1(i,j)=double(im1(i,j))/255;
        I2(i,j)=double(im2(i,j))/255;
        I4(i,j)=double(im4(i,j))/255;
    end
end

I = {100,100};

for i=drange(1:100)
    for j=drange(1:100)
        I{i,j}=[I1(i,j),I2(i,j),I4(i,j)]';    
    end
end

v1=[0,0,1];
v2=[-0.2,0,1];
v4=[0,-0.2,1];

v1=v1/norm(v1);
v2=v2/norm(v2);
v4=v4/norm(v4);

V=[v1;v2;v4];

g={100,100};
N={100,100};
p=zeros(100,100);
q=zeros(100,100);
Rho=zeros(100,100);

for i=drange(1:100)
    for j=drange(1:100)
        g{i,j}=linsolve(V,I{i,j});
        Rho(i,j)=norm(g{i,j});
        N{i,j}=g{i,j}/Rho(i,j);
        p(i,j)=N{i,j}(1)/N{i,j}(3);
        q(i,j)=N{i,j}(2)/N{i,j}(3);
    end
end

Z=zeros(100,100);

for i=drange(2,100)
    Z(i,1)=Z(i-1,1)+q(i,1);
end

for i=drange(1:100)
    for j=drange(2:100)
        Z(i,j)=Z(i,j-1)+p(i,j);
    end
end

x=1:100;
y=1:100;

mesh(-Z(x,y));

figure();

mesh(Rho(x,y));

figure();

xvector=zeros(100,100);
yvector=zeros(100,100);

for i = drange(1:100)
    for j = drange(1:100)
        xvector(i,j) = N{i,j}(1);
        yvector(i,j) = N{i,j}(2);
    end
end

quiver(x,y,xvector(x,y),yvector(x,y));

axis tight;
axis normal;
axis square;