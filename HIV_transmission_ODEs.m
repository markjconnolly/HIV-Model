
function dV = HIV_transmission_ODEs(t, V, p)
    dV = zeros(6,1);
    
    % not grounded in actual numbers yet
    
	%%%%%%%%%%%%%%%%%%%
    % INFECTION RATES %
    %%%%%%%%%%%%%%%%%%%

	% Within group
	k_LU_LI		= p(1);		% Average proportional change per year
	k_LU_LIH	= p(2);		% Decrease by factor of 100
	k_HU_HI		= p(3);	% Average proportional change per year (Table 1.3) 
	k_HU_HIH	= p(4);	% Decrease by factor of 100
	
	% Between groups
	k_LU_HI		= p(5);
    k_LU_HIH	= p(6);
	k_HU_LI		= p(7);
    k_HU_LIH	= p(8);
	
    % starting HAART
    k_LI_LIH	= p(9);
    k_HI_HIH	= p(10);
    
    % immigration rates
    alpha_LU	= p(11);
    alpha_HU	= p(12);
    
    % death/emmigration rates
    mu_LU		= p(13);
    mu_LI		= p(14);
    mu_LIH		= p(15);
    mu_HU		= p(16);
    mu_HI		= p(17);
    mu_HIH		= p(18);
    
    % birth rate -- assuming all are in the LU category?
    beta_LU		= p(19);%.023;
    
    % ODEs -- double check these
	
	LU		= V(1);
	LI		= V(2);
	LIH		= V(3);
	HU		= V(4);
	HI		= V(5);
	HIH		= V(6);

	dLU 	= beta_LU + alpha_LU*LU - mu_LU*LU ...
			- k_LU_LI*LU*LI - k_LU_LIH*LU*LIH - k_LU_HI*LU*HI - k_LU_HIH*LU*HIH;
				
	dLI 	= k_LU_LI*LU*LI + k_LU_LIH*LU*LIH + k_LU_HI*LU*HI + k_LU_HIH*LU*HIH	...
			- k_LI_LIH*LI - mu_LI*LI;
				
	dLIH	= k_LI_LIH*LI - mu_LIH*LIH;
   
	dHU		= alpha_HU*HU - mu_HU*HU ...
			- k_HU_HI*HU*HI - k_HU_HIH*HU*HIH - k_HU_LI*HU*LI - k_HU_LIH*HU*LIH;
	
	dHI 	= k_HU_HI*HU*HI + k_HU_HIH*HU*HIH + k_HU_LI*HU*LI + k_HU_LIH*HU*LIH	...
			- k_HI_HIH*HI - mu_HI*HI;
			
	dHIH	= k_HI_HIH*HI - mu_HIH*HIH;


	
%     dLU = LU*(alpha_LU + beta_LU) ...
%         - LU*(k_LU_LI + k_LU_LIH + k_LU_HI + k_LU_HIH) ...
%         - LU*(mu_LU);
%    
% 	dLI = LU*(k_LU_LI + k_LU_LIH + k_LU_HI + k_LU_HIH) + ...
%         - LI*(k_LI_LIH) ...
%         - LI*(mu_LI);
%     
% 	dLIH = LI*(k_LI_LIH) ...
%          - LIH*(mu_LIH);
%     
% 	dHU = HU*(alpha_HU) ...
%         - HU*(k_HU_LI + k_HU_LIH + k_HU_HI + k_HU_HIH) ...
%         - HU*(mu_HU);
%     
% 	dHI = HU*(k_HU_LI + k_HU_LIH + k_HU_HI + k_HU_HIH) ...
%         - HI*(k_HI_HIH) ...
%         - HI*(mu_HI);
%     
% 	dHIH = HI*(k_HI_HIH) ...
%          - HIH*(mu_HIH);
	
	dV(1) = dLU;
	dV(2) = dLI;
	dV(3) = dLIH;
	dV(4) = dHU;
	dV(5) = dHI;
	dV(6) = dHIH;
	
	
% 	
% 	dV(1) = V(1)*(alpha_LU + beta_LU) - ...
%         V(1)*(k_LU_LI + k_LU_LIH + k_LU_HI + k_LU_HIH) - ...
%         V(1)*(mu_LU);
%     dV(2) = V(1)*(k_LU_LI) + ...
%         V(4)*(k_HU_LI) - ...
%         V(2)*(k_LI_LIH) - ...
%         V(2)*(mu_LI);
%     dV(3) = V(1)*(k_LU_LIH) + ...
%         V(2)*(k_LI_LIH) + ...
%         V(4)*(k_HU_LIH) - ...
%         V(3)*(mu_LIH);
%     dV(4) = V(4)*(alpha_HU) - ...
%         V(4)*(k_HU_LI + k_HU_LIH + k_HU_HI + k_HU_HIH) - ...
%         V(4)*(mu_HU);
%     dV(5) = V(1)*(k_LU_HI) + ...
%         V(4)*(k_HU_HI) - ...
%         V(5)*(k_HI_HIH) - ...
%         V(5)*(mu_HI);
%     dV(6) = V(1)*(k_LU_HIH) + ...
%         V(4)*(k_HU_HIH) + ...
%         V(5)*(k_HI_HIH) - ...
%         V(6)*(mu_HIH);
end

function k_HU_HI = intervention(t)
	if t > 3
		k_HU_HI = 1.5e-3*.1;
	else
		k_HU_HI = 1.5e-3;
	end
end
