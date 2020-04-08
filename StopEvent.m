function [value, isterminal, direction] = StopEvent(t,y)

value      = [y(3); round(sqrt(y(1)^2+y(2)^2),3)-1];
isterminal = [1;1];   % Stop the integration
direction  = [0;1];
end