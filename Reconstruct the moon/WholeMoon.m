% import images first

moon_0001=imread('moon.0001.jpg');
moon_0657=imread('moon.0657.jpg');
moon_1312=imread('moon.1312.jpg');
moon_1968=imread('moon.1968.jpg');
moon_2624=imread('moon.2624.jpg');
moon_3280=imread('moon.3280.jpg');

Xpixel=730;
Ypixel=730;

I1 = zeros(Ypixel,Xpixel);
I2 = zeros(Ypixel,Xpixel);
I3 = zeros(Ypixel,Xpixel);
I4 = zeros(Ypixel,Xpixel);
I5 = zeros(Ypixel,Xpixel);
I6 = zeros(Ypixel,Xpixel);


for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
        I1(i,j)=double(moon_0001(i,j))/255;
        I2(i,j)=double(moon_0657(i,j))/255;
        I3(i,j)=double(moon_1312(i,j))/255;
        I4(i,j)=double(moon_1968(i,j))/255;
        I5(i,j)=double(moon_2624(i,j))/255;
        I6(i,j)=double(moon_3280(i,j))/255;
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

VV=cell(Ypixel,Xpixel);
I=cell(Ypixel,Xpixel);
thrshd=0.1;
for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
        if I1(i,j)>=thrshd
            I{i,j}=[I{i,j};I1(i,j)];
            VV{i,j}=[VV{i,j};v1];
        end
        if I2(i,j)>=thrshd
            I{i,j}=[I{i,j};I2(i,j)];
            VV{i,j}=[VV{i,j};v2];
        end
        if I3(i,j)>=thrshd
            I{i,j}=[I{i,j};I3(i,j)];
            VV{i,j}=[VV{i,j};v3];
        end
        if I4(i,j)>=thrshd
            I{i,j}=[I{i,j};I4(i,j)];
            VV{i,j}=[VV{i,j};v4];
        end
        if I5(i,j)>=thrshd
            I{i,j}=[I{i,j};I5(i,j)];
            VV{i,j}=[VV{i,j};v5];
        end
        if I6(i,j)>=thrshd
            I{i,j}=[I{i,j};I6(i,j)];
            VV{i,j}=[VV{i,j};v6];
        end     
    end
end


g=cell(Ypixel,Xpixel);
N=cell(Ypixel,Xpixel);
p=zeros(Ypixel,Xpixel);
q=zeros(Ypixel,Xpixel);
Rho=zeros(Ypixel,Xpixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)        
%         g{i,j}=V\I{i,j};
        g{i,j}=VV{i,j}\I{i,j};
        Rho(i,j)=norm(g{i,j});
        N{i,j}=g{i,j}/Rho(i,j);
        if isnan(N{i,j})==0
            p(i,j)=N{i,j}(1)/N{i,j}(3);
            q(i,j)=N{i,j}(2)/N{i,j}(3);
        end
    end
end

Z=zeros(Ypixel,Xpixel);
E=zeros(Ypixel,Xpixel);

for i=drange(1:Ypixel)
    for j=drange(1:Xpixel)
%         if isnan(p(i,j))
        if isnan(p(i,j))|| abs(p(i,j))>100 
            p(i,j)=0;
        end
%         if isnan(q(i,j))
        if isnan(q(i,j))|| abs(q(i,j))>100       
            q(i,j)=0;
        end
    end
end

for i=drange(2,Ypixel)
    Z(i,1)=Z(i-1,1)+q(i,1);
end

for i=drange(1:Ypixel)
    for j=drange(2:Xpixel)
        Z(i,j)=Z(i,j-1)+p(i,j);
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
errorrate1=errorcount/(Xpixel*Ypixel);
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
x=1:Ypixel;
y=1:Xpixel;


mesh(-Z(x,y));
mesh(E(x,y));
axis tight;
figure();

for i=drange(2,Xpixel)
    Z(1,i)=Z(1,i-1)+p(1,i);
end

for i=drange(1:Xpixel)
    for j=drange(2:Ypixel)
        Z(j,i)=Z(j-1,i)+q(j,i);
    end
end

x=1:Ypixel;
y=1:Xpixel;


mesh(-Z(x,y));

figure();

mesh(Rho(x,y));

figure();

xvector=zeros(Ypixel,Xpixel);
yvector=zeros(Ypixel,Xpixel);

for i = drange(1:Ypixel)
    for j = drange(1:Xpixel)
        if isnan(N{i,j})==0
            xvector(i,j) = N{i,j}(1);
            yvector(i,j) = N{i,j}(2);
        end
    end
end

quiver(y,x,xvector(x,y),yvector(x,y));

axis tight;
axis square;