
%% Load Data
%Call Categories - Condensed version (Top 5)
% Location: E:\#DISSERTATION_final\CHAP 4 - PcTAG\Manuscript\Code&Tables_forStats&Figures_03042025
top5_calltypes = readtable('Calltypes_summary_alltop5.csv');

classification_top5_tag1 = top5_calltypes.Classification_tag1;
per_call_types_top5_tag1 = top5_calltypes.perc_callcat_tag1;
classification_top5_tag2 = top5_calltypes.Classification_tag2;
per_call_types_top5_tag2 = top5_calltypes.perc_callcat_tag2; 
per_call_types_top5_tag3 = top5_calltypes.perc_callcat_tag3; 
classification_top5_tag3 = top5_calltypes.Classification_tag3;
per_call_types_top5_tag4 = top5_calltypes.perc_callcat_tag4; 
classification_top5_tag4 = top5_calltypes.Classification_tag4;

%% Try Bar plot with top 5

[data_1, sampleRate] = audioread('1_sel.114.ch02.230221.142723.69.C.38.112.F.wav');
[data_2i, sampleRate] = audioread('2.1_sel.2353.ch02.230221.163127.29.C.837.2353.F.wav');
[data_7, sampleRate] = audioread('7_sel.3030.ch02.230221.154119.98.C.1241.3721.U.wav');
[data_10, sampleRate] = audioread('10_sel.2277.ch02.241003.152557.89.C.1153.F.wav');
[data_15, sampleRate] = audioread('15_sel.306.ch02.230221.142846.76.C.102.304.F.wav');
[data_16, sampleRate] = audioread('16_sel.1016.ch02.241003.150721.91.C.521.F.wav');
[data_28, sampleRate] = audioread('28_sel.100.ch02.241003.154547.74.C.100.F.wav');
[data_29, sampleRate] = audioread('29_sel.1103.ch02.241003.150810.21.C.566.F.wav');
[data_35, sampleRate] = audioread('35_sel.138.ch02.230221.142730.85.C.46.136.F.wav');
[data_38, sampleRate] = audioread('38_sel.1113.ch02.241003.150814.42.C.571.F.wav');
[data_39, sampleRate] = audioread('39_sel.1347.ch02.241003.151030.29.C.687.F.wav');
[data_48, sampleRate] = audioread('48_sel.1031.ch02.241003.155255.62.C.516.F.wav');
[data_51a_51b, sampleRate2] = audioread('51.1_51.2_sel.02.ch02.111026.212224.07.wav');
[data_2_dtag, sampleRate2] = audioread('2_sel.145.ch02.111026.225606.54.C.145.F.wav');

% Define parameters for the spectrogram
window = 1024;   % FFT size
noverlap = 512;  % 50% overlap
nfft = window;   % Number of FFT points

window2 = 2048;   % FFT size
noverlap2 = 1024;  % 50% overlap
nfft2 = window2;   % Number of FFT points


figure;
% DTAG
subplot(4,7,[1,2]);
b=bar(per_call_types_top5_tag1)
b.FaceColor = '#3D405B';
title('HIPc332');
xticklabels(classification_top5_tag1); 

subplot(4,7,[3]);
colormap('jet');
spectrogram(data_51a_51b, window2, noverlap2, nfft2, sampleRate2, 'yaxis');
title('51');
colorbar('off')
ylim([0 48])

subplot(4,7,[4]);
colormap('jet');
%axes(ha(3)); % Use the first subplot
spectrogram(data_2_dtag, window2, noverlap2, nfft2, sampleRate2, 'yaxis');
title('2');
colorbar('off')
ylim([0 48])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CATS - 2
subplot(4,7,[8,9]);
c=bar(per_call_types_top5_tag2)
c.FaceColor = '#2A9D8F';
title('HIPc0706');
xticklabels(classification_top5_tag2); 

subplot(4,7,[10]);
colormap('jet');
spectrogram(data_1, window, noverlap, nfft, sampleRate, 'yaxis');
title('1');
colorbar('off')
xlim([0.05 1.05])

subplot(4,7,[11]);
colormap('jet');
spectrogram(data_15, window, noverlap, nfft, sampleRate, 'yaxis');
title('15');
colorbar('off')
xlim([0 1000])

subplot(4,7,[12]);
colormap('jet');
spectrogram(data_35, window, noverlap, nfft, sampleRate, 'yaxis');
title('35');
colorbar('off')
xlim([0 1000])
saveas(gcf, '35.jpg');

subplot(4,7,[13]);
colormap('jet');
spectrogram(data_7, window, noverlap, nfft, sampleRate, 'yaxis');
title('7');
colorbar('off')
xlim([0 1.0])
saveas(gcf, '15.jpg');

subplot(4,7,[14]);
colormap('jet');
spectrogram(data_2i, window, noverlap, nfft, sampleRate, 'yaxis');
title('2i');
colorbar('off')
xlim([0.2 1.2])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CATS - 3
subplot(4,7,[15,16]);
d=bar(per_call_types_top5_tag3)
d.FaceColor = '#E9C46A';
title('HIPc0265');
xticklabels(classification_top5_tag3);

subplot(4,7,[17]);
colormap('jet');
spectrogram(data_28, window, noverlap, nfft, sampleRate, 'yaxis');
title('28');
colorbar('off')
xlim([0.2 1.2])

subplot(4,7,[18]);
colormap('jet');
%axes(ha(13)); % Use the first subplot
spectrogram(data_10, window, noverlap, nfft, sampleRate, 'yaxis');
title('10');
colorbar('off')
xlim([0 1000])

subplot(4,7,[19]);
colormap('jet');
spectrogram(data_48, window, noverlap, nfft, sampleRate, 'yaxis');
title('48');
colorbar('off')
xlim([0 1.0])

subplot(4,7,[20]);
colormap('jet');
spectrogram(data_16, window, noverlap, nfft, sampleRate, 'yaxis');
title('16');
colorbar('off')
xlim([0 1000])

subplot(4,7,[21]);
colormap('jet');
spectrogram(data_39, window, noverlap, nfft, sampleRate, 'yaxis');
title('39');
colorbar('off')
xlim([0 1000])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CATS - 4
subplot(4,7,[22,23]);
e=bar(per_call_types_top5_tag4)
e.FaceColor = '#E76F51';
title('HIPc0805');
xticklabels(classification_top5_tag4); 
xlabel('Call Type');
ylabel('Proportion of Calls');

subplot(4,7,[24]);
colormap('jet');
spectrogram(data_28, window, noverlap, nfft, sampleRate, 'yaxis');
title('28');
colorbar('off')
xlim([0.2 1.2])

subplot(4,7,[25]);
colormap('jet');
spectrogram(data_10, window, noverlap, nfft, sampleRate, 'yaxis');
title('10');
colorbar('off')
xlim([0 1000])

subplot(4,7,[26]);
colormap('jet');
spectrogram(data_39, window, noverlap, nfft, sampleRate, 'yaxis');
title('39');
colorbar('off')
xlim([0 1000])

subplot(4,7,[27]);
colormap('jet');
spectrogram(data_38, window, noverlap, nfft, sampleRate, 'yaxis');
title('38');
colorbar('off')
xlim([0 1000])

subplot(4,7,[28]);
colormap('jet');
spectrogram(data_29, window, noverlap, nfft, sampleRate, 'yaxis');
title('29');
colorbar('off')
xlim([0 1000])