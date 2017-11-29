    clear all; close all; clc;   
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    a = 0.97;               % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    wav_file = 'arctic_a0001.wav'; % input audio filename
    % Read speech samples, sampling rate and precision from file
    [ speech1, fs] = audioread( wav_file );
    speech1 = speech1/abs(max(speech1));
    %framing for silence removal
    f_d = 0.025;t = 0;
    f_size = floor(f_d*fs);
    n = length(speech1);
    n_f = floor(n/f_size);
    for i = 1 : n_f
    frames1(i,:)= speech1(t+1: t + f_size);
    t = t + f_size;end
    %silence removal based on max amplitude
    m_amp = abs(max(frames1,[],2));
    id = find(m_amp > 0.1); % finding ID of frames with max amp > 0.1
    fr_ws = frames1(id,:); % frames without silence
    speech = reshape(fr_ws',1,[]);% reconstruct signal  
    % Feature extraction (feature vectors as columns)
    [ MFCCs ] = mfcc_r( speech, fs, Tw, Ts, a, @hamming, [LF HF], M, C+1);
    MFCC = MFCCs.';
    M1 = deltamfcc(MFCCs);
    M2 = M1.';
    M3 = deltamfcc(M2);
    M4 =[MFCC,M1,M3];
    filename = 'm.xlsx';
    xlswrite(filename,M4);  