function AudioAnalyzer

close all;
clear all;
clc;

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/Audio');

% [At, Fs, nbits]=wavread('2-17_Outliers_-_[Disc_2_Track_2.wav');
[At, Fs, nbits]=wavread('Articulation_of_Phonemes.wav');

% Want fourier samples ~0.05 sec long.
% 0.05 sec * Fs = NF, # samples for FFT
% Round NF up to nearest power of 2.

TWantSample = 0.1;
NF = 2^nextpow2(TWantSample*Fs);
TSample = NF/Fs;

% Max frequency is Fs/2
% Number of freq's is NF/2
MaxFreq = Fs/2;
NFreqs = NF/2;

% Use overlap of m, where the overlap proportion of samples is (m-1)/m
Overlap = 20;

NTransforms = floor(length(At)/(NF/Overlap))-(Overlap-1);
AllData = zeros(NFreqs,NTransforms);

for i = 1:NTransforms
    Af = fft(At(floor(NF/Overlap)*(i-1)+1:floor(NF/Overlap)*i+(Overlap-1)),NF);
%     Af = Af/max(abs(Af));
%     test = 1;
%     plot(linspace(0,MaxFreq-1,NFreqs),abs(Af(1:NFreqs))/max(abs(Af(1:NFreqs))));
    AllData(:,i) = abs(Af(1:NFreqs));
end

AllData = AllData/max(max(abs(AllData)));

[Times,Freqs] = meshgrid(linspace(0,(NTransforms+Overlap-1)*TSample/Overlap,NTransforms),linspace(0,MaxFreq,NFreqs));
% contourf(Times,Freqs,AllData,'LineStyle','none');

%-------------------------------------
% FREQUENCY LIMITER: REMOVE ABOVE 4kHZ
LastFreqRow = find(Freqs(:,1)<4000,1,'last');
AllData = AllData(1:LastFreqRow,:);
Times = Times(1:LastFreqRow,:);
Freqs = Freqs(1:LastFreqRow,:);
%-------------------------------------

surf(Times,Freqs,AllData,'EdgeAlpha',0);
view(2);
xlim([Times(1,1),Times(1,end)]);
ylim([Freqs(1,1),Freqs(end,1)]);
xlabel('Time (s)');
ylabel('Freq (Hz)');

test = 1;



cd(oldfolder);

