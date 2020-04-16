function [value, isterminal, direction] = StopEvent(t,y)

value      = round(sqrt(y(1)^2+y(2)^2),3)-1;
isterminal = 1;   % Stop the integration
direction  = 1;
end
