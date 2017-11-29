% This code is used to test Female Test dataset.
% This is seperated so that it is more convinient while evaluating the project  
   clear all; close all; clc;
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    te = zeros(2,39);  
    x=[0 0 0];
    Files=dir('test_f');
    for k=3:length(Files)
    FileNames=Files(k).name
    wav_file = FileNames; % input audio filename
    % Read speech samples, sampling rate and precision from file
    [ speech1, fs] = audioread( wav_file );
    speech1 = speech1/abs(max(speech1));
    %framing for silence removal
    f_d = 0.025;
    f_size = floor(f_d*fs);
    n = length(speech1);
    n_f = floor(n/f_size);
    temp = 0;
    for i = 1 : n_f
    frames1(i,:)= speech1(temp+1: temp + f_size);
    temp = temp + f_size;
    end
    %silence removal based on max amplitude 
    m = abs(max(frames1,[],2));
    id = find(m > 0.1); % finding ID of frames with max amp > 0.1
    fr_ws = frames1(id,:); % frames without silence
    speech = reshape(fr_ws',1,[]);  % reconstruct signal
    % Feature extraction (feature vectors as columns)
    [ MFCCs,frames ] =mfcc_r( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1);
    MFCC = MFCCs.';
    M1 = deltamfcc(MFCCs);
    M2 = M1.';
    M3 = deltamfcc(M2);
    M4 =[MFCC,M1,M3];
    A1 = M4;A1 = A1.';
    words1 = xlsread('m&f_train_SPK.xlsx');
    words1 = words1.';
    z = lab_s(words1,A1);
    if z(1,1)<z(2,1)
    p = z(1,1)*100/(z(1,1)+z(2,1));
    q = z(2,1)*100/(z(1,1)+z(2,1));
    G =[p ,q ,0];
    x = vertcat(x,G);
    filename= 'Y_w.xlsx';
    xlswrite(filename,x); end
    if  z(1,1)>z(2,1)
    p = z(1,1)*100/(z(1,1)+z(2,1));
    q = z(2,1)*100/(z(1,1)+z(2,1));
    G =[p ,q ,1];
    x = vertcat(x,G);
    filename= 'Y_w.xlsx';
    xlswrite(filename,x); end  
    end
