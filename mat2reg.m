function s=mat2reg(M)

n=8;
if (length(M)==1)
    s=num2str(M,n);
    return
end

if (size(M,1)==1)|(size(M,2)==1)
    s=['{' num2str(M(1),n)];
    for i=2:length(M)
        s=[s 'f, ' num2str(M(i),n)];
    end
    s=[s 'f}'];
    if (size(M,2)==1)
        s=[s char(39)];
    end
    return
end

s=['{' mat2reg(M(1,:))];
for i=2:size(M,1)
    s=[s ', ' mat2reg(M(i,:))];
end
s=[s '}'];
