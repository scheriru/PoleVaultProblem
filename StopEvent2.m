function [value, isterminal, direction] = StopEvent2(t,y)

value      = y(4);
isterminal = 1;   % Stop the integration
direction  = 0;
end