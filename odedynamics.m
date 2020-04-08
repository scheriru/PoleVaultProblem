
function dzdt=odedynamics(t,z,w)

[p,q]=ElasticaDeformation(z(1),z(2));

dzdt=[z(3);z(4);p;q-w];


function [p,q]=ElasticaDeformation(x,y)

L=1;
%coordinate change
x1=y;
y1=x;

%initial guess of p and q
p=0;
q=0;
%unknown parameters
upar=[p;q];

solinit=bvpinit(linspace(0,L,100),@(x)yfun_guess(x,L),upar);
sol=bvp4c(@(t,z,upar)odefun(t,z,upar),@(zleft,zright,upar)bcfun(zleft,zright,upar,x1,y1),solinit);
p=sol.parameters(1);
q=sol.parameters(2);

%plot(sol.y(4,:),sol.y(3,:),'-k')
end

function yinit=yfun_guess(x,L)

R=L/(pi/4);
%initial guess (part of a circle)
yinit=[x/R;0;R*cos(x/R-pi/2);R+R*sin(x/R-pi/2)];
end

function dzdt=odefun(t,z,upar)

%coordinate change
dzdt=[z(2);-upar(2)*sin(z(1))+upar(1)*cos(z(1));cos(z(1));sin(z(1))];
end


function res=bcfun(zleft,zright,upar,x1,y1)


%Define boundary conditions x1,y1 are location of the mass; x0,y0 are
%zeros; moments are zero at both ends
%total 6 boundary conditions
%pre-bending is added (0.02) to avoid numerical issues
res=[zleft(2)+0.02 zleft(3) zleft(4) zright(2)+0.02 zright(3)-x1 zright(4)-y1];
end
end
