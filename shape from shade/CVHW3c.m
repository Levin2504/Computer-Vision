% import images as dog1, dog2, dog3, dog4 first

I1 = zeros(400,400);
I2 = zeros(400,400);
I3 = zeros(400,400);
I4 = zeros(400,400);


for i=drange(1:400)
    for j=drange(1:400)
        I1(i,j)=double(dog1(i,j))/255;
        I2(i,j)=double(dog2(i,j))/255;
        I3(i,j)=double(dog3(i,j))/255;
        I4(i,j)=double(dog4(i,j))/255;
    end
end

I = {400,400};

for i=drange(1:400)
    for j=drange(1:400)
        I{i,j}=[I1(i,j),I2(i,j),I4(i,j)]';    
    end
end

v1=[16,19,30];
v2=[13,16,30];
v3=[-17,10.5,26.5];
v4=[9,-25,4];

v1=v1/norm(v1);
v2=v2/norm(v2);
v3=v3/norm(v3);
v4=v4/norm(v4);
V=[v1;v2;v4];

g={400,400};
N={400,400};
p=zeros(400,400);
q=zeros(400,400);
Rho=zeros(400,400);

for i=drange(1:400)
    for j=drange(1:400)
        g{i,j}=linsolve(V,I{i,j});
        Rho(i,j)=norm(g{i,j});
        N{i,j}=g{i,j}/Rho(i,j);
        p(i,j)=N{i,j}(1)/N{i,j}(3);
        q(i,j)=N{i,j}(2)/N{i,j}(3);
    end
end

Z=zeros(400,400);

for i=drange(1:400)
    for j=drange(1:400)
        if isnan(p(i,j))        
            p(i,j)=0;
        end
        if isnan(q(i,j))        
            q(i,j)=0;
        end
    end
end

for i=drange(2,400)
    Z(i,1)=Z(i-1,1)+q(i,1);
end

for i=drange(1:400)
    for j=drange(2:400)
        Z(i,j)=Z(i,j-1)+p(i,j);
    end
end

x=1:400;
y=1:400;


mesh(-Z(x,y));

figure();
mesh(Rho(x,y));

figure();

xvector=zeros(400,400);
yvector=zeros(400,400);

for i = drange(1:400)
    for j = drange(1:400)
        xvector(i,j) = N{i,j}(1);
        yvector(i,j) = N{i,j}(2);
    end
end

quiver(x,y,xvector(x,y),yvector(x,y));

axis tight;
axis square;