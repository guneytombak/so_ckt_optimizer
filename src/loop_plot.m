fig_no = gen + 1;

if fig_flag

figure(fig_no);
set(gcf, 'Units', 'Normalized', 'OuterPosition', fig_pos_vec);
legend_cell = {'Erroneous', 'Selecteds', 'Raw'};

subplot(121)

scatter3(wY(:,1),wY(:,2),wY(:,3),'xr');
hold on;
scatter3(sY(:,1),sY(:,2),sY(:,3),'og');
s = scatter3(rY(:,1),rY(:,2),rY(:,3),'.b');

view(AZ,EL);

title(['Real Parameters Gen: ' num2str(gen)]);
xlabel(naming.dimens{1});
ylabel(naming.dimens{2});
zlabel(naming.dimens{3});
legend(legend_cell, 'Location', 'NorthEast');
hold off;

if dataTipFlag

    for k = 1:specs.noXYU(2)
        s.DataTipTemplate.DataTipRows(k).Label = naming.output(k);
    end    
    for k = 1:specs.noXYU(3)
        row = dataTipTextRow(naming.unused(k),rU(:,k));
        s.DataTipTemplate.DataTipRows(specs.noXYU(2)+k) = row;
    end
    for k = 1:specs.noXYU(1)
        row = dataTipTextRow(naming.input(k),rX(:,k));
        s.DataTipTemplate.DataTipRows(specs.noXYU(2)+specs.noXYU(3)+k)=row;
    end

end

subplot(122)

scatter(C, zeros(length(C),1), '.k');
hold on;
scatter(C(sel), zeros(specs.popSize,1), 'og');

mu_C = mean(C(sel));
sigma_C = std(C(sel));

plot([mu_C mu_C], [-.5 .5], '-r'); % mean
plot([(mu_C+sigma_C) (mu_C+sigma_C)], [-.25 .25], '--m'); % mean + sigma
plot([(mu_C-sigma_C) (mu_C-sigma_C)], [-.25 .25], '--m'); % mean - sigma

cost_vec = specs.cost_weight.*(2*(~specs.highY)-1);
sum_cost_vec = sum(cost_vec);

if sum_cost_vec > 0
    xlim([0 sum_cost_vec]);
else
    xlim([sum_cost_vec 0]);  
end

ylim([-1 1]);

xlabel(['Cost: ' num2str(cost_vec)]);
title(['Selection Regarding Cost with T = ' num2str(specs.temp)]);
grid on

legend('Filtered', 'Selecteds', 'Location', 'NorthEast');

hold off;

pause(pause_duration);

end

if (fig_no > act_fig_no) && ishandle(fig_no - act_fig_no)
    close(fig_no - act_fig_no)
end