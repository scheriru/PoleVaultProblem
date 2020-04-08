clc
clear
%parameter definition
%initial angle
angle_in=30;
angle=pi/2-deg2rad(angle_in);
figure 
hold on
%initial velocity
v_i=3.23;
%weight of mass
w=6;
%================================== dynamics============================
%initial conditions
[x_pos,y_pos]=BVPElasticaForce(angle,0,0);
z_initial=[x_pos;y_pos;-v_i;0];
tspan=[0 5];
%stop integration when the elastica is straight
StopFun=@StopEvent;
opts=odeset('Events',StopFun,'RelTol',1e-3,'MaxStep',5e-4);
[t,z]=ode15s(@(t,z)odedynamics(t,z,w),tspan,z_initial,opts);
plot(z(:,1),z(:,2),'k')

%mass dynamics
zm_initial=[z(end,1);z(end,2);z(end,3);z(end,4)];
%stop integration when vertical velocity is zero
StopFun2=@StopEvent2;
opts1=odeset('Events',StopFun2,'MaxStep',1e-2);
[tm,zm]=ode45(@(t,z)odeDynamics_Mass_ND(t,z,w),tspan,zm_initial,opts1);
plot(zm(:,1),zm(:,2))
title([num2str(angle_in) 'deg'])



