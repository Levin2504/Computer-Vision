toy2 = imread('toy_formatted2.png');
toy3 = imread('toy_formatted3.png');

Xpixel = 534;
Ypixel = 266;


filtered_toy2 = gaussian_filter(toy2, 2.0);
filtered_toy3 = gaussian_filter(toy3, 2.0);

% imshow (filtered_toy2);

deriv_I_t = zeros (Ypixel, Xpixel);
deriv_I_x = zeros (Ypixel, Xpixel);
deriv_I_y = zeros (Ypixel, Xpixel);
Normal_Flow = cell(Ypixel,Xpixel);

for i = 1: Ypixel
    for j = 1: Xpixel
        deriv_I_t(i, j) = filtered_toy3(i,j) - filtered_toy2(i,j);       
    end
end

for i = 1: Ypixel - 1
    for j = 1: Xpixel - 1
        deriv_I_x(i, j) = filtered_toy2(i,j+1) - filtered_toy2(i,j);
        deriv_I_y(i, j) = filtered_toy2(i+1,j) - filtered_toy2(i,j);
        Normal_Flow {i, j} = - (double(filtered_toy2(i,j))* [deriv_I_x(i, j), deriv_I_y(i, j)])/ (norm([deriv_I_x(i, j), deriv_I_y(i, j)]))^2;
    end
end

x=2 : Ypixel;
y=2 : Xpixel;

figure();
subplot(2,2,1);
imshow (toy2);
axis tight;
set(gca,'Ydir','reverse');
title('orignal')

subplot(2,2,3);
mesh(deriv_I_x(x,y));
axis tight;
set(gca,'Ydir','reverse');
title('x deriv')

subplot(2,2,4);
mesh(deriv_I_y(x,y));
axis tight;
set(gca,'Ydir','reverse');
title('y deriv')

subplot(2,2,2);
mesh(deriv_I_t(x,y));
axis tight;
set(gca,'Ydir','reverse');
title('t deriv')

figure();

xvector=zeros(Ypixel,Xpixel);
yvector=zeros(Ypixel,Xpixel);

for i = drange(1:Ypixel)
    for j = drange(1:Xpixel)
        if isnan(Normal_Flow{i,j})==0
            xvector(i,j) = Normal_Flow{i,j}(1);
            yvector(i,j) = Normal_Flow{i,j}(2);
        end
    end
end

imshow (toy2);
hold on;
quiver(y,x,xvector(x,y),yvector(x,y));
axis tight;
set(gca,'Ydir','reverse');