* Dummy sektor
parameter m0(j,i), v0(j);
*dummyShare.l = 0.01;
* Definition af gamX-funktioner
function splitMatrix(x) =
m0(j,i) = %x(j,i)|
%x('qzi_d',i) = dummyShare.l * m0('qzi_r',i)|
%x(j,'qzi_d') = dummyShare.l * m0(j,'qzi_r')|
%x('qzi_r',i) = (1-dummyShare.l) * m0('qzi_r',i)|
%x(j,'qzi_r') = (1-dummyShare.l) * m0(j,'qzi_r')|

%x('qzi_d','qzi_d') = dummyShare.l * m0('qzi_r','qzi_r')|
%x('qzi_r','qzi_r') = (1-dummyShare.l) * m0('qzi_r','qzi_r')|
%x('qzi_d','qzi_r') = 0|
%x('qzi_r','qzi_d') = 0|
;

function splitVector(x) =
v0(j) = %x(j)|
%x('qzi_d') = dummyShare.l * v0('qzi_r')|
%x('qzi_r') = (1-dummyShare.l) * v0('qzi_r')|
;

function setTaxMatrix(x) =
%x('qzi_d',i) = %x('qzi_r',i)|
%x(j,'qzi_d') = %x(j,'qzi_r')|
;

@splitMatrix(xD.l);
@splitMatrix(xF.l);
@splitMatrix(IMID.l);
@splitMatrix(IBID.l);
@splitMatrix(IMIF.l);
@splitMatrix(IBIF.l);

@splitVector(gD.l);
@splitVector(gF.l);
@splitVector(cD.l);
@splitVector(cF.l);
@splitVector(ExD.l);
@splitVector(ExF.l);
@splitVector(ILD.l);
@splitVector(ILF.l);
@splitVector(Y.l);
@splitVector(L.l);
@splitVector(Rest);
@splitVector(KMtemp);
@splitVector(KBtemp);
@splitVector(AfskM);
@splitVector(AfskB);

*Øger dummy-branchens leveringer til forbrug med det samme, som den sænker deres leveringer til andre brancher med og modjusterer i resten
* cD.l('qzi_d')=cD.l('qzi_d')+sum(j,xD.l(j,'qzi_d'));
* cD.l('qzi_r')=cD.l('qzi_r')-sum(j,xD.l(j,'qzi_d'));
* xD.l(j,'qzi_r')= xD.l(j,'qzi_r')+ xD.l(j,'qzi_d');
* xD.l(j,'qzi_d')=0;

@setTaxMatrix(tCus_x.l);
@setTaxMatrix(tCus_IM.l);
@setTaxMatrix(tCus_IB.l);
@setTaxMatrix(tDuty_xD.l);
@setTaxMatrix(tDuty_xF.l);
@setTaxMatrix(tDuty_IMD.l);
@setTaxMatrix(tDuty_IBD.l);
@setTaxMatrix(tDuty_IMF.l);
@setTaxMatrix(tDuty_IBF.l);
@setTaxMatrix(tVAT_xD.l);
@setTaxMatrix(tVAT_xF.l);
@setTaxMatrix(tVAT_IMD.l);
@setTaxMatrix(tVAT_IMF.l);
@setTaxMatrix(tVAT_IBD.l);
@setTaxMatrix(tVAT_IBF.l);

tCus_g.l('qzi_d') = tCus_g.l('qzi_r');
tCus_c.l('qzi_d') = tCus_c.l('qzi_r');
tCus_Ex.l('qzi_d') = tCus_Ex.l('qzi_r');
tCus_IL.l('qzi_d') = tCus_IL.l('qzi_r');
tDuty_gD.l('qzi_d') = tDuty_gD.l('qzi_r');
tDuty_gF.l('qzi_d') = tDuty_gF.l('qzi_r');
tDuty_cD.l('qzi_d') = tDuty_cD.l('qzi_r');
tDuty_cF.l('qzi_d') = tDuty_cF.l('qzi_r');
tDuty_ExD.l('qzi_d') = tDuty_ExD.l('qzi_r');
tDuty_ExF.l('qzi_d') = tDuty_ExF.l('qzi_r');
tDuty_ILD.l('qzi_d') = tDuty_ILD.l('qzi_r');
tDuty_ILF.l('qzi_d') = tDuty_ILF.l('qzi_r');
tVAT_gD.l('qzi_d') = tVAT_gD.l('qzi_r');
tVAT_gF.l('qzi_d') = tVAT_gF.l('qzi_r');
tVAT_cD.l('qzi_d') = tVAT_cD.l('qzi_r');
tVAT_cF.l('qzi_d') = tVAT_cF.l('qzi_r');
tVAT_ILD.l('qzi_d') = tVAT_ILD.l('qzi_r');
tVAT_ILF.l('qzi_d') = tVAT_ILF.l('qzi_r');
t_Y.l('qzi_d') = t_Y.l('qzi_r');
