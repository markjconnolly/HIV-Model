function V0 = get_initial_conditions()
% Abbreviations:
% H = high-risk
% L = low-risk
% U = uninfected
% I = infected
% IH = infected, on HAART

% Estimated from Table 7.1 -- 2012 data; any 2009 data on this?
H_HAART_use = 0.87;
L_HAART_use = 0.84;

population = 815358; % 2009 census
HI			= 14356; % Table 1.3 -- infected, high-risk
LI			= 733; % Table 1.3 -- infected, low-risk

% Initial conditions -- San Francisco, 2009
H_I			= HI * (1-H_HAART_use); % MSM, IDU, MSM/IDU
L_I			= LI * (1-L_HAART_use); % heterosexual, transfusion/hemophilia, other
H_IH		= HI * (H_HAART_use);
L_IH		= LI * (L_HAART_use);

U			= population - (HI+LI);

% Arbitrary estimates -- where to find this info?
L_U			= U * 0.8;
H_U			= U * 0.2;

V0			= [L_U, L_I, L_IH, H_U, H_I, H_IH];
end