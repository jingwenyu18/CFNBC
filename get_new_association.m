function [union_miRNA,L_in_ml,D_in_md,new_ml,new_md,new_ld,new_ml_association,new_md_association,new_ld_association]=get_new_association
    

    [~,ml]=xlsread('../data/miRNA_lncRNA.xlsx');
    [~,md]=xlsread('../data/miRNA_disease.xlsx');
    [~,ld]=xlsread('../data/lncRNA_disease.xlsx');
    L_in_ml = unique(ml(:,2));
    D_in_md  = unique(md(:,2));
    union_miRNA = union(ml(:,1),md(:,1));
    new_ml_association=zeros(length(union_miRNA),length(L_in_ml));
    new_md_association=zeros(length(union_miRNA),length(D_in_md));
    new_ld_association=zeros(length(L_in_ml),length(D_in_md));
    [N1,~]=size(ml);
    [N2,~]=size(md);
    [N3,~]=size(ld);
    t=1;
    for i=1:N1
        index1=find(strcmp(union_miRNA,ml{i,1}));
        index2 = find(strcmp(L_in_ml,ml{i,2}));
        new_ml_association(index1,index2)=1;
        new_ml(t,1)=index1;
        new_ml(t,2)=index2;
        t=t+1;
    end
    t=1;
    for i=1:N2
        index1=find(strcmp(union_miRNA,md{i,1}));
        index2 = find(strcmp(D_in_md,md{i,2}));
        new_md_association(index1,index2)=1;
        new_md(t,1)=index1;
        new_md(t,2)=index2;
        t=t+1;
    end
    t=1;
    for i=1:N3
        index1=find(strcmp(L_in_ml,ld{i,1}));
        index2 = find(strcmp(D_in_md,ld{i,2}));
        if isempty(index2)||isempty(index1)
            continue;
        else
            new_ld_association(index1,index2)=1;
            new_ld(t,1)=index1;
            new_ld(t,2)=index2;
            t=t+1;
        end
    end   
end
