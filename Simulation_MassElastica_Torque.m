clc
clear
%M is the applied torque variable%
global M
%parameters
figure 
hold on
angle_in=20;
angle=deg2rad(angle_in);
%initial velocity
v_i=4.008;
%weight of the mass
w=7;
%applied torque limit
at_value=0.4;

%================================== dynamics============================
%initial conditions
time_interval=0:0.001:1;
tResult = [];
zResult = [];
[x_pos,y_pos]=BVPElasticaForce(angle,0,0);
z_initial=[x_pos;y_pos;-v_i;0];
%stop integration when the elastica is straight
StopFun=@StopEvent;
opts=odeset('Events',StopFun,'RelTol',1e-3,'MaxStep',5e-4);

%==========Time integration with applied moment control law==============
M=0;
for index = 2:numel(time_interval)
  % Integrate:
  t=time_interval(index-1:index);
  [t,z]=ode15s(@(t,z)odedynamicsAT(t,z,w),t,z_initial,opts);    % Collect the results:
  tResult = cat(1, tResult, t);
  zResult = cat(1, zResult, z);
  % Final value of x is initial value for next step:
  z_initial = z(end, :);
  
  if index==2
   [~,~,prev_angle_back]=BVPElasticaPos(z(end,1),z(end,2));
  else
    prev_angle_back=prev_angle_front;
  end
  [~,~,prev_angle_front]=BVPElasticaPos(z(end,1),z(end,2));


  if index>=3
      v=(prev_angle_front-prev_angle_back)/0.001;
      if v>0
          M=at_value;
      elseif v<0
          M=-at_value;
      else
          M=0;
      end
  end
  %condition to check if the elastica is straight and horizontal velocity
  %is zero
  if sqrt(z(end,1)^2+z(end,2)^2)>0.999 || z(end,3)>=0
      break;
  end
end
plot(zResult(:,1),zResult(:,2),'k')
%========================================================================

%=================Mass Dynamic===========================================
zm_initial=[zResult(end,1);zResult(end,2);zResult(end,3);zResult(end,4)];
%stop integration when vertical velocity is zero
StopFun2=@StopEvent2;
opts1=odeset('Events',StopFun2,'MaxStep',1e-2);
[tm,zm]=ode45(@(t,z)odeDynamics_Mass_ND(t,z,w),[0 10],zm_initial,opts1);
plot(zm(:,1),zm(:,2))
title([num2str(angle_in) 'deg'])