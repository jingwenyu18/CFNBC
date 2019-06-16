[union_miRNA,L_in_ml,D_in_md,new_ml,new_md,new_ld,new_ml_association,...
    new_md_association,new_ld_association]=get_new_association;
load('dsim');
[recomm_md,recomm_ml]=CFR(new_md_association,new_ml_association);
F=CFNBC(new_ml_association,new_md_association,recomm_ml,recomm_md,M,0.05,dsim);    
