[data_preyshare, sampleRate] = audioread('Ex1_preysharing_20241001_142340.wav');

% Define parameters for the spectrogram
window = 1024;   % FFT size
noverlap = 512;  % 50% overlap
nfft = window;   % Number of FFT points

figure();
colormap('jet');
spectrogram(data_preyshare, window, noverlap, nfft, sampleRate, 'yaxis');
title('Example Recording During Prey Sharing');
colorbar('off')
saveas(gcf, 'Figure_7.png');