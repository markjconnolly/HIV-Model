function [p p_const] = get_parameters(model)

switch model
	case 0
		[p p_const]		= get_parameters_disconnected;
	case 1
		[p p_const]		= get_parameters_connected;		
end

end

% Abbreviations:
% H = high-risk
% L = low-risk
% U = uninfected
% I = infected
% IH = infected, on HAART
function [p_var p_const] = get_parameters_disconnected
	
%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%
k_LU_LI		= 5e-5;		% Average proportional change per year
k_LU_LIH	= 5e-7;		% Decrease by factor of 100
k_HU_HI		= 1.5e-3;	% Average proportional change per year (Table 1.3) 
k_HU_HIH	= 1.5e-5;	% Decrease by factor of 100

%%%%%%%%%%%%%
% Constants %
%%%%%%%%%%%%%

% Between groups
k_LU_HI		= 0;
k_LU_HIH	= 0;
k_HU_LI		= 0;
k_HU_LIH	= 0;

% starting HAART
k_LI_LIH	= 0.05;
k_HI_HIH	= 0.06;

% immigration rates
alpha_LU	= 0.008;
alpha_HU	= 0.002;

% death/emmigration rates
mu_LU		= 0.08;
mu_LI		= 0.006;
mu_LIH		= 0.006;
mu_HU		= 0.07;
mu_HI		= 0.003;
mu_HIH		= 0.003;

% birth rate -- assuming all are in the LU category?
beta_LU		= 0;%.023;

p_var = ...
	[k_LU_LI	...
	k_LU_LIH	...
	k_HU_HI		...
	k_HU_HIH];

p_const =	...
	[k_LU_HI		...
	k_LU_HIH	...
	k_HU_LI		...
	k_HU_LIH	...
	k_LI_LIH	...
	k_HI_HIH	...
	alpha_LU	...
	alpha_HU	...
	mu_LU		...
	mu_LI		...
	mu_LIH		...
	mu_HU		...
	mu_HI		...
	mu_HIH		...
	beta_LU];
end

function [p_var p_const] = get_parameters_connected

%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%

k_LU_LI		= 5e-5;		% Average proportional change per year
k_LU_LIH	= 5e-7;		% Decrease by factor of 100
k_HU_HI		= 1.5e-3;	% Average proportional change per year (Table 1.3) 
k_HU_HIH	= 1.5e-5;	% Decrease by factor of 100

% Between groups
k_LU_HI		= 5e-5;
k_LU_HIH	= 5e-7;
k_HU_LI		= 1.5e-3;
k_HU_LIH	= 1.5e-5;

%%%%%%%%%%%%%%
% Constants  %
%%%%%%%%%%%%%%

% starting HAART
k_LI_LIH	= 0.05;
k_HI_HIH	= 0.06;% TODO

% immigration rates
alpha_LU	= 0.008;
alpha_HU	= 0.002;

% death/emmigration rates
mu_LU		= 0.08;
mu_LI		= 0.006;
mu_LIH		= 0.006;
mu_HU		= 0.07;
mu_HI		= 0.003;
mu_HIH		= 0.003; 

% birth rate -- assuming all are in the LU category?
beta_LU		= 0;%.023;

p_var = ...
	[k_LU_LI	...
	k_LU_LIH	...
	k_HU_HI		...
	k_HU_HIH	...
	k_LU_HI		...
	k_LU_HIH	...
	k_HU_LI		...
	k_HU_LIH];

p_const =	...
	[k_LI_LIH	...
	k_HI_HIH	...
	alpha_LU	...
	alpha_HU	...
	mu_LU		...
	mu_LI		...
	mu_LIH		...
	mu_HU		...
	mu_HI		...
	mu_HIH		...
	beta_LU];
end