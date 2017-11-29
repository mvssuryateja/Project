function h=lab_s(words,A)
flag = 1; %initializing flag
[~,wn] = size(words); %knowing the dimensions of 'words'
for i=1:wn
words(:,i) = normalize_norm(words(:,i)); end %normalizing the column vectors of 'words'
[~,an] = size(A); %knowing the dimensions of 'A'
for i=1:an
A(:,i) = normalize_norm(A(:,i)); end %normalizing the column vectors of 'A'
h = zeros(wn,1); % initializing h - the output column matrix
for i=1:an
d = -1; % intializing d - for every loop
for j=1:wn % finding the maximum possible value of dot product between A(:,i) and words(:,j)
if dot(words(:,j),A(:,i)) > d
d = dot(words(:,j),A(:,i));
flag = j; end;end % 'flag' th column of 'words' gives the highest dot product with i th column of 'A'
h(flag,1) = h(flag,1)+1; end;end % incrementing the values in output