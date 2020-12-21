%% Setup 
clc
clear all 
close all
set(0,'DefaultFigureWindowStyle','docked') 

%% Read in
density=dlmread('density.txt');

%% Split a - lengths

L = [45, 45, 26, 25, 13, 13, 45, 45, 17, 10, 23, 23, 6, 7, 7, 7, 7, 7];
L_cumsum = cumsum(L);

%% Split b - density -> colour transform

eps = 1e-5;
maximum_density = max(max(density));
minimum_density = min(min(density));
gamma = (eps*maximum_density-minimum_density)/(eps-1);
density = (density-gamma)/(maximum_density-gamma);

%% Split c - split

r01 = density(:,1:L_cumsum(1));
r02 = density(:,L_cumsum(1)+1:L_cumsum(2));
r03 = density(:,L_cumsum(2)+1:L_cumsum(3));
r04 = density(:,L_cumsum(3)+1:L_cumsum(4));
r05 = density(:,L_cumsum(4)+1:L_cumsum(5));
r06 = density(:,L_cumsum(5)+1:L_cumsum(6));
r07 = density(:,L_cumsum(6)+1:L_cumsum(7));
r08 = density(:,L_cumsum(7)+1:L_cumsum(8));
r09 = density(:,L_cumsum(8)+1:L_cumsum(9));
r10 = density(:,L_cumsum(9)+1:L_cumsum(10));
r11 = density(:,L_cumsum(10)+1:L_cumsum(11));
r12 = density(:,L_cumsum(11)+1:L_cumsum(12));
rcirc = density(:,L_cumsum(12)+1:371);


%% info

[nframes, tot_length]=size(density);

%% Define road lines

eps=0;
circ_r=1-eps;
circ_t=linspace(83*pi/180,83*pi/180+2*pi,41);
circ_x=circ_r*cos(circ_t);
circ_y=circ_r*sin(circ_t);
r01_x=linspace(-0.5,-5,45);
r01_y=-1.1*(r01_x+0.5)+sqrt(3)/2;
r02_x=linspace(-5.2,-sqrt(2)/2,45);
r02_y=-1.1*(r02_x+sqrt(2)/2)+sqrt(2)/2;
r03_x=linspace(-1,-5,26);
r03_y=0.2*(r03_x+1);
r04_x=linspace(-5,-sqrt(15)/4,25);
r04_y=0.2*(r04_x+sqrt(15)/4)-0.25;
r05_x=linspace(-1/4,-1.2,13);
r05_y=2*(r05_x+0.25)-1;
r06_x=linspace(-1,0,13);
r06_y=2*r06_x-1;
r07_x=linspace(0.5,5,45);
r07_y=-1.1*(r07_x-0.5)-sqrt(3)/2;
r08_x=linspace(5.2,sqrt(2)/2,45);
r08_y=-1.1*(r08_x-sqrt(2)/2)-sqrt(2)/2;
r09_x=linspace(1,5,17);
r09_y=0*r09_x;
r10_x=linspace(3,sqrt(15)/4,10);
r10_y=1.25*(r10_x-sqrt(15)/4)+0.25;
r11_x=linspace(0.25,1.4,23);
r11_y=4*(r11_x-0.25)+sqrt(15)/4;
r12_x=linspace(1.15,0,23);
r12_y=4*r12_x+1;

%% Plot map lines

    plot(circ_x,circ_y, 'k')
    hold on
    plot(r01_x,r01_y, 'k')
    plot(r02_x,r02_y, 'k')
    plot(r03_x,r03_y, 'k')
    plot(r04_x,r04_y, 'k')
    plot(r05_x,r05_y, 'k')
    plot(r06_x,r06_y, 'k')
    plot(r07_x,r07_y, 'k')
    plot(r08_x,r08_y, 'k')
    plot(r09_x,r09_y, 'k')
    plot(r10_x,r10_y, 'k')
    plot(r11_x,r11_y, 'k')
    plot(r12_x,r12_y, 'k')
    hold off

    pbaspect([1 1 1])
    axis equal
    box off
    axis off
    
%% Physical Animation

close all
figure

siz = 20;

for i=[1 1:nframes]
    
    plot([-10 -11], [-10 -11])
    
    multicollineplot(circ_x,circ_y,rcirc(i,:))
    multicollineplot(r01_x,r01_y,r01(i,:))
    multicollineplot(r02_x,r02_y,r02(i,:))
    multicollineplot(r03_x,r03_y,r03(i,:))
    multicollineplot(r04_x,r04_y,r04(i,:))
    multicollineplot(r05_x,r05_y,r05(i,:))
    multicollineplot(r06_x,r06_y,r06(i,:))
    multicollineplot(r07_x,r07_y,r07(i,:))
    multicollineplot(r08_x,r08_y,r08(i,:))
    multicollineplot(r09_x,r09_y,r09(i,:))
    multicollineplot(r10_x,r10_y,r10(i,:))
    multicollineplot(r11_x,r11_y,r11(i,:))
    multicollineplot(r12_x,r12_y,r12(i,:))
    
    % colourbar
    multicollineplot(ones(50,1)-8,linspace(-5,5,50),linspace(1e-5,1,50))
    ticks = {0.02,0.04,0.06,0.08,0.1,0.12,0.14,0.16,0.18};
    text(-6.8*ones(9,1),linspace(-4,4,9),ticks)
    strings={sprintf('Max %5.4f',maximum_density),...
             sprintf('Min %5.4f',minimum_density)};
    text([-7 -7],[5.5, -5.5],strings,...
         'HorizontalAlignment','center')
    d=text(-7.5,0,'Density, \rho [cars/km]',...
           'HorizontalAlignment','center');
    set(d,'Rotation',90);
    text(-5.5,-4.5,sprintf('Frame %d, time t=%6.5f[Hrs]',i,i*0.5/nframes))
    text(-5.5,-5,'Riemann solver : Lax-Friedrichs')
    text(-5.5,-5.5,'Reconstruction : First Order') 
    
    xlim([-8 6])
    ylim([-6.5 6.5])
    
    pbaspect([1 1 1])
    axis equal
    box off
    axis off
    
    %pause(0.1)
    
    set(gcf,'PaperSize',[siz,siz]);
    filename=sprintf('frame%04i',i);
    print(filename,'-dpdf')
    
end
