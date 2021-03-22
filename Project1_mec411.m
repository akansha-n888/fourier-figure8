%% Project 1
% 4 bar mechanism that creates a figure-8 curve and error analysis
clear all;
close all;
%% Part I) Define the lengths of the links in cm and independent variables
r1=63.0; % ground link 
r2=27.0; % input link 
r3= 28.0; % coupler 
r4=63.0; % follower 

% Define the position of C with respect to point B
r5=r3;
r6=-r3;
theta21=0:0.0873:6.3705; %!!!!!! USE THIS FOR EXAMPLE 4.5 !!!!
omega2=36.15; %input angular velocity for teta2 rad/s
alpha2=0; %input angular acceleration for teta2 rad/s
%% Part II) Define the angular inputs (in rad or rad/s)
% type of mechanism
% l=1.0; s = 0.2; p = 0.4; q = 1.0;
% l+s = 1.2; p+q = 1.4;
% l+s < p+q --> Grashof crank-rocker mechanism.
%% Calculate non-dimensional ratios (section 4.3.3 of the textbook)
h1=r1/r2;
h2=r1/r3;
h3=r1/r4;
h4=(-r1^2-r2^2-r3^2+r4^2)/(2*r2*r3);
h5=(r1^2+r2^2-r3^2+r4^2)/(2*r2*r4);

% Calculate the position of C w.r.t. B in polar coordinates
rCB=sqrt(r5*r5+r6*r6);
betaC=atan(r6/r5);
%% Divide the crank rotation into 72 divisions; store in array theta21
for i=1:1:73
% Calculations (Section 4.3.3)
 a=-h1+(1+h2)*cos(theta21(i))+h4;
 b=-2*sin(theta21(i));
 c=h1-(1-h2)*cos(theta21(i))+h4;
 d=-h1+(1-h3)*cos(theta21(i))+h5;
 e=h1-(1+h3)*cos(theta21(i))+h5;
 
 % First loop (Eq 4.3-64 & 4.3-65)
 theta31(i)=2*atan((-b-(b^2-4*a*c)^.5)/(2*a));
 theta32(i)=2*atan((-b-(b^2-4*a*c)^.5)/(2*a));
 
 % Position of C with respect of B
 xC(i)=r2*cos(theta21(i))+rCB*cos(theta31(i)+betaC);
 yC(i)=r2*sin(theta21(i))+rCB*sin(theta31(i)+betaC);
 r=sqrt(850*cos(2.*(theta21)).*(sec(theta21)).^4);
 [y,x] = pol2cart(theta21,r);
end

% Week 6 Output
figure;
title('MEC411 Week 6 of Tutorial Winter 2020');
plot(rad2deg(theta21),xC,'b -',rad2deg(theta21),yC,'b --');
xlabel('Theta2(deg)'),ylabel('displacements of C (inches)');
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
h=legend('X-Component of Point P', 'Y-Component of Point P');
axis([0 360 round(min(min(xC),min(yC)))*1.2 round(max(max(xC),max(yC)))*1.5]);
figure;
title('MEC411 Week 6 of Tutorial Winter 2020');
plot(xC - 26.9,yC -14.25,'k-',x,y,'b--')
h=legend('Path of P');
xlabel('X -coordinate (inches)'),ylabel('y - coordinate (inches)');