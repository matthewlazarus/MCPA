%Matthew Lazarus 100962142

clear all

clearvars
clearvars -GLOBAL
close all

% set(0,'DefaultFigureWindowStyle','docked')
global C

addpath ../geom2d/geom2d

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²

%set initial position (x) and velocity;

numElectrons=2;
dt = 1e-6; %seconds
nTime = 1e-4; %Simulation length
x = zeros(numElectrons, int64(nTime/dt));
v = zeros(numElectrons, int64(nTime/dt));
%Assume constant force is applied?
F=1e-24; 
x(2,1)= 0.5;
a = F/C.m_0;
figure
xlabel('Time (s)')
ylabel('Velocity (m/s)');
%ylabel('Position (m)')
hold on 
for count =  1:(nTime)/dt   
    for c = 1:numElectrons
        if(count~=1)        
            v(c,count) = v(c,count-1) + F/C.m_0;
            if(rand()<0.05)
                v(c,count)=0;
            end    
            x(c,count) = x(c,count-1) + v(c, count)*dt;       
        end
       % plot(count,x, 'b*')    
    end
    pause(0.1)
    driftVelocity = sum(v(1, 1:count-1))/(count-1);
    plot(count, driftVelocity, 'g*');
    plot(count,v(1, count), 'b*') 
    plot(count,v(2, count), 'r*')
    
    
    title(sprintf('Velocity of the electrons. Drift Velocity = %f (m/s)', driftVelocity));
end
hold off

