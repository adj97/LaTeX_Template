%% Setup 
clc
clear all 
close all
set(0,'DefaultFigureWindowStyle','docked') 

%% Read in
density=dlmread('density.txt');

%% Split a - lengths

L = [50, 50, 50, 50,...
     97, 97,...
     48, 32, 32, 48,...
     20, 20, 20, 20,...
     13, 3, 8, 3, 13, 3, 8, 3];
L_cumsum = cumsum(L);

clear L

%% Split b - density -> colour transform

% time trim
%density = density(50:100,:);

eps = 1e-6;
maximum_density = max(max(density));
minimum_density = min(min(density));
gamma = (eps*maximum_density-minimum_density)/(eps-1);
density = (density-gamma)/(maximum_density-gamma);

clear eps gamma

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
r13 = density(:,L_cumsum(12)+1:L_cumsum(13));
r14 = density(:,L_cumsum(13)+1:L_cumsum(14));
r15 = density(:,L_cumsum(14)+1:L_cumsum(15));
r16 = density(:,L_cumsum(15)+1:L_cumsum(16));
r17 = density(:,L_cumsum(16)+1:L_cumsum(17));
r18 = density(:,L_cumsum(17)+1:L_cumsum(18));
r19 = density(:,L_cumsum(18)+1:L_cumsum(19));
r20 = density(:,L_cumsum(19)+1:L_cumsum(20));
r21 = density(:,L_cumsum(20)+1:L_cumsum(21));
r22 = density(:,L_cumsum(21)+1:L_cumsum(22));

clear L_cumsum


%% info

[nframes, tot_length]=size(density);

clear density

%% Define road lines

close all

figure
grid on
grid minor

xmin = -6; xmax = 6;
h = (xmax-xmin)*(603/544)/2;
ymin = -h; ymax = h;

img = imread('map.png');
image('CData',img,'XData',[xmin xmax],'YData',[ymax ymin])

[r01_x,r01_y] = arcpoints([-0.6122;3.858],[-1.04;6.6],80,51);
[r02_x,r02_y] = arcpoints([-0.4098;3.368],[-0.92;6.6],80,51);
[r03_x,r03_y] = arcpoints([0.4289;-3.226],[1.3;-6.6],13,51);
r02_x = fliplr(r02_x); r02_y = fliplr(r02_y);
r03_x = fliplr(r03_x); r03_y = fliplr(r03_y);
[r04_x,r04_y] = arcpoints([0.7903;-4.343],[1.46;-6.6],13,51);
[r05_x,r05_y] = arcpoints([0.4289;-3.226],[-0.6122;3.858],1000,98);
[r06_x,r06_y] = arcpoints([0.7903;-4.343],[-0.4098;3.368],1000,98);
r06_x = fliplr(r06_x); r06_y = fliplr(r06_y);
[r07_xa,r07_ya] = arcpoints([-0.56;0.58],[-0.453;1.237],1,13);
[r07_xb,r07_yb] = arcpoints([-0.6122;3.858],[-0.453;1.237],30,36);
r07_x = [r07_xb,fliplr(r07_xa)];
r07_y = [r07_yb,fliplr(r07_ya)];
[r08_xa,r08_ya] = arcpoints([0.1215;1.259],[-0.4098;3.368],30,24);
[r08_xb,r08_yb] = arcpoints([0.1215;1.259],[0.42;0.6],1,9);
r08_x = [fliplr(r08_xa),r08_xb];
r08_y = [fliplr(r08_ya),r08_yb];
[r09_xa,r09_ya] = arcpoints([-0.09945;-1.105],[0.4289;-3.226],30,24);
[r09_xb,r09_yb] = arcpoints([-0.09945;-1.105],[-0.47;-0.35],1,9);
r09_x = [fliplr(r09_xa),r09_xb];
r09_y = [fliplr(r09_ya),r09_yb];
[r10_xa,r10_ya] = arcpoints([0.57;-0.32],[0.4751;-1.171],1,13);
[r10_xb,r10_yb] = arcpoints([0.7903;-4.343],[0.4751;-1.171],30,36);
r10_x = [r10_xa,fliplr(r10_xb)];
r10_y = [r10_ya,fliplr(r10_yb)];
[r11_xa,r11_ya] = arcpoints([-1.27;0.442],[-0.78;0.4],0.3,6);
[r11_xb,r11_yb] = arcpoints([-2.486;1.569],[-1.27;0.442],8,15);
r11_x = [r11_xb,r11_xa];
r11_y = [r11_yb,r11_ya];
[r12_x,r12_y] = arcpoints([-2.597;1.547],[-0.8;-0.1],15,21);
[r13_x,r13_y] = arcpoints([2.751;-1.193],[0.74;0.376],20,21);
[r14_xa,r14_ya] = arcpoints([1.32;-0.199],[0.74;-0.155],0.4,6);
[r14_xb,r14_yb] = arcpoints([2.663;-1.259],[1.32;-0.199],15,15);
r14_x = [r14_xb,r14_xa];
r14_y = [r14_yb,r14_ya];
[r15_x,r15_y] = arcpoints([0.42;0.6],[-0.56;0.58],1.5,14);
[r16_x,r16_y] = arcpoints([0.74;0.376],[0.42;0.6],0.4,4);
[r17_x,r17_y] = arcpoints([0.74;-0.155],[0.74;0.376],0.4,9);
[r18_x,r18_y] = arcpoints([0.57;-0.32],[0.74;-0.155],0.4,4);
[r19_x,r19_y] = arcpoints([-0.47;-0.35],[0.57;-0.32],1.5,14);
[r20_x,r20_y] = arcpoints([-0.8;-0.1],[-0.47;-0.35],0.4,4);
[r21_x,r21_y] = arcpoints([-0.78;0.4],[-0.8;-0.1],0.4,9);
[r22_x,r22_y] = arcpoints([-0.56;0.58],[-0.78;0.4],0.4,4);

%% Plot map lines

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
    plot(r13_x,r13_y, 'k')
    plot(r14_x,r14_y, 'k')
    plot(r15_x,r15_y, 'k')
    plot(r16_x,r16_y, 'k')
    plot(r17_x,r17_y, 'k')
    plot(r18_x,r18_y, 'k')
    plot(r19_x,r19_y, 'k')
    plot(r20_x,r20_y, 'k')
    plot(r21_x,r21_y, 'k')
    plot(r22_x,r22_y, 'k')
hold off

xlim([xmin xmax]*1.1)
ylim([ymin ymax]*1.1)

%pbaspect([1 1 1])
axis equal
%box off
%axis off

clear h img 
clear r07_xa r07_ya r07_xb r07_yb
clear r08_xa r08_ya r08_xb r08_yb
clear r09_xa r09_ya r09_xb r09_yb
clear r10_xa r10_ya r10_xb r10_yb
clear r11_xa r11_ya r11_xb r11_yb
clear r14_xa r14_ya r14_xb r14_yb

    
%% Physical Animation

close all
figure

siz = 20;
img = imread('map.png');

for i=[408 408:500]
    
    plot([-100 -101],[100 101])
    
    denlineplot(r01_x,r01_y,r01(i,:))
    denlineplot(r02_x,r02_y,r02(i,:))
    denlineplot(r03_x,r03_y,r03(i,:))
    denlineplot(r04_x,r04_y,r04(i,:))
    denlineplot(r05_x,r05_y,r05(i,:))
    denlineplot(r06_x,r06_y,r06(i,:))
    denlineplot(r07_x,r07_y,r07(i,:))
    denlineplot(r08_x,r08_y,r08(i,:))
    denlineplot(r09_x,r09_y,r09(i,:))
    denlineplot(r10_x,r10_y,r10(i,:))
    denlineplot(r11_x,r11_y,r11(i,:))
    denlineplot(r12_x,r12_y,r12(i,:))
    denlineplot(r13_x,r13_y,r13(i,:))
    denlineplot(r14_x,r14_y,r14(i,:))
    denlineplot(r15_x,r15_y,r15(i,:))
    denlineplot(r16_x,r16_y,r16(i,:))
    denlineplot(r17_x,r17_y,r17(i,:))
    denlineplot(r18_x,r18_y,r18(i,:))
    denlineplot(r19_x,r19_y,r19(i,:))
    denlineplot(r20_x,r20_y,r20(i,:))
    denlineplot(r21_x,r21_y,r21(i,:))
    denlineplot(r22_x,r22_y,r22(i,:))
    
    % colourbar
    denlineplot(ones(100,1)*(-4),linspace(-6,6,100),linspace(1e-10,1,99))
        ticks = {0.02    0.04    0.06    0.08    0.10    0.12    0.14    0.16    0.18    0.20    0.22    0.24    0.26};
    text(-3.7*ones(13,1),linspace(-5.1429,5.1429,13),ticks)
    strings={sprintf('Max %5.4f',maximum_density),...
             sprintf('Min %5.4f',minimum_density)};
    text([-4 -4],[6.5, -6.5],strings,...
         'HorizontalAlignment','center')
    d=text(-4.5,0,'Density, \rho [cars/km]',...
           'HorizontalAlignment','center');
    set(d,'Rotation',90);
    text(1,6,sprintf('Frame %d, time t=%6.5f[Hrs]',i,i*2/nframes))
    text(1,5.5,'Riemann solver : Lax-Friedrichs')
    text(1,5,'Reconstruction : First Order')
    
    xlim([xmin xmax])
    ylim([ymin ymax])
    
    pbaspect([1 1 1])
    axis equal
    box off
    axis off
    
    set(gcf,'PaperSize',[siz,siz]);
    filename=sprintf('frame%04i',i);
    print(filename,'-dpdf')
    
end
