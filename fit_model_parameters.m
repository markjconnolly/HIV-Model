function fit_model_parameters
clc;

model		= 1;
[P0_var, P0_const]	= get_parameters(model);   

options		= optimset('Display',	'iter',	...
					'MaxIter',		3000,	...
					'MaxFunEvals',	3000,	...
					'TolFun',		1e-5,	...
					'TolX',		1e-5);
					
x			= fminsearch(@model_cost, P0_var, options, model);
[t V]		= HIV_transmission([x P0_const], model);

plot_model_v_data(t,V);
end

