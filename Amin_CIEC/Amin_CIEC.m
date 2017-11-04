function CIE(Spectra_Matrix)
close all;
data=csvread('ciexyz31_1.csv');
colordef('black');
Wl=data(:,1);
Red=data(:,2);
Green=data(:,3);
Blue=data(:,4);
Spectra=Spectra_Matrix;
s=size(data);
ss=size(Spectra);
counter=0;
for i=1:s(1,1)
    for j=1:1:ss(1,1)
        if Wl(i,1)==Spectra(j,1)
            counter=counter+1;
    X(counter,1)=Red(i,1) * Spectra(j,2);
    Y(counter,1)=Green(i,1) * Spectra(j,2);
    Z(counter,1)=Blue(i,1) * Spectra(j,2);
    WLofSpec(counter,1)=Spectra(j,1);
        end
    end
end

figure('name',' Amin''s CIE Calculator - Spectra','numbertitle','off');
plot(Spectra(:,1),Spectra(:,2));
xlabel('Wavelength (nm)');ylabel('Intensity');
hold on;grid on;hold off;
pause(1)
% movegui('northeast');
% plot(Wl,Red,'r',Wl,Green,'g',Wl,Blue,'b');
% hold on;grid on;hold off;
figure('name','CIE 1931','numbertitle','off');
movegui('southeast');
d=imread('CIE1931.png');imshow(d);
title('CIE 1931');
% [height weight m]=size(d);
AreaX=trapz(WLofSpec,X);
AreaY=trapz(WLofSpec,Y);
AreaZ=trapz(WLofSpec,Z);
x=AreaX/(AreaX+AreaY+AreaZ);
y=AreaY/(AreaX+AreaY+AreaZ);
z=AreaZ/(AreaX+AreaY+AreaZ);
hold on;
plot(61+(x*518.75),15+((0.9-y)*517.78),'bo','markerfacecolor','r');
hold off;
u=(4*x)/((-2*x)+(12*y)+3);
pause(1);
v=(9*y)/((-2*x)+(12*y)+3);
pause(1)
figure('name','CIE 1976','numbertitle','off');
movegui('northwest')
r=imread('CIE1976.png');imshow(r);
title('CIE 1976');
hold on;
plot(25+(u*751.67),25+((0.6-v)*750),'bo','markerfacecolor','r');
hold off;
clc;
fprintf(2,'CIE 1931 Values are equal to : x = %f , y = %f\n',x,y);
fprintf('\n');
fprintf(2,'X , Y , Z Values are equal to %g , %g , %g\n',AreaX,AreaY,AreaZ);
fprintf('\n');
fprintf(2,'CIE 1976 Values are equal to : u = %f , v = %f\n',u,v);
fprintf('\n');
fprintf('Good Luck!\n');
% clear Blue Green Red Tot Wl Spectra data d r X Y Z;