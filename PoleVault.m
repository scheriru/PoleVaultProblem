IC=[y0;z0;v_i;0];
tspan=[0 5];
w=7;
[t,z]=ode15s(@(t,z)odedynamics(t,z,w),tspan,IC);

function dzdt=odedynamics(t,z,w)

[p,q]=ElasticaDeformation(z(1),z(2));

dzdt=[z(3);z(4);p;q-w];
end

function [p,q]=ElasticaDeformation(x,y)
global L x1 y1

L=1;
x1=x;
y1=y;

%initial guess of p and q
p=0;
q=0;
%unknown parameters
upar=[p;q];

solinit=bvpinit(linspace(0,L,100),@yfun_guess,upar);
sol=bvp4c(@(t,z,upar)odefun(t,z,upar),@bcfun,solinit);
p=sol.parameters(1);
q=sol.parameters(2);
end

function yinit=yfun_guess(x)
global L 

R=L/(pi/4);
%initial guess (part of a circle)
yinit=[x/R;0;R*cos(x/R-pi/2);R+R*sin(x/R-pi/2)];
end

function dzdt=odefun(t,z,upar)


dzdt=[z(2);-upar(2)*sin(z(1))+upar(1)*cos(z(1));cos(z(1));sin(z(1))];
end


function res=bcfun(zleft,zright,upar)

global x1 y1

%Define boundary conditions x1,y1 are location of the mass; x0,y0 are
%zeros; moments are zero at both ends
%total 6 boundary conditions
res=[zleft(2) zleft(3) zleft(4) zright(2) zright(3)-x1 zright(4)-y1];
end

