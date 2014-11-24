function c = model_cost(P_var, model)

[t V] = HIV_transmission(P_var, model);

load('data files/HIV Data.mat');

sum_low_risk_i		= interp1(0:3, sum_low_risk, t);
sum_high_risk_i		= interp1(0:3, sum_high_risk, t);

sum_low_risk_m		= sum(V(:,2:3),2);
sum_high_risk_m		= sum(V(:,5:6),2);

cost_low			= sum((sum_low_risk_m - sum_low_risk_i).^2); 
cost_high			= sum((sum_high_risk_m - sum_high_risk_i).^2);

c = cost_low + cost_high;
end

