function [b_mean,b_cluster]=SPKmean(a,K,n_run)
[n,dim]=size(a); x=zeros(K,dim);  %initializing means (intermediate values)
for run=1:n_run
   t=rand(1,n); %creates a row vector with 'n' random numbers ranging from 0 to 1
   t=int16(t*(K-1)+1); %creates a row vector with 'n' random natural numbers ranging from 1 to 'K', representing the indices of the clusters
   x=zeros(K,dim); %intializing x for one loop
   for i=1:n
       x(t(i),:)=x(t(i),:)+a(i,:); end%evaluating means for 'K' clusters
   for i=1:K
       if x(i,:)>0 
           x(i,:)=x(i,:)/norm(x(i,:)); %normalizing means
       else
           x(i,:)=a(int16(rand(1,1)*(n-1))+1,:);%in a case where cluster is empty
       end
   end
end
mem=zeros(1,n); %initialization
f_old=0;diff=inf; %initialization
while diff>10^-(10) %termination criteria
  f=0; %initializing f - for every loop
  mem_num=zeros(1,K);  %number of points in each cluster
  b=zeros(K,dim); %sum of all points in a cluster
for i=1:n     %membership
  maxi=-inf;  %initializing the maxi - for every loop
  for l=1:K  %membership assignment
      temp=a(i,:)*x(l,:)';  %for finding the maximum value for the dot product
      if temp>maxi
          maxi=temp;
          t=l;  %indicates an update
      end
  end
  f=f+maxi; %f is the sum of n dot products of every row vector of data with it's corresponding cluster's mean 
  mem(i)=t;
  if i~=0
      mem_num(t)=mem_num(t)+1; %counting the number of elements in a cluster
      b(t,:)=b(t,:)+a(i,:); % evaluating the mean
  end
end
for l=1:K  
   if mem_num(l)>0 %normalizing means
       x(l,:)=b(l,:)/norm(b(l,:),2);
   else
       fprintf('Empty cluster encountered\n');
       big=0;maxi=0; %initialization
       for i=1:K
           if mem_num(i)>maxi 
               maxi=mem_num(i);big=i;end
       end %now, ith cluster is the biggest cluster
       count=0;ii=1;
       while count<1 
               int16(mem_num(big)/2) %for random partition of the biggest cluster
           if mem(ii)==big
               b(l,:)=b(l,:)+a(ii,:); %adding a vector to empty cluster
               b(big,:)=b(big,:)-a(ii,:);  %removing that vector to empty cluster
               count=count+1;
           end
           ii=ii+1;
       end
       x(l,:)=b(l,:)/norm(b(l,:),2); %normalizing means
   end
end
diff=abs(f_old-f); %finding the difference between the values of f between two iterations
f_old=f; %updating the value of f_old
end 
    b_mean = x ; %returning the output
    b_cluster = mem; %returning the output
end