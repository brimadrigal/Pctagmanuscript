%%Chi-square Test
% B.Madrigal

%% Load Data

load('CATSJ1_022023_SNR25_v2_acoustics_kinematics_plotting.mat')
load('CATSJ1_102024_SNR29_v2_acoustics_kinematics_plotting.mat')
load('CATSJ4_102024_SNR40_v2_acoustics_kinematics_plotting.mat')
%% Tag 2 - test if occurence is significantly different in dive state 0 

% Load data (adjust filename as needed)
data = readtable('CATSJ1_022023_SNR25_v2_acoustics_kinematics_plotting.csv');

% Ensure numeric columns
data.Calling = double(data.Calling);
data.DiveStates = double(data.DiveStates);

% Remove rows with missing values
data = data(~isnan(data.Calling) & ~isnan(data.DiveStates), :);

% Define surface (DiveState == 0) and non-surface
surface_rows = data.DiveStates == 0;
non_surface_rows = data.DiveStates ~= 0;

% Count time spent (number of rows)
time_surface = sum(surface_rows);
time_non_surface = sum(non_surface_rows);
total_time = time_surface + time_non_surface;

% Count total number of calls
total_calls = sum(data.Calling == 1);

% Calculate expected number of calls if calls were proportional to time
expected_calls_surface = total_calls * (time_surface / total_time);
expected_calls_non_surface = total_calls * (time_non_surface / total_time);

% Count actual number of calls
actual_calls_surface = sum(data.Calling(surface_rows) == 1);
actual_calls_non_surface = sum(data.Calling(non_surface_rows) == 1);

% Observed and expected vectors
observed = [actual_calls_surface, actual_calls_non_surface];
expected = [expected_calls_surface, expected_calls_non_surface];

% Chi-square test statistic
chi2_stat = sum((observed - expected).^2 ./ expected);

% Degrees of freedom = number of groups - 1
df = length(observed) - 1;

% p-value
p = 1 - chi2cdf(chi2_stat, df);

% Display results
fprintf('\nChi-Square Test Adjusted for Time in Dive States:\n');
fprintf('Observed calls: [Surface = %d, Non-surface = %d]\n', observed(1), observed(2));
fprintf('Expected calls: [Surface = %.2f, Non-surface = %.2f]\n', expected(1), expected(2));
fprintf('Chi-square statistic = %.2f\n', chi2_stat);
fprintf('Degrees of freedom = %d\n', df);
fprintf('p-value = %.5f\n', p);

if p < 0.05
    fprintf('Result: Significant difference in call occurrence for Dive State 0 (surface).\n');
else
    fprintf('Result: No significant difference in call occurrence for Dive State 0 (surface).\n');
end
%% Tag 3 - test if occurence significantly different in dive state 2 

% Load data (adjust path if needed)
data = readtable('CATSJ1_102024_SNR29_v2_acoustics_kinematics_plotting.csv');

% Ensure numeric columns
data.Calling = double(data.Calling);
data.DiveStates = double(data.DiveStates);

% Remove rows with missing values
data = data(~isnan(data.Calling) & ~isnan(data.DiveStates), :);

% Define Dive State 2 and non-Dive State 2
state2_rows = data.DiveStates == 2;
non_state2_rows = data.DiveStates ~= 2;

% Count time spent (number of rows)
time_state2 = sum(state2_rows);
time_non_state2 = sum(non_state2_rows);
total_time = time_state2 + time_non_state2;

% Count total number of calls
total_calls = sum(data.Calling == 1);

% Calculate expected number of calls if calls were proportional to time
expected_calls_state2 = total_calls * (time_state2 / total_time);
expected_calls_non_state2 = total_calls * (time_non_state2 / total_time);

% Count actual number of calls
actual_calls_state2 = sum(data.Calling(state2_rows) == 1);
actual_calls_non_state2 = sum(data.Calling(non_state2_rows) == 1);

% Observed and expected vectors
observed = [actual_calls_state2, actual_calls_non_state2];
expected = [expected_calls_state2, expected_calls_non_state2];

% Chi-square test statistic
chi2_stat = sum((observed - expected).^2 ./ expected);

% Degrees of freedom = number of groups - 1
df = length(observed) - 1;

% p-value
p = 1 - chi2cdf(chi2_stat, df);

% Display results
fprintf('\nChi-Square Test Adjusted for Time in Dive States (Dive State 2):\n');
fprintf('Observed calls: [State 2 = %d, Other = %d]\n', observed(1), observed(2));
fprintf('Expected calls: [State 2 = %.2f, Other = %.2f]\n', expected(1), expected(2));
fprintf('Chi-square statistic = %.2f\n', chi2_stat);
fprintf('Degrees of freedom = %d\n', df);
fprintf('p-value = %.5f\n', p);

if p < 0.05
    fprintf('Result: Significant difference in call occurrence for Dive State 2.\n');
else
    fprintf('Result: No significant difference in call occurrence for Dive State 2.\n');
end

%% Tag 4 - test if occurrence significantly different in dive state 2 

% Load data (adjust path if necessary)
data = readtable('CATSJ4_102024_SNR40_v2_acoustics_kinematics_plotting.csv');

% Ensure numeric columns
data.Calling = double(data.Calling);
data.DiveStates = double(data.DiveStates);

% Remove rows with missing values
data = data(~isnan(data.Calling) & ~isnan(data.DiveStates), :);

% Define Dive State 2 and all other states
state2_rows = data.DiveStates == 2;
non_state2_rows = data.DiveStates ~= 2;

% Time spent (number of rows in each category)
time_state2 = sum(state2_rows);
time_non_state2 = sum(non_state2_rows);
total_time = time_state2 + time_non_state2;

% Total calls in dataset
total_calls = sum(data.Calling == 1);

% Expected number of calls based on time spent in each category
expected_calls_state2 = total_calls * (time_state2 / total_time);
expected_calls_non_state2 = total_calls * (time_non_state2 / total_time);

% Actual observed calls in each category
actual_calls_state2 = sum(data.Calling(state2_rows) == 1);
actual_calls_non_state2 = sum(data.Calling(non_state2_rows) == 1);

% Create observed and expected vectors
observed = [actual_calls_state2, actual_calls_non_state2];
expected = [expected_calls_state2, expected_calls_non_state2];

% Compute chi-square statistic
chi2_stat = sum((observed - expected).^2 ./ expected);

% Degrees of freedom
df = length(observed) - 1;

% p-value
p = 1 - chi2cdf(chi2_stat, df);

% Display results
fprintf('\nChi-Square Test Adjusted for Time in Dive States (Dive State 2):\n');
fprintf('Observed calls: [State 2 = %d, Other = %d]\n', observed(1), observed(2));
fprintf('Expected calls: [State 2 = %.2f, Other = %.2f]\n', expected(1), expected(2));
fprintf('Chi-square statistic = %.2f\n', chi2_stat);
fprintf('Degrees of freedom = %d\n', df);
fprintf('p-value = %.5f\n', p);

if p < 0.05
    fprintf('Result: Significant difference in call occurrence for Dive State 2.\n');
else
    fprintf('Result: No significant difference in call occurrence for Dive State 2.\n');
end
%% Tag 2 - Chi-Square Test for Call Type 1 in Dive State 0

% Load data (adjust path if needed)
data = readtable('CATSJ1_022023_SNR25_v2_acoustics_kinematics_plotting.csv');

% Ensure DiveStates is numeric
data.DiveStates = double(data.DiveStates);

% Remove rows with missing DiveStates or call classification
valid_rows = ~isnan(data.DiveStates) & ~ismissing(data.manuscript_classification);
data = data(valid_rows, :);

% Define logical indexing for Dive State 0 (surface)
state0_rows = data.DiveStates == 0;
non_state0_rows = data.DiveStates ~= 0;

% Count time (rows) spent in each category
time_state0 = sum(state0_rows);
time_non_state0 = sum(non_state0_rows);
total_time = time_state0 + time_non_state0;

% Count total Type 1 calls in dataset
is_type1 = strcmpi(strtrim(data.manuscript_classification), '1');  % ensure it's string '1'
total_type1_calls = sum(is_type1);

% Expected number of type 1 calls proportional to time in each state
expected_type1_state0 = total_type1_calls * (time_state0 / total_time);
expected_type1_other = total_type1_calls * (time_non_state0 / total_time);

% Actual number of type 1 calls in each state
actual_type1_state0 = sum(is_type1 & state0_rows);
actual_type1_other = sum(is_type1 & non_state0_rows);

% Create observed and expected vectors
observed = [actual_type1_state0, actual_type1_other];
expected = [expected_type1_state0, expected_type1_other];

% Compute chi-square statistic
chi2_stat = sum((observed - expected).^2 ./ expected);

% Degrees of freedom
df = length(observed) - 1;

% p-value
p = 1 - chi2cdf(chi2_stat, df);

% Display results
fprintf('\nChi-Square Test for Call Type 1 in Dive State 0 (Time-Weighted):\n');
fprintf('Observed Type 1 calls: [State 0 = %d, Other = %d]\n', observed(1), observed(2));
fprintf('Expected Type 1 calls: [State 0 = %.2f, Other = %.2f]\n', expected(1), expected(2));
fprintf('Chi-square statistic = %.2f\n', chi2_stat);
fprintf('Degrees of freedom = %d\n', df);
fprintf('p-value = %.5f\n', p);

if p < 0.05
    fprintf('Result: Significant difference in occurrence of Call Type 1 in Dive State 0.\n');
else
    fprintf('Result: No significant difference in occurrence of Call Type 1 in Dive State 0.\n');
end
%% Tag 4 - Chi-Square Test for Call Type 28 in Dive State 0

% Load data (adjust path if needed)
data = readtable('CATSJ4_102024_SNR40_v2_acoustics_kinematics_plotting.csv');

% Ensure DiveStates is numeric
data.DiveStates = double(data.DiveStates);

% Remove rows with missing DiveStates or call classification
valid_rows = ~isnan(data.DiveStates) & ~ismissing(data.manuscript_classification);
data = data(valid_rows, :);

% Define logical indexing for Dive State 0 (surface)
state0_rows = data.DiveStates == 0;
non_state0_rows = data.DiveStates ~= 0;

% Count time (rows) spent in each category
time_state0 = sum(state0_rows);
time_non_state0 = sum(non_state0_rows);
total_time = time_state0 + time_non_state0;

% Identify Type 28 calls (ensure it's string or numeric as appropriate)
% If column contains strings like '28', use string match:
is_type28 = strcmpi(strtrim(string(data.manuscript_classification)), '28');

% Count total Type 28 calls
total_type28_calls = sum(is_type28);

% Expected number of Type 28 calls based on time in each state
expected_type28_state0 = total_type28_calls * (time_state0 / total_time);
expected_type28_other = total_type28_calls * (time_non_state0 / total_time);

% Actual number of Type 28 calls in each state
actual_type28_state0 = sum(is_type28 & state0_rows);
actual_type28_other = sum(is_type28 & non_state0_rows);

% Observed and expected vectors
observed = [actual_type28_state0, actual_type28_other];
expected = [expected_type28_state0, expected_type28_other];

% Compute chi-square statistic
chi2_stat = sum((observed - expected).^2 ./ expected);

% Degrees of freedom
df = length(observed) - 1;

% p-value
p = 1 - chi2cdf(chi2_stat, df);

% Display results
fprintf('\nChi-Square Test for Call Type 28 in Dive State 0 (Time-Weighted):\n');
fprintf('Observed Type 28 calls: [State 0 = %d, Other = %d]\n', observed(1), observed(2));
fprintf('Expected Type 28 calls: [State 0 = %.2f, Other = %.2f]\n', expected(1), expected(2));
fprintf('Chi-square statistic = %.2f\n', chi2_stat);
fprintf('Degrees of freedom = %d\n', df);
fprintf('p-value = %.5f\n', p);

if p < 0.05
    fprintf('Result: Significant difference in occurrence of Call Type 28 in Dive State 0.\n');
else
    fprintf('Result: No significant difference in occurrence of Call Type 28 in Dive State 0.\n');
end

