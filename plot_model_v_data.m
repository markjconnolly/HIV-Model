function plot_model_v_data(t, V)

load('data files/HIV Data.mat');

hold on
plot(t+2009, sum(V(:, 2:3),2), 'k-', 'LineWidth', 2 )
plot(t_real, sum_low_risk, 'LineWidth', 2, 'Color', [ .7 .7 .7])
hold off
xlabel('Year')
ylabel('Population')
legend('Model', 'Actual', 'location', 'NorthWest');
set(gca, 'XTickLabel', {'2009', '', '2010', '','2011', '','2012'})
print('-depsc','-tiff','figures/sum_low_risk.eps');

figure
hold on
plot(t+2009, sum(V(:, 5:6),2), 'k-', 'LineWidth', 2 )
plot(t_real, sum_high_risk, 'LineWidth', 2, 'Color', [ .7 .7 .7])
hold off
xlabel('Year')
ylabel('Population')
legend('Model','Actual','location', 'NorthWest');
set(gca, 'XTickLabel', {'2009', '', '2010', '','2011', '','2012'})
print('-depsc','-tiff','figures/sum_high_risk.eps');

end


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

