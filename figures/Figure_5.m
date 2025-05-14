%% FIGURE 4

cd('E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\Code&Tables_forStats&Figures_03042025\1_output');

load('CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.mat')
load('CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.mat')
%% CATS - 2 Call Type vs. Dive State Comparison
% Remove rows where Calling column has a value of 0
CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.Calling == 0, :) = [];
% NOW DOWN TO 2,373 so can proceed with only calls

% Get the count of each unique value in DiveStates
diveStateCounts = groupcounts(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly, 'DiveStates');
total_divestate0 = diveStateCounts{1, 2};
total_divestate1 = diveStateCounts{2, 2};
total_divestate2 = diveStateCounts{3, 2};
total_divestate3 = diveStateCounts{4, 2};
total_divestate4 = diveStateCounts{5, 2};

% Convert 'manuscript_classification' to numeric if needed
if iscell(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification) || ...
   isstring(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification) || ...
   iscategorical(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification)
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification = ...
        str2double(string(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification));
end

% Convert 'DiveStates' to numeric if needed
if iscell(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates) || ...
   isstring(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates) || ...
   iscategorical(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates)
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates = ...
        str2double(string(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates));
end

% Count rows where manuscript_classification is 1 AND DiveStates is 0
call_1_divestate_0 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 1 & ...
            CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_1_divestate_1 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_1_divestate_2 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_1_divestate_3 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 3);
call_1_divestate_4 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 4);

call_15_divestate_0 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 15 & ...
            CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_15_divestate_1 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 15 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_15_divestate_2 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 15 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_15_divestate_3 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 15 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 3);
call_15_divestate_4 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 15 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 4);

call_35_divestate_0 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 35 & ...
            CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_35_divestate_1 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 35 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_35_divestate_2 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 35 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_35_divestate_3 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 35 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 3);
call_35_divestate_4 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 35 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 4);

call_7_divestate_0 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 7 & ...
            CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_7_divestate_1 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 7 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_7_divestate_2 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 7 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_7_divestate_3 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 7 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 3);
call_7_divestate_4 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 7 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 4);

call_2i_divestate_0 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 2.1 & ...
            CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_2i_divestate_1 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 2.1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_2i_divestate_2 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 2.1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_2i_divestate_3 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 2.1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 3);
call_2i_divestate_4 = sum(CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.manuscript_classification == 2.1 & ...
    CATSJ1_022023_SNR25_v2_acoustics_kinematics_callsonly.DiveStates == 4);

dv0_1 = call_1_divestate_0/total_divestate0;
dv0_15 = call_15_divestate_0/total_divestate0;
dv0_35 = call_35_divestate_0/total_divestate0;
dv0_7 = call_7_divestate_0/total_divestate0;
dv0_2i = call_2i_divestate_0/total_divestate0;

dv1_1 = call_1_divestate_1/total_divestate1;
dv1_15 = call_15_divestate_1/total_divestate1;
dv1_35 = call_35_divestate_1/total_divestate1;
dv1_7 = call_7_divestate_1/total_divestate1;
dv1_2i = call_2i_divestate_1/total_divestate1;

dv2_1 = call_1_divestate_2/total_divestate2;
dv2_15 = call_15_divestate_2/total_divestate2;
dv2_35 = call_35_divestate_2/total_divestate2;
dv2_7 = call_7_divestate_2/total_divestate2;
dv2_2i = call_2i_divestate_2/total_divestate2;

dv3_1 = call_1_divestate_3/total_divestate3;
dv3_15 = call_15_divestate_3/total_divestate3;
dv3_35 = call_35_divestate_3/total_divestate3;
dv3_7 = call_7_divestate_3/total_divestate3;
dv3_2i = call_2i_divestate_3/total_divestate3;

dv4_1 = call_1_divestate_4/total_divestate4;
dv4_15 = call_15_divestate_4/total_divestate4;
dv4_35 = call_35_divestate_4/total_divestate4;
dv4_7 = call_7_divestate_4/total_divestate4;
dv4_2i = call_2i_divestate_4/total_divestate4;
               
call_dive_matrix =[dv0_1, dv0_15, dv0_35, dv0_7, dv0_2i;
                    dv1_1, dv1_15, dv1_35, dv1_7, dv1_2i;
                    dv2_1, dv2_15, dv2_35, dv2_7, dv2_2i;
                    dv3_1, dv3_15, dv3_35, dv3_7, dv3_2i;];

figure();
b = bar(call_dive_matrix, 'grouped');  % Assuming call_dive_matrix is your data matrix

% Define category labels
categories_cd = {'0', '1', '2', '3'};
set(gca, 'XTickLabel', categories_cd);  % Set x-axis labels
xlabel('Dive State');
ylabel('Proportion of Calls');
set(gca,'FontSize',12)

% Define colors for each category
group_colors = [
    0.102, 0.380, 0.345;  % #1A6158
    0.165, 0.616, 0.561;  % #2A9D8F
    0.243, 0.800, 0.733;  % #3ECCBB
    0.557, 0.882, 0.843;  % #8EE1D7
    0.812, 0.949, 0.933]; % #CFF2EE

% Apply colors to each group in the grouped bar plot
for i = 1:length(b)
    b(i).FaceColor = 'flat';  % Use flat coloring
    b(i).CData = repmat(group_colors(i, :), size(call_dive_matrix, 1), 1);  % Apply color for each group
end

% Add a legend
legend(b, {'Call Type 1', 'Call Type 15', 'Call Type 35', 'Call Type 7', 'Call Type 2i'}, 'Location', 'northeast');  % Modify legend labels as needed
titleHandle = title('HIPc0706');  % Add title
set(titleHandle, 'FontSize', 16);  % Increase title font size (adjust as needed)

% Save the figure
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig_4a_v2.png');
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig_4a_v2.fig');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save table summary
% Define row and column labels
row_labels = {'divestate_0', 'divestate_1', 'divestate_2', 'divestate_3'};
column_labels = {'Calltype_1', 'Calltype_15', 'Calltype_35', 'Calltype_7', 'Calltype_2i'};

% Convert matrix to a table with row and column labels
tag_divestate_table = array2table(call_dive_matrix, 'RowNames', row_labels, 'VariableNames', column_labels);

% Save the table to a CSV file (optional)
writetable(tag_divestate_table, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig4a_divestate_table.csv');
% HAVE TO MANUALLY ADD ROW LABELS.
%% Dive profile [Zoom In]

load('CATSJ1_022023_SNR25_v2_acoustics_kinematics.mat')
load('CATSJ4_102024_SNR40_v2_acoustics_kinematics.mat')
%% 

CATSJ1_022023_SNR25_v2_acoustics_kinematics.manuscript_classification = str2double(CATSJ1_022023_SNR25_v2_acoustics_kinematics.manuscript_classification);
% Time index conversions
time_index_s = (CATSJ1_022023_SNR25_v2_acoustics_kinematics.PRHIndex / 10);
time_index_m = time_index_s / 60;
time_index_h = time_index_m / 60;

% PLOTTING
figure()
plot(time_index_h, CATSJ1_022023_SNR25_v2_acoustics_kinematics.Depth, 'k', 'LineWidth', 1); % Dive profile
set(gca, 'YDir', 'reverse'); % Reverse the Y axis

hold on;

% Plot each call type with different markers
plot(time_index_h(CATSJ1_022023_SNR25_v2_acoustics_kinematics.manuscript_classification == 1), ...
     CATSJ1_022023_SNR25_v2_acoustics_kinematics.Depth(CATSJ1_022023_SNR25_v2_acoustics_kinematics.manuscript_classification == 1), ...
     'o', 'MarkerSize', 5, 'MarkerFaceColor', '#1A6158', 'MarkerEdgeColor', '#1A6158'); 

% Display the graph
grid on;
xlim([0, 6]);
% Add labels and title
xlabel('Time (Hr)');
ylabel('Depth (m)');
title('HIPc0706 - Call Type 1');
legend('off')
set(gcf, 'Position', [100, 100, 300, 300]); % Set the figure size: [left, bottom, width, height]
%% CATS - 4 Call Type vs. Dive State Comparison
% Remove rows where Calling column has a value of 0
CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.Calling == 0, :) = [];
% NOW DOWN TO 2,373 so can proceed with only calls

% Get the count of each unique value in DiveStates
diveStateCounts = groupcounts(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly, 'DiveStates');
total_divestate0 = diveStateCounts{1, 2};
total_divestate1 = diveStateCounts{2, 2};
total_divestate2 = diveStateCounts{3, 2};
total_divestate3 = diveStateCounts{4, 2};

% Convert 'manuscript_classification' to numeric if needed
if iscell(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification) || ...
   isstring(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification) || ...
   iscategorical(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification)
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification = ...
        str2double(string(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification));
end

% Convert 'DiveStates' to numeric if needed
if iscell(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates) || ...
   isstring(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates) || ...
   iscategorical(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates)
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates = ...
        str2double(string(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates));
end

% Count rows where manuscript_classification is 1 AND DiveStates is 0
call_28_divestate_0 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 28 & ...
            CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_28_divestate_1 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 28 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_28_divestate_2 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 28 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_28_divestate_3 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 28 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 3);

call_10_divestate_0 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 10 & ...
            CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_10_divestate_1 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 10 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_10_divestate_2 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 10 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_10_divestate_3 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 10 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 3);

call_39_divestate_0 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 39 & ...
            CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_39_divestate_1 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 39 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_39_divestate_2 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 39 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_39_divestate_3 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 39 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 3);

call_38_divestate_0 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 38 & ...
            CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_38_divestate_1 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 38 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_38_divestate_2 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 38 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_38_divestate_3 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 38 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 3);

call_29_divestate_0 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 29 & ...
            CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 0);
call_29_divestate_1 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 29 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 1);
call_29_divestate_2 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 29 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 2);
call_29_divestate_3 = sum(CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.manuscript_classification == 29 & ...
    CATSJ4_102024_SNR40_v2_acoustics_kinematics_callsonly.DiveStates == 3);


dv0_28 = call_28_divestate_0/total_divestate0;
dv0_10 = call_10_divestate_0/total_divestate0;
dv0_39 = call_39_divestate_0/total_divestate0;
dv0_38 = call_38_divestate_0/total_divestate0;
dv0_29 = call_29_divestate_0/total_divestate0;

dv1_28 = call_28_divestate_1/total_divestate1;
dv1_10 = call_10_divestate_1/total_divestate1;
dv1_39 = call_39_divestate_1/total_divestate1;
dv1_38 = call_38_divestate_1/total_divestate1;
dv1_29 = call_29_divestate_1/total_divestate1;

dv2_28 = call_28_divestate_2/total_divestate2;
dv2_10 = call_10_divestate_2/total_divestate2;
dv2_39 = call_39_divestate_2/total_divestate2;
dv2_38 = call_38_divestate_2/total_divestate2;
dv2_29 = call_29_divestate_2/total_divestate2;

dv3_28 = call_28_divestate_3/total_divestate3;
dv3_10 = call_10_divestate_3/total_divestate3;
dv3_39 = call_39_divestate_3/total_divestate3;
dv3_38 = call_38_divestate_3/total_divestate3;
dv3_29 = call_29_divestate_3/total_divestate3;

call_dive_matrix2 =[dv0_28, dv0_10, dv0_39, dv0_38, dv0_29;
                    dv1_28, dv1_10, dv1_39, dv1_38, dv1_29;
                    dv2_28, dv2_10, dv2_39, dv2_38, dv2_29;
                    dv3_28, dv3_10, dv3_39, dv3_38, dv3_29;];

figure();
b = bar(call_dive_matrix2, 'grouped');  % Assuming call_dive_matrix is your data matrix

% Define category labels
categories_cd = {'0', '1', '2', '3'};
set(gca, 'XTickLabel', categories_cd);  % Set x-axis labels
xlabel('Dive State');
ylabel('Proportion of Calls');
ylim([0 0.85])
set(gca,'FontSize',12)

% Define colors for each category
% Define the colors
group_colors2 = [
    0.905, 0.435, 0.318;  % #E76F51
    0.973, 0.822, 0.788;  % #F8D2C9
    0.941, 0.654, 0.576;  % #F0A693
    0.884, 0.302, 0.159;  % #E24D28
    0.706, 0.216, 0.094];  % #B43718

% Apply colors to each group in the grouped bar plot
for i = 1:length(b)
    b(i).FaceColor = 'flat';  % Use flat coloring
    b(i).CData = repmat(group_colors2(i, :), size(call_dive_matrix, 1), 1);  % Apply color for each group
end

% Add a legend
legend(b, {'Call Type 28', 'Call Type 10', 'Call Type 39', 'Call Type 38', 'Call Type 29'}, 'Location', 'northeast');  % Modify legend labels as needed
titleHandle = title('HIPc0805');  % Add title
set(titleHandle, 'FontSize', 16);  % Increase title font size (adjust as needed)
% Save the figure
saveas(gcf, 'tag4_calltype_divestate.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save table summary
% Define row and column labels
row_labels2 = {'divestate_0', 'divestate_1', 'divestate_2', 'divestate_3'};
column_labels2 = {'Calltype_28', 'Calltype_10', 'Calltype_39', 'Calltype_38', 'Calltype_29'};

% Convert matrix to a table with row and column labels
tag_divestate_table2 = array2table(call_dive_matrix2, 'RowNames', row_labels, 'VariableNames', column_labels);

% Save the table to a CSV file (optional)
writetable(tag_divestate_table2, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig4b_divestate_table.csv');
% HAVE TO MANUALLY ADD ROW LABELS.
%% Dive profile [Zoom In]
CATSJ4_102024_SNR40_v2_acoustics_kinematics.manuscript_classification = str2double(CATSJ4_102024_SNR40_v2_acoustics_kinematics.manuscript_classification);
% Time index conversions
time_index_s = (CATSJ4_102024_SNR40_v2_acoustics_kinematics.PRHIndex / 10);
time_index_m = time_index_s / 60;
time_index_h = time_index_m / 60;

% PLOTTING
figure()
plot(time_index_h, CATSJ4_102024_SNR40_v2_acoustics_kinematics.Depth, 'k', 'LineWidth', 1); % Dive profile
set(gca, 'YDir', 'reverse'); % Reverse the Y axis

hold on;

% Plot each call type with different markers
plot(time_index_h(CATSJ4_102024_SNR40_v2_acoustics_kinematics.manuscript_classification == 10), ...
     CATSJ4_102024_SNR40_v2_acoustics_kinematics.Depth(CATSJ4_102024_SNR40_v2_acoustics_kinematics.manuscript_classification == 10), ...
     'o', 'MarkerSize', 5, 'MarkerFaceColor', '#F8D2C9', 'MarkerEdgeColor', '#F8D2C9'); 

% Display the graph
grid on;
xlim([0, 6]);
% Add labels and title
xlabel('Time (Hr)');
ylabel('Depth (m)');
title('HIPc0805 - Call Type 10');
legend('off')
set(gcf, 'Position', [100, 100, 300, 300]); % Set the figure size: [left, bottom, width, height]
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig_4b_v2.png');
saveas(gcf, 'E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\figures\Figure4_calls_dive\Fig_4b_v2.fig');