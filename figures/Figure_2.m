%% Figure 6 - Nonlinear Phenomena

[data, sampleRate] = audioread('chaosEX_call929_selection2785_20230221_J1_02.wav');
[data2, sampleRate2] = audioread('biphonation2EX_call102_selection2270_20230221_J1_02.wav');
[data3, sampleRate3] = audioread('frequency jumpEX_call133_selection266_20241003_J4.1_03.wav');
[data4, sampleRate4] = audioread('secondarysidebandEX_call38_selection112_20230221_J1_01.wav');

% Define parameters for the spectrogram
window = 1024;   % FFT size
noverlap = 512;  % 50% overlap
nfft = window;   % Number of FFT points

categories_NP = {'Secondary Sidebands', 'Chaos', 'Frequency Jumps', 'Biphonation'};
NP_values = [0.011, 0.088, 0, 0.004;
    0.005, 0.022, 0.053, 0.015;
    0, 0.0008, 0.186, 0.127;
    0.809, 0.704, 0.876, 0.830];

figure()
subplot(6,2,[1,3]);
spectrogram(data, window, noverlap, nfft, sampleRate, 'yaxis');
title('Chaos');
colorbar('off')
xlim([0.1 1.4])
ylim([0 20])
colormap('jet');
xticklabels({})
xlabel('');  % Clear the y-axis label
set(gca,'FontSize',12)

subplot(6,2,[2,4]);
spectrogram(data2, window, noverlap, nfft, sampleRate2, 'yaxis');
title('Biphonation');
colorbar('off')
xlim([0.1 1.4])
ylim([0 20])
colormap('jet');
xticklabels({})
xlabel('');  % Clear the y-axis label
set(gca,'FontSize',12)

subplot(6,2,[5,7]);
spectrogram(data3, window, noverlap, nfft, sampleRate3, 'yaxis');
title('Frequency Jump');
colorbar('off')
xlim([0.1 1.4])
ylim([0 20])
colormap('jet');
set(gca,'FontSize',12)

subplot(6,2,[6,8]);
spectrogram(data4, window, noverlap, nfft, sampleRate4, 'yaxis');
title('Secondary Sidebands');
colorbar('off')
xlim([0.1 1.4])
ylim([0 20])
colormap('jet');
set(gca,'FontSize',12)

subplot(6,2,[9,12]);
b = bar(NP_values)
b(1).FaceColor = ["#3D4058"];
b(2).FaceColor = ["#2A9D8F"];
b(3).FaceColor = ["#E9C46A"];
b(4).FaceColor = ["#E76F51"];
legend('HIPc332', 'HIPc0706', 'HIPc0265', 'HIPc0805','location',"northwest");  % Labels for each group
set(gca, 'XTickLabel', categories_NP);
% Add labels and title
xlabel('Nonlinear Phenomenon');
ylabel('Proportion of Calls');
set(gca,'FontSize',12)