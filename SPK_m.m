data1 = xlsread('male_train_w.xlsx');%input male mfccs
data2 = [xlsread('female_train_w.xlsx');];%input female mfccs
data = [data1(3:end,:);data2(3:end,:)];%matxix contaning mfccs of both male and female
X = normalize_norm(data); %norm normalize data
[x,f,mem]=SPKmean(X,2,10); %executing Sperical k-means clustering function 
scatter3(data(:,1),data(:,2),data(:,3),10,mem);%plotting all the clusters in 3D
title('Spherical K-means clustering');%title for the Plotted data
filename = 'm&f_train_SPK_456.xlsx' %name of the excel sheet of the means of clusters
xlswrite(filename,x); %executing excel sheet generating function by taking matrix 'x' as input
