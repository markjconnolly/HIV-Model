% BMED 7013 -- Final Project
function HIV_transmission
% Abbreviations:
% H = high-risk
% L = low-risk
% U = uninfected
% I = infected
% IH = infected, on HAART

clear
clc
close all

t0 = 0;
tf = 3; % years

% Estimated from Table 7.1 -- 2012 data; any 2009 data on this?
H_HAART_use = 0.87;
L_HAART_use = 0.84;

population = 815358; % 2009 census
HI = 14356; % Table 1.3 -- infected, high-risk
LI = 733; % Table 1.3 -- infected, low-risk

% Initial conditions -- San Francisco, 2009
H_I		= HI * (1-H_HAART_use); % MSM, IDU, MSM/IDU
L_I		= LI * (1-L_HAART_use); % heterosexual, transfusion/hemophilia, other
H_IH	= HI * (H_HAART_use);
L_IH	= LI * (L_HAART_use);

U = population - (HI+LI);

% Arbitrary estimates -- where to find this info?
L_U = U * 0.8;
H_U = U * 0.2;


init = [L_U, L_I, L_IH, H_U, H_I, H_IH];
p = get_parameters_disconnected;
[t_disconnected, V_disconnected] = ode45(@(t,y) HIV_transmission_ODEs(t,y,p), [t0, tf], init);

p = get_parameters_connected;
[t_connected, V_connected] = ode45(@(t,y) HIV_transmission_ODEs(t,y,p), [t0, tf], init);

t_real	= 2009:2012;
% t_model = t+2009;
load('data files/HIV Data.mat');

hold on
plot(t_disconnected+2009, sum(V_disconnected(:, 2:3),2), 'k-', 'LineWidth', 2 )
plot(t_connected+2009, sum(V_connected(:, 2:3),2), 'k--', 'LineWidth', 2)
plot(t_real, sum_low_risk, 'LineWidth', 2, 'Color', [ .7 .7 .7])
hold off
xlabel('Year')
ylabel('Population')
legend('Disconnected Model','Connected Model','Actual', 'location', 'NorthWest');
set(gca, 'XTickLabel', {'2009', '', '2010', '','2011', '','2012'})
print('-depsc','-tiff','figures/sum_low_risk.eps');

figure
hold on
plot(t_disconnected+2009, sum(V_disconnected(:, 5:6),2), 'k-', 'LineWidth', 2 )
plot(t_connected+2009, sum(V_connected(:, 5:6),2), 'k--', 'LineWidth', 2)
plot(t_real, sum_high_risk, 'LineWidth', 2, 'Color', [ .7 .7 .7])
hold off
xlabel('Year')
ylabel('Population')
legend('Disconnected Model','Connected Model','Actual','location', 'NorthWest');
set(gca, 'XTickLabel', {'2009', '', '2010', '','2011', '','2012'})
print('-depsc','-tiff','figures/sum_high_risk.eps');


% plot(t, V)
% xlabel('Time (years)')
% ylabel('Population')
% legend('Low-risk, uninfected', 'Low-risk, infected', 'Low-risk, infected on HAART',...
%     'High-risk, uninfected','High-risk, infected','High-risk, infected on HAART')
% 
% figure
% plotyy(t, V(:,[2 3 5 6]),t, V(:,[1 4]))
% xlabel('Time (years)')
% ylabel('Population')
% legend('Low-risk, infected', 'Low-risk, infected on HAART',...
%     'High-risk, uninfected','High-risk, infected','High-risk, infected on HAART')
% figure
% plot(t,sum(V(:,

end

function p = get_parameters_disconnected
	k_LU_LI		= 5e-5;		% Average proportional change per year
	k_LU_LIH	= 5e-7;		% Decrease by factor of 100
	k_HU_HI		= 1.5e-3;	% Average proportional change per year (Table 1.3) 
	k_HU_HIH	= 1.5e-5;	% Decrease by factor of 100
	
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
	
	p = ...
		[k_LU_LI	...
		k_LU_LIH	...
		k_HU_HI		...
		k_HU_HIH	...
		k_LU_HI		...
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

function p = get_parameters_connected
	k_LU_LI		= 5e-5;		% Average proportional change per year
	k_LU_LIH	= 5e-7;		% Decrease by factor of 100
	k_HU_HI		= 1.5e-3;	% Average proportional change per year (Table 1.3) 
	k_HU_HIH	= 1.5e-5;	% Decrease by factor of 100
	
	% Between groups
	k_LU_HI		= 5e-5;
    k_LU_HIH	= 5e-7;
	k_HU_LI		= 1.5e-3;
    k_HU_LIH	= 1.5e-5;

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
	
	p = ...
		[k_LU_LI	...
		k_LU_LIH	...
		k_HU_HI		...
		k_HU_HIH	...
		k_LU_HI		...
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