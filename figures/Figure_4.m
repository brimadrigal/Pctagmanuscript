%% FIGURE 3 - Get the count of each unique value in DiveStates
cd('E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\Code&Tables_forStats&Figures_03042025\1_output');

load('CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.mat')
load('CATSJ1_102024_SNR29_v2_acoustics_kinematics_callsonly.mat')
load('CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.mat')

diveStateCounts_pc230215 = groupcounts(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly, 'DiveStates');
pc230215_J1_divestate0 = diveStateCounts_pc230215{1, 2};
pc230215_J1_divestate1 = diveStateCounts_pc230215{2, 2};
pc230215_J1_divestate2 = diveStateCounts_pc230215{3, 2};
pc230215_J1_divestate3 = diveStateCounts_pc230215{4, 2};

pc230215_J1_total_calls = height(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly);

dv0_tag2 = pc230215_J1_divestate0/pc230215_J1_total_calls;
dv1_tag2 = pc230215_J1_divestate1/pc230215_J1_total_calls;
dv2_tag2 = pc230215_J1_divestate2/pc230215_J1_total_calls;
dv3_tag2 = pc230215_J1_divestate3/pc230215_J1_total_calls;
%%%
diveStateCounts_pc241001_J1 = groupcounts(CATSJ1_102024_SNR29_v2_acoustics_kinematics_callsonly, 'DiveStates');
pc241001_J1_divestate0 = diveStateCounts_pc241001_J1{1, 2};
pc241001_J1_divestate1 = diveStateCounts_pc241001_J1{2, 2};
pc241001_J1_divestate2 = diveStateCounts_pc241001_J1{3, 2};
pc241001_J1_divestate3 = diveStateCounts_pc241001_J1{4, 2};

pc241001_J1_total_calls = height(CATSJ1_102024_SNR29_v2_acoustics_kinematics_callsonly);

dv0_tag3 = pc241001_J1_divestate0/pc241001_J1_total_calls;
dv1_tag3 = pc241001_J1_divestate1/pc241001_J1_total_calls;
dv2_tag3 = pc241001_J1_divestate2/pc241001_J1_total_calls;
dv3_tag3 = pc241001_J1_divestate3/pc241001_J1_total_calls;
%%%

diveStateCounts_pc241001_J4 = groupcounts(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly, 'DiveStates');
pc241001_J4_divestate0 = diveStateCounts_pc241001_J4{1, 2};
pc241001_J4_divestate1 = diveStateCounts_pc241001_J4{2, 2};
pc241001_J4_divestate2 = diveStateCounts_pc241001_J4{3, 2};
pc241001_J4_divestate3 = diveStateCounts_pc241001_J4{4, 2};

pc241001_J4_total_calls = height(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly);

dv0_tag4 = pc241001_J4_divestate0/pc241001_J4_total_calls;
dv1_tag4 = pc241001_J4_divestate1/pc241001_J4_total_calls;
dv2_tag4 = pc241001_J4_divestate2/pc241001_J4_total_calls;
dv3_tag4 = pc241001_J4_divestate3/pc241001_J4_total_calls;
%%%  
tag_divestate_matrix =[dv0_tag2, dv1_tag2, dv2_tag2, dv3_tag2;
                        dv0_tag3, dv1_tag3, dv2_tag3, dv3_tag3;
                        dv0_tag4, dv1_tag4, dv2_tag4, dv3_tag4];
                    
rgbMatrix = [
168, 218, 220;  % #A8DADC
69, 123, 157;   % #457B9D
29, 53, 87;     % #1D3557
230, 57, 70     % #E63946
] / 255;  % Normalize to [0,1] range

figure();
categories_divestates = {'HIPc0706', 'HIPc0265', 'HIPc0805'};
b = bar(tag_divestate_matrix);  % Assuming call_dive_matrix is your data matrix

% Apply colors to each group in the grouped bar plot
for i = 1:length(b)
    b(i).FaceColor = 'flat';  % Use flat coloring
    b(i).CData = repmat(rgbMatrix(i, :), size(tag_divestate_matrix, 1), 1);  % Apply color for each group
end

legend('Dive State 0', 'Dive State 1', 'Dive State 2', 'Dive State 3','location',"northeast");  % Labels for each group
set(gca, 'XTickLabel', categories_divestates);
% Add labels and title
xlabel('Animal');
ylabel('Proportion of Calls');
ylim([0, 0.45]);
% Save the figure
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure3_divestate\Fig_3_v2.png');
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure3_divestate\Fig_3_v2.fig');

% Save table summary
% Define row and column labels
row_labels = {'tag2', 'tag3', 'tag4'};
column_labels = {'DiveState_0', 'DiveState_1', 'DiveState_2', 'DiveState_3'};

% Convert matrix to a table with row and column labels
tag_divestate_table = array2table(tag_divestate_matrix, 'RowNames', row_labels, 'VariableNames', column_labels);

% Save the table to a CSV file (optional)
writetable(tag_divestate_table, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure3_divestate\Fig3_divestate_table.csv');

% HAD TO MANUALLY ENTER IN ROW LABELS (2,3,4) FOR EACH TAG