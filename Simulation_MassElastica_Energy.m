clc
clear
%parameter definition
%initial angle in degrees
angle_in=20;
angle=deg2rad(angle_in);
figure 
hold on
%initial velocity
v_i=3.894;
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
sol=ode15s(@(t,z)odedynamics(t,z,w),tspan,z_initial,opts);
t=linspace(0,sol.x(end),100);
z=deval(sol,t)';

%mass dynamics
zm_initial=[z(end,1);z(end,2);z(end,3);z(end,4)];
%stop integration when vertical velocity is zero
StopFun2=@StopEvent2;
opts1=odeset('Events',StopFun2,'MaxStep',1e-2);
solm=ode45(@(t,z)odeDynamics_Mass_ND(t,z,w),tspan,zm_initial,opts1);
tm=linspace(0,solm.x(end),50);
zm=deval(solm,tm)';

%initial total energy
e_i=0.5*v_i^2+w*sin(angle);
%For energy plot from initial time to when the mass is detached
for n=1:length(t)
    %horizontal kinetic energy
    ke_h(n)=0.5*z(n,3)^2;
    %vertical kinetic energy
    ke_v(n)=0.5*z(n,4)^2;
    %gravitational potential energy
    pe_g(n)=w*z(n,2);
    %strain energy
    [~,~,se(n)]=ElasticaDeformation2(z(n,1),z(n,2));
end
plot(z(:,1),z(:,2),'k')

%For energy plot from the time when the mass is detached to the mass
%reaching max height
for m=1:length(tm)
    %vertical kinetic energy
    ke_m_v(m)=0.5*zm(m,4)^2;
    %gravitational potential energy
    pe_m_g(m)=w*zm(m,2);
end
tm_f=t(end)+tm;
plot(zm(1,:),zm(2,:))
title([num2str(angle_in) 'deg'])

figure
hold on
%energy plot in terms of fraction of the initial energy
plot(t,ke_h/e_i,'r',t,ke_v/e_i,'g',t,pe_g/e_i,'b',t,se/e_i,'c')
legend('ke_h','ke_v','pe_g','se')
plot(tm_f,ke_m_v/e_i,'g',tm_f,pe_m_g/e_i,'b')
