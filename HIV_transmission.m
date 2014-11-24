% BMED 7013 -- Final Project
function [t V] = HIV_transmission(P_var, model)



time_start			= 0;
time_end			= 3; % years

initial_conditions	= get_initial_conditions();
[~, P_constant]		= get_parameters(model);			

P		= [P_var P_constant];
[t V]	= ode45(@(t,y) HIV_transmission_ODEs(t,y,P), [time_start, time_end], initial_conditions);


end


