rate=[e1,z1,e2,z2,e3,z3,e4,z4,e5,z5,e6,z6,e7,z7,e8,z8,e9,z9,e10,z10,e12,z12,e13,z13,e14,z14];
result=zeros(2,20,13);
for i=1:13
    for j=1:2
        for k=1:20
            result(j,k,i)=rate(j*i,k);
        end
    end
end
