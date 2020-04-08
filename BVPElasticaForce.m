function [x_disp,y_disp]=BVPElasticaForce(angle,p,q)

L=1;
alpha=angle;

par=[p;q];

solinit=bvpinit(linspace(0,L,100),@(x)yfun_Force(x,L));
sol=bvp4c(@(t,z)odefun_Force(t,z,par),@(zleft,zright)bcfun_Force(zleft,zright,alpha),solinit);

y_disp=sol.y(3,end);
x_disp=sol.y(4,end);

%plot(sol.y(4,:),sol.y(3,:))

function dzdt=odefun_Force(t,z,par)

dzdt=[z(2);-par(2)*sin(z(1))+par(1)*cos(z(1));cos(z(1));sin(z(1))];
end

function yinit=yfun_Force(x,L)

R=L/(pi/4);
yinit=[x/R;0.1;R*cos(x/R-pi/2);R+R*sin(x/R-pi/2)];
end

function res=bcfun_Force(zleft,zright,alpha)


res=[zleft(1)-alpha zleft(2)+0.02 zleft(3) zleft(4)];
end

end