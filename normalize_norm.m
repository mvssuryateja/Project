function b=normalize_norm(a)
[n, ~]=size(a);%finding the number of rows in the matrix 'a'
for i=1:n
    a(i,:)=a(i,:)/norm(a(i,:));%gives the normalized row vector 
end
b=a;