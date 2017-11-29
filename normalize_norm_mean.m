function b=normalize_norm_mean(a)
[n, ~]=size(a);
for i=1:n
    a(i,:)=(a(i,:)-mean(a(i,:)))/norm(a(i,:)-mean(a(i,:)),2);
end
b=a;