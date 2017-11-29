function deltamfcc = deltamfcc(MFCCs)
    M1 = [zeros(13,2),MFCCs];M1 = M1.'; %adding first two rows with zeros
    M2 = [MFCCs,zeros(13,2)];M2 = M2.'; %adding last two rows with zeros
    M3 = (M1-M2)/2; %finding difference b/w matrices
    M3 = [M3(2:end-1,:)]; %removing first row and last row
    M4 = [zeros(13,4),MFCCs];M4 = M4.';%adding first four rows with zeros
    M5 = [MFCCs,zeros(13,4)];M5 = M5.';%adding last four rows with zeros
    M6 = (M4-M5)/2; %finding difference b/w matrices
    M6 = [M6(3:end-2,:)];%removing first two rows and last two rows
    M7 = M6+M3; %adding two matrices which make up delta MFCCs of input MFCCS
    deltamfcc = M7;
