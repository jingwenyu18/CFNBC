function [recomm_md,recomm_ml]=CFR(new_md_association,new_ml_association)
    new_md = new_md_association;
    new_ml = new_ml_association;
    [~,nd] = size(new_md);
    [~,nl] = size(new_ml);
%% 
    M_LD=[new_ml,new_md];
%%
    [nm,nld]=size(M_LD);
    MM=zeros(nm,nm);
    for i=1:nm
        for j=1:nm
            if(i==j)
                MM(i,j)=1;
            else
                if(sum(M_LD(i,:)==M_LD(j,:))>0)
                    MM(i,j)=1;
                end
            end
        end
    end
%%
    for i=1:nm
        for j=1:nm
            if(i==j)
                MM(i,j)=0;
            else
                jiaoji = length(intersect(find(M_LD(i,:)),find(M_LD(j,:))));
                chengji = sum(M_LD(i,:))*sum(M_LD(j,:));
                MM(i,j)=jiaoji/sqrt(chengji);
            end
        end
    end
%%
    R=MM*M_LD;
    recomm_M_LD=zeros(size(M_LD));
    for i=1:nld
        index1=find(M_LD(:,i));
        temp = sum(R(index1,i));
        ave=sum(R(index1,i))/length(index1);
        index2=find(M_LD(:,i)==0);
        for j=1:length(index2)
            if(R(index2(j),i)>ave)
                recomm_M_LD(index2(j),i)=1;
            end
        end
    end
    recomm_ml=recomm_M_LD(:,nd+1:nd+nl);
    recomm_ml(new_ml_association==1)=0;
    recomm_md = recomm_M_LD(:,1:nd);
    recomm_md(new_md_association==1)=0;
end