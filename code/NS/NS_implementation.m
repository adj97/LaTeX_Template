%% Script to implement the Nagel - Schreckenberg Model
%  As described in Nagel and Schreckenberg (1992 J.Phys)
%
% Andrew Dixon
% Cranfield University 26/04/2019

%% Setup
    clear all                                  % clear variables
    close all                                  % close figures
    clc                                        % clear command window
    set(0,'DefaultFigureWindowStyle','docked') % dock figures

%% Define model parameters and Initialise
    % Model Parameters
        % Simulation iterations
            its=300;

        % Length of 'road' in number of cells
            ncell=100;
        % number of cars
            ncar=50;

        % Limit velocity
            maxvel=5;

        % Human random braking effect
        % p = probability of a random decelleration
            p=0.5;
            
    % Initialise for Simulation
        % Animation playback frame time
        % No playback for 0
            pause_length=0.01;

        % Initialize arrays
            % Speeds are random integers in [0,maxvel]
                speed=datasample(0:maxvel,ncar);
            % Positions is an array to save history
            % Allocate ncar cars to a unique cell
                position=zeros(its+1,ncar);
                position(1,:)=sort(randperm(ncell,ncar));

        % Plot initial formation on a circle
            % Radius
                r=1;
            % Calculate angles
                theta=2*pi*position(1,:)/ncell;
            % Polar tranformation
                x=r*cos(theta);
                y=r*sin(theta);
            % Plot points
                plot(x,y,'ko','markerfacecolor','k')
                drawCircle(r+0.05)
                drawCircle(r-0.05)
                box off
                xlim([-r r]*1.2)
                ylim([-r r]*1.2)
                pbaspect([1 1 1])

%% Iterate
% Loop over the N-S algorithm for its iterations

for it=1:its

    %%%%%%%%%%%%%%%%%%%%%%%% Algorithm Steps %%%%%%%%%%%%%%%%%%%%%%%%
    
    % 1 Acceleration
    % Increase car's speeds by 1 if speed is less than max
        for i=1:ncar
            if speed(i)<maxvel
                speed(i)=speed(i)+1;
            end
        end

    % 2 Deceleration
    % Reduce a car's speed if it is close to the car infront
        % Calculate separation distances
            separation=[position(it,[2:ncar])-1-position(it,[1:ncar-1]) ncell-position(it,ncar)-1+position(it,1)];

        % If separation length is less than the speed
        % Then the next step would cause the trailing car to overlap
        % Fix trailing car speed to move to the space behind
            for i=1:ncar
                if separation(i)<speed(i)
                    speed(i)=separation(i);
                end
            end

    % 3 Randomization
    % Introduce a random human braking element
        for i=1:ncar
            if speed(i)>0
                speed(i)=speed(i)+randsample([0 -1],1,true,[1-p p]);
            end
        end

    % 4 Car motion
    % Update the car positions according to the corresponding speeds
        for i=1:ncar
            position(it+1,i)=position(it,i)+speed(i);
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%% Algorithm Steps %%%%%%%%%%%%%%%%%%%%%%%%
        
    % Plot positions
        % Polar coordinates translation
            theta=2*pi*position(it+1,:)/ncell;
            x=r*cos(theta);
            y=r*sin(theta);
        % Plot points
            plot(x,y,'ko','markerfacecolor','k')
            drawCircle(r+0.05)
            drawCircle(r-0.05)
            box off
            pbaspect([1 1 1])
            xlim([-r r]*1.2)
            ylim([-r r]*1.2)

    % Pause
        if pause_length~=0
            pause(pause_length)
        end
end


%% Position history plot

figure
hold on
for i=1:ncar
    plot(position(:,i),(0:(-1):(-its)),'k');
end
hold off
xlabel('x')
ylabel('Iteration')
yticks(-its:50:0)
yticklabels(its:(-50):0)

%% Save PDFs

siz=[20 20];
names=[{'physical','waves'}];

for i=1:2
    figure(i);
    set(gcf,'PaperSize',[siz(i),siz(i)]);
    print('-bestfit',names{i},'-dpdf')
end





