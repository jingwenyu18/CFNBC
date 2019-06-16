function [F]=CFNBC(new_ml_association,new_md_association,recomm_ml,recomm_md,C,alpha,dsim)
A=new_ml_association;
B=new_md_association;
E=recomm_ml;
F=recomm_md;
[n1,m1]=size(A);
[n2,m2]=size(B);
[n3,m3]=size(C);
ldn=sum(C(:)==1);

cc=sum(sum(C));
pld=(m1*m2-cc)/cc;
S1=ones(m1,m2);
S2=S1;
for k=1:n1 
    Temp=A(k,:)'*B(k,:);
    Temp1=C.*Temp;
    x1 = sum(A(k,:)==1);
    y1 = sum(B(k,:)==1);
    N1=sum(sum(Temp1));
    S_original=Temp.*((pld*(N1+1))/(x1*y1-N1+1));
    S=S_original;
    S(S==0)=1;
    S1=S.*S1;
end
Temp=[];
for k=1:n1 
    Temp=E(k,:)'*F(k,:);
    Temp2=C.*Temp;
    x2 = sum(E(k,:)==1);
    y2 = sum(F(k,:)==1);
    N2 = sum(sum(Temp2));
    S_recom = Temp.*((pld*(N2+1))/(x2*y2-N2+1))^alpha;
    S=S_recom;
    S(S==0)=1;
    S2=S.*S2;
end
SS=S1.*S2;
SS=log(SS)/100;
F=SS*dsim;
save F F;
end

           

