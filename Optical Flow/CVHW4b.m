toy2 = imread('toy_formatted2.png');
toy3 = imread('toy_formatted3.png');

Xpixel = 534;
Ypixel = 266;


filtered_toy2 = gaussian_filter(toy2, 2.0);
filtered_toy3 = gaussian_filter(toy3, 2.0);

% filtered_toy2 = toy2;
% filtered_toy3 = toy3;

% imshow (filtered_toy2);

deriv_I_t = zeros (Ypixel, Xpixel);
deriv_I_x = zeros (Ypixel, Xpixel);
deriv_I_y = zeros (Ypixel, Xpixel);


for i = 1: Ypixel
    for j = 1: Xpixel
        deriv_I_t(i, j) = filtered_toy3(i,j) - filtered_toy2(i,j);       
    end
end

for i = 1: Ypixel - 1
    for j = 1: Xpixel - 1
        deriv_I_x(i, j) = filtered_toy2(i,j+1) - filtered_toy2(i,j);
        deriv_I_y(i, j) = filtered_toy2(i+1,j) - filtered_toy2(i,j);
    end
end

E = cell(Ypixel,Xpixel);
It = cell(Ypixel,Xpixel);
Flow = cell(Ypixel,Xpixel);

for i = 1: Ypixel - 1
    for j = 1: Xpixel - 1        
        E{i,j}  = [deriv_I_x(i, j),deriv_I_y(i, j); deriv_I_x(i+1, j),deriv_I_y(i+1, j); deriv_I_x(i, j+1),deriv_I_y(i, j+1); deriv_I_x(i+1, j+1),deriv_I_y(i+1, j+1)];
        It{i,j} = [deriv_I_t(i,j);deriv_I_t(i+1,j);deriv_I_t(i,j+1);deriv_I_t(i+1,j+1)];
        [V, D] =eig([E{i,j},It{i,j}]'*[E{i,j},It{i,j}]);
        if V(3,1)==0 || norm ([V(1,1),V(2,1)]/V(3,1)) >= 8
            Flow{i,j} = [0,0];
        else
            Flow{i,j} = [V(1,1),V(2,1)]/V(3,1);
        end
    end
end

NN = zeros(Ypixel,Xpixel);
for i = 1: Ypixel - 1
    for j = 1: Xpixel - 1
        NN(i,j) = norm(Flow{i,j});
    end
end

x=2 : Ypixel;
y=2 : Xpixel;



mesh(NN(x,y));
axis tight;
set(gca,'Ydir','reverse');
% figure();
% mesh(deriv_I_y(x,y));
% axis tight;
% set(gca,'Ydir','reverse');
% figure();
% mesh(deriv_I_t(x,y));
% axis tight;
% set(gca,'Ydir','reverse');


figure();

xvector=zeros(Ypixel,Xpixel);
yvector=zeros(Ypixel,Xpixel);

for i = drange(1:Ypixel)
    for j = drange(1:Xpixel)
        if isnan(Flow{i,j})==0
            xvector(i,j) = Flow{i,j}(1);
            yvector(i,j) = Flow{i,j}(2);
        end
    end
end

imshow (filtered_toy2);
hold on;
quiver(y,x,xvector(x,y),yvector(x,y));
axis tight;
set(gca,'Ydir','reverse');