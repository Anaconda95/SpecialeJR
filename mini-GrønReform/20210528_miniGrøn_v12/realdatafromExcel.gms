* Indlæser definitioner af sets og mappings
include mapping73.gms

parameter Rest(j), KMtemp(j), KBtemp(j), AfskM(j), AfskB(j), BVTtest,dKMavgtemp(ns73c),dKBavgtemp(ns73c);
parameter VTot;

*Tidsdimension: Starter i første dataår, slutter i det sidste
parameters
  YF73V(ns73,ns73)    "Domestic input in production (1000 DKK)"
  YC73V(ns73)         "Domestic input to private consumption (1000 DKK)"
  YG73V(ns73)         "Domestic input to public consumption (1000 DKK)"
  YIM73V(ns73,ns73)   "Domestic input to investments in machinery (1000 DKK)"
  YIB73V(ns73,ns73)   "Domestic input to investments in buildings (1000 DKK)"
  YX73V(ns73)         "Domestic input to exports (1000 DKK)"
  YZ73V(ns73)         "Domestic input to residual (1000 DKK)"
  MF73V(ns73,ns73)    "Foreign input in production (1000 DKK)"
  MC73V(ns73)         "Foreign input to private consumption (1000 DKK)"
  MG73V(ns73)         "Foreign input to public consumption (1000 DKK)"
  MIM73V(ns73,ns73)   "Foreign input to investments in machinery (1000 DKK)"
  MIB73V(ns73,ns73)   "Foreign input to investments in buildings (1000 DKK)"
  MX73V(ns73)         "Foreign input to exports (1000 DKK)"
  MZ73V(ns73)         "Foreign input to residual (1000 DKK)"
  PF73V(npi5,ns73)    "Primary input in production (1000 DKK)"
  PF73EUV(npi5,ns73)  "Primary input in production from EU (1000 DKK)"
  PC73V(npi5)         "Primary input to private consumption incl. taxes (1000 DKK)"
  PG73V(npi5)         "Primary input to public consumption incl. taxes (1000 DKK)"
  PIM73V(npi5,ns73)   "Primary input to investments in machinery incl. taxes (1000 DKK)"
  PIB73V(npi5,ns73)   "Primary input to investments in buildings incl. taxes (1000 DKK)"
  PX73V(npi5)         "Primary input to exports incl. taxes (1000 DKK)"
  PZ73V(npi5)         "Primary input to residual incl. taxes (1000 DKK)"
  CF73V(ns73,ns73)    "Customs on input in production (1000 DKK)"
  CC73V(ns73)         "Customs on input to private consumption (1000 DKK)"
  CG73V(ns73)         "Customs on input to public consumption (1000 DKK)"
  CIM73V(ns73,ns73)   "Customs on input to investments in machinery (1000 DKK)"
  CIB73V(ns73,ns73)   "Customs on input to investments in buildings (1000 DKK)"
  CX73V(ns73)         "Customs on input to exports (1000 DKK)"
  CZ73V(ns73)         "Customs on input to residual (1000 DKK)"
  Kmu73V(ns73)        "Capital stock - machinery (1000 DKK)"
  Kbu73V(ns73)        "Capital stock - buildings (1000 DKK)"
  DKm73V(ns73)        "Depreciations - machinery (1000 DKK)"
  DKb73V(ns73)        "Depreciations - buildings (1000 DKK)"  
  tVAT_x73(ns73)      "Imputeret moms på input til produktion"
  tDuty_x73(ns73)     "Imputerede produktskatter på input til produktion"
  tVAT_IM73(ns73)     "Imputeret moms på input til maskiner"
  tDuty_IM73(ns73)    "Imputerede produktskatter på input til maskiner"
  tVAT_IB73(ns73)     "Imputeret moms på input til bygninger"
  tDuty_IB73(ns73)    "Imputerede produktskatter på input til bygninger"
  dKMavg(ns73)        "Afskrivninger, Maskiner, konjunkturrensete"
  dKBavg(ns73)        "Afskrivninger, Bygninger, konjunkturrensete"
  DutyYFVx(ns73,ns73,tax)  "Produktafgifter, Indenlandsk produktion, input "
  DutyMFVx(ns73,ns73,tax)  "Produktafgifter, Import, input"
  DutyYCVx(ns73,tax)       "Produktafgifter, Indenlandsk produktion, Forbrug "
  DutyMCVx(ns73,tax)       "Produktafgifter, Import, Forbrug "
  DutyYGVx(ns73,tax)       "Produktafgifter, Indenlandsk produktion, Offentligt forbrug "
  DutyMGVx(ns73,tax)       "Produktafgifter, Import, Offentligt forbrug "
  DutyYXVx(ns73,tax)       "Produktafgifter, Indenlandsk produktion, Eksport "
  DutyMXVx(ns73,tax)       "Produktafgifter, Import, Eksport " 
  DutyYZVx(ns73,tax)       "Produktafgifter, Indenlandsk produktion, Lagerinvesteringer "
  DutyMZVx(ns73,tax)       "Produktafgifter, Import, Lagerinvesteringer "
  DutyYIMVx(ns73,ns73,tax) "Produktafgifter, Indenlandsk produktion, Maskininveseringer "
  DutyMIMVx(ns73,ns73,tax) "Produktafgifter, Import, Maskininveseringer "
  DutyYIBVx(ns73,ns73,tax) "Produktafgifter, Indenlandsk produktion, Bygningsinvesteringer "
  DutyMIBVx(ns73,ns73,tax) "Produktafgifter, Import, Bygningsinvesteringer "
  FakDuty_B73V(ns73)       "Produktionsafgift, Bygninger"
  FakDuty_L73V(ns73)       "Produktionsafgift, Arbejdskraft" 
  FakDuty_ekso73V(ns73)    "Produktionsafgift, Rest"
  FKMU73V(ns73)
  FKBU73V(ns73)
;

$include readdatafromExcel.gms
parameter m0(j,i), v0(j);
*dummyShare.l = 0.01;

* Efterspørgselskomponenter i mia. kr. (dette er alle søjlerne i IO-tabellen fra ADAM)
* Ekskl. direkte skatter på efterspørgselskomponentens input, inkl. indirekte produktskatter fra leverende branche - dvs. summerer til BVT
* Branche j's materialekøb fra indenlandsk branche i
xD.l(j,i)   = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), YF73V(ns73r,ns73c)))/1000000; 
xD.l(j,i)$((xD.l(j,i) lt 0.000005) AND (xD.l(j,i) gt -0.000005)) = 0; 
* Branche j's materialekøb fra udenlandsk branche i
xF.l(j,i)   = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), MF73V(ns73r,ns73c)))/1000000;
xF.l(j,i)$((xF.l(j,i) lt 0.000005) AND (xF.l(j,i) gt -0.000005)) = 0; 
* Offentligt forbrugs varekøb fra indenlandsk branche i
gD.l(i)     = sum(ns73r $ mapns732j(i,ns73r), YG73V(ns73r))/1000000;
gD.l(i)$((gD.l(i) lt 0.000005) AND (gD.l(i) gt -0.000005)) = 0; 
* Offentligt forbrugs varekøb fra udenlandsk branche i
gF.l(i)     = sum(ns73r $ mapns732j(i,ns73r), MG73V(ns73r))/1000000;
gF.l(i)$((gF.l(i) lt 0.000005) AND (gF.l(i) gt -0.000005)) = 0; 
* Privat forbrugs varekøb fra indenlandsk branche i
cD.l(i)     = sum(ns73r $ mapns732j(i,ns73r), YC73V(ns73r))/1000000;
cD.l(i)$((cD.l(i) lt 0.000005) AND (cD.l(i) gt -0.000005)) = 0; 
* Privat forbrugs varekøb fra udenlandsk branche i
cF.l(i)     = sum(ns73r $ mapns732j(i,ns73r), MC73V(ns73r))/1000000;
cF.l(i)$((cF.l(i) lt 0.000005) AND (cF.l(i) gt -0.000005)) = 0; 
* Branche j's maskininvesteringer fra indenlandsk branche i
IMID.l(j,i) = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), YIM73V(ns73r,ns73c)))/1000000;
IMID.l(j,i)$((IMID.l(j,i) lt 0.000005) AND (IMID.l(j,i) gt -0.000005)) = 0; 
* Branche j's bygningsinvesteringer fra indenlandsk branche i
IBID.l(j,i) = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), YIB73V(ns73r,ns73c)))/1000000;
IBID.l(j,i)$((IBID.l(j,i) lt 0.000005) AND (IBID.l(j,i) gt -0.000005)) = 0; 
* Branche j's maskininvesteringer fra udenlandsk branche i
IMIF.l(j,i) = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), MIM73V(ns73r,ns73c)))/1000000;
IMIF.l(j,i)$((IMIF.l(j,i) lt 0.000005) AND (IMIF.l(j,i) gt -0.000005)) = 0; 
* Branche j's bygningsinvesteringer fra udenlandsk branche i
IBIF.l(j,i) = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), MIB73V(ns73r,ns73c)))/1000000;
IBIF.l(j,i)$((IBIF.l(j,i) lt 0.000005) AND (IBIF.l(j,i) gt -0.000005)) = 0; 
* Eksport fra indenlandsk branche i
ExD.l(i)    = sum(ns73r $ mapns732j(i,ns73r), YX73V(ns73r))/1000000;
ExD.l(i)$((ExD.l(i) lt 0.000005) AND (ExD.l(i) gt -0.000005)) = 0; 
* Import til reeksport fra udenlandsk branche i
ExF.l(i)    = sum(ns73r $ mapns732j(i,ns73r), MX73V(ns73r))/1000000;
ExF.l(i)$((ExF.l(i) lt 0.000005) AND (ExF.l(i) gt -0.000005)) = 0; 
* Lagerinvesteringer fra indenlandsk branche j (stambesætninger placeres sammen med lagerinvesteringerne)
ILD.l(j)    = sum(ns73r $ mapns732j(j,ns73r), YZ73V(ns73r))/1000000;
ILD.l(j)$((ILD.l(j) lt 0.000005) AND (ILD.l(j) gt -0.000005)) = 0; 
* Lagerinvesteringer fra udenlandsk branche j (stambesætninger placeres sammen med lagerinvesteringerne)
ILF.l(j)    = sum(ns73r $ mapns732j(j,ns73r), MZ73V(ns73r))/1000000;
ILF.l(j)$((ILF.l(j) lt 0.000005) AND (ILF.l(j) gt -0.000005)) = 0; 

* Tilgangskomponenter i mia. kr. (dette er alle rækkerne i IO-tabellen)
* Produktionsværdi for branche j
Y.l(j) = sum(i, xD.l(i,j))+gD.l(j)+cD.l(j)+sum(i,IMID.l(i,j)+IBID.l(i,j))+ExD.l(j)+ILD.l(j);

* Man kunne beregne samlet import, men den bruges ikke umiddelbart i modellen
* Man kunne beregne skatteprovenuerne, men vi benytter kun skattesatserne som variable i modellen
* Arbejdskraft fordelt på brancher sættes lig lønsum, da løn normeres
L.l(j) = sum(ns73 $ mapns732j(j,ns73), PF73V('nW',ns73))/1000000;
* Restindkomst fordelt på brancher i mia. kr.
Rest(j) = sum(ns73 $ mapns732j(j,ns73), PF73V('nCap',ns73))/1000000;

* Toldsatser
tCus_x.l(j,i)$xF.l(j,i)  
              = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),CF73V(ns73r,ns73c)))/1000000 / xF.l(j,i)  ;
tCus_g.l(i)$gF.l(i) = sum(ns73 $ mapns732j(i,ns73), CG73V(ns73))/1000000 /gF.l(i);
tCus_c.l(i)$cF.l(i) = sum(ns73 $ mapns732j(i,ns73), CC73V(ns73))/1000000 /cF.l(i) ;
tCus_IM.l(j,i)$IMIF.l(j,i) 
           = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),CIM73V(ns73r,ns73c)))/1000000/ IMIF.l(j,i);
tCus_IB.l(j,i)$IBIF.l(j,i) 
           = sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),CIB73V(ns73r,ns73c)))/1000000/ IBIF.l(j,i) ;
tCus_Ex.l(i)$ExF.l(i) = sum(ns73 $ mapns732j(i,ns73), CX73V(ns73))/1000000/ExF.l(i);
tCus_IL.l(j)$ILF.l(j) = sum(ns73 $ mapns732j(j,ns73), CZ73V(ns73))/1000000/ILF.l(j);

* Produktskattesatser
tDuty_xD.l(j,i,tax)$xD.l(j,i)  = (sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),  DutyYFVx(ns73r,ns73c,tax)))/1000000) / xD.l(j,i);
tDuty_xF.l(j,i,tax)$xF.l(j,i)  = (sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),  DutyMFVx(ns73r,ns73c,tax)))/1000000) /  ((1+tCus_x.l(j,i))*xF.l(j,i)) ;

tDuty_IMD.l(j,i,tax)$IMID.l(j,i)  = (sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),  DutyYIMVx(ns73r,ns73c,tax)))/1000000) /IMID.l(j,i) ;
tDuty_IMF.l(j,i,tax)$IMIF.l(j,i)  = (sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c),  DutyMIMVx(ns73r,ns73c,tax)))/1000000) /((1+tCus_IM.l(j,i))*IMIF.l(j,i)) ;

tDuty_IBD.l(j,i,tax)$IBID.l(j,i)   = (sum(ns73r $ mapns732j(i,ns73r),sum(ns73c $ mapns732j(j,ns73c), DutyYIBVx(ns73r,ns73c,tax)))/1000000)/IBID.l(j,i) ;
tDuty_IBF.l(j,i,tax)$IBIF.l(j,i)  = (sum(ns73r $ mapns732j(i,ns73r), sum(ns73c $ mapns732j(j,ns73c), DutyMIBVx(ns73r,ns73c,tax)))/1000000)/((1+tCus_IB.l(j,i))*IBIF.l(j,i));

tDuty_gD.l(i,tax)$gD.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyYGVx(ns73r,tax))/1000000)/gD.l(i);
tDuty_gF.l(i,tax)$gF.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyMGVx(ns73r,tax))/1000000)/((1+tCus_g.l(i))*gF.l(i));

tDuty_cD.l(i,tax)$cD.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyYCVx(ns73r,tax))/1000000)/cD.l(i);
tDuty_cF.l(i,tax)$cF.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyMCVx(ns73r,tax))/1000000)/((1+tCus_c.l(i))*cF.l(i));

tDuty_ExD.l(i,tax)$ExD.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyYXVx(ns73r,tax))/1000000)/ExD.l(i);
tDuty_ExF.l(i,tax)$ExF.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyMXVx(ns73r,tax))/1000000)/((1+tCus_Ex.l(i))*ExF.l(i)) ;

tDuty_ILD.l(i,tax)$ILD.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyYZVx(ns73r,tax))/1000000)/ILD.l(i);
tDuty_ILF.l(i,tax)$ILF.l(i) = (sum(ns73r $ mapns732j(i,ns73r), DutyMZVx(ns73r,tax))/1000000)/((1+tCus_IL.l(i))*ILF.l(i));

parameter mx(j),mm(j),mB(j);
mx(j) = (sum(i,(1+sum(taxd,tDuty_xD.l(j,i,taxd)))*xD.l(j,i)+(1+sum(taxd,tDuty_xF.l(j,i,taxd)))*((1+tCus_x.l(j,i))*xF.l(j,i))))*1000000;
mm(j) = (sum(i,(1+sum(taxd,tDuty_IMD.l(j,i,taxd)))*IMID.l(j,i)+(1+sum(taxd,tDuty_IMF.l(j,i,taxd)))*((1+tCus_IM.l(j,i))*IMIF.l(j,i))))*1000000;
mb(j) = (sum(i,(1+sum(taxd,tDuty_IbD.l(j,i,taxd)))*IBID.l(j,i)+(1+sum(taxd,tDuty_IbF.l(j,i,taxd)))*((1+tCus_IB.l(j,i))*IBIF.l(j,i))))*1000000;

*Momssatser
tVAT_xD.l(j,i)$mx(j) = sum(mapns732j(j,ns73c), PF73V('nTv',ns73c))/mx(j);
tVAT_xF.l(j,i) = tVAT_xD.l(j,i);

tVAT_IMD.l(j,i)$mm(j) = sum(mapns732j(j,ns73c), PIM73V('nTv',ns73c))/mm(j);
tVAT_IMF.l(j,i) = tVAT_IMD.l(j,i);

tVAT_IBD.l(j,i)$mb(j) = sum(mapns732j(j,ns73c), PIB73V('nTv',ns73c))/mb(j);
tVAT_IBD.l(j,i)$(tVAT_IBD.l(j,i)<-1) = -0.99;
tVAT_IBF.l(j,i) = tVAT_IBD.l(j,i);


tVAT_gD.l(i) = PG73V('nTv')/ ((sum(jj,((1+sum(taxd,tDuty_gD.l(jj,taxd)))*gD.l(jj)+(1+sum(taxd,tDuty_gF.l(jj,taxd)))*(1+tCus_g.l(jj))*gF.l(jj))))*1000000);
tVAT_gF.l(i) = tVAT_gD.l(i); 

tVAT_cD.l(i) = PC73V('nTv')/ ((sum(jj,((1+sum(taxd,tDuty_cd.l(jj,taxd)))*cD.l(jj)+(1+sum(taxd,tDuty_cF.l(jj,taxd)))*(1+tCus_c.l(jj))*cF.l(jj))))*1000000);
tVAT_cF.l(i) = tVAT_cD.l(i); 

tVAT_ILD.l(i)$(sum(jj,ILD.l(jj)+ILF.l(jj))) = PZ73V('nTv')/ ((sum(jj,((1+sum(taxd,tDuty_ILD.l(jj,taxd)))*ILD.l(jj)+(1+sum(taxd,tDuty_ILF.l(jj,taxd)))*(1+tCus_IL.l(jj))*ILF.l(jj))))*1000000);
tVAT_ILF.l(i) = tVAT_ILD.l(i); 

* EU-subsidier
SUBEU.l(j) = sum(ns73 $ mapns732j(j,ns73),PF73EUV('nTo',ns73))/1000000;

* BNP
gdp.l = (sum(ns73,  sum(npi5,  PF73V(npi5,ns73)+PIM73V(npi5,ns73)+PIB73V(npi5,ns73)))+sum(npi5,PX73V(npi5)+PZ73V(npi5)+PG73V(npi5)+PC73V(npi5)) + sum(ns73,FakDuty_B73V(ns73)+FakDuty_L73V(ns73)+FakDuty_ekso73V(ns73)+PF73EUV('nTo',ns73)))/1000000
       +(sum(taxd, sum(ns73r,  sum(ns73c,  DutyYFVx(ns73r,ns73c,taxd) + DutyMFVx(ns73r,ns73c,taxd) +DutyYIMVx(ns73r,ns73c,taxd)+DutyMIMVx(ns73r,ns73c,taxd)+DutyYIBVx(ns73r,ns73c,taxd)+DutyMIBVx(ns73r,ns73c,taxd)))) + sum(ns73r, sum(taxd, DutyYCVx(ns73r,taxd)+DutyMCVx(ns73r,taxd)+DutyYGVx(ns73r,taxd)+DutyMGVx(ns73r,taxd)+DutyYXVx(ns73r,taxd)+DutyMXVx(ns73r,taxd)+DutyYZVx(ns73r,taxd)+DutyMZVx(ns73r,taxd)))) /1000000     
       +(sum(ns73r, sum(ns73c, CF73V(ns73r,ns73c)+CIM73V(ns73r,ns73c)+CIB73V(ns73r,ns73c))) + sum(ns73r,CG73V(ns73r)+CC73V(ns73r)+CX73V(ns73r)+CZ73V(ns73r)))/1000000;

* Afskrivninger
KMtemp(j) = sum(ns73 $ mapns732j(j,ns73), KMU73V(ns73))/1000000 + 0.000001;
KBtemp(j) = sum(ns73 $ mapns732j(j,ns73), KBU73V(ns73))/1000000 + 0.000001;

* Afskrivningerne er de forventede fra ADAM gange det laggede kapitalapparat
AfskM(j) = sum(ns73 $ mapns732j(j,ns73), DKm73V(ns73))/1000000;
AfskB(j) = sum(ns73 $ mapns732j(j,ns73), DKb73V(ns73))/1000000;

deltaKM.l(j)$KMtemp(j) = AfskM(j)/KMtemp(j);
deltaKB.l(j)$KBtemp(j) = AfskB(j)/KBtemp(j);

deltaKM.l(jh) = sum(jb $ mapb2h(jh,jb), deltaKM.l(jb));

* BVT er lønsum, restindkomst og produktionsskatter
BVT.l(j) = Y.l(j) - sum(i, (1+tVAT_xD.l(j,i))*(1+sum(taxd,tDuty_xD.l(j,i,taxd)))*xD.l(j,i) + (1+tVAT_xF.l(j,i))*(1+tCus_x.l(j,i))*(1+sum(taxd,tDuty_xF.l(j,i,taxd)))*xF.l(j,i));

BVTtest(j) = BVT.l(j) - (L.l(j)+Rest(j)+sum(ns73 $ mapns732j(j,ns73), FakDuty_B73V(ns73))/1000000+sum(ns73 $ mapns732j(j,ns73), FakDuty_L73V(ns73))/1000000+sum(ns73 $ mapns732j(j,ns73), FakDuty_ekso73V(ns73))/1000000+sum(ns73 $ mapns732j(j,ns73), PF73EUV('nTo',ns73))/1000000);

* Forskel skal være afrundninger
display BVTtest;

BVTtot.l = sum(j,BVT.l(j));

Parameter Output, Indenlandsk, Import, Produktskatter_B, Produktskatter_L, Produktskatter_ekso, Produktskatter_EU, Arbejdskraft, Restindkomst;
Output(j) = Y.l(j);
Indenlandsk(j) = sum(i, (1+tVAT_xD.l(j,i))*(1+sum(taxd,tDuty_xD.l(j,i,taxd)))*xD.l(j,i));
Import(j) = sum(i, (1+tVAT_xF.l(j,i))*(1+tCus_x.l(j,i))*(1+sum(taxd,tDuty_xF.l(j,i,taxd)))*xF.l(j,i));
Produktskatter_B(j) = sum(ns73 $ mapns732j(j,ns73), FakDuty_B73V(ns73))/1000000;
Produktskatter_L(j) = sum(ns73 $ mapns732j(j,ns73), FakDuty_L73V(ns73))/1000000;
Produktskatter_ekso(j) = sum(ns73 $ mapns732j(j,ns73), FakDuty_ekso73V(ns73))/1000000;
Produktskatter_EU(j) = sum(ns73 $ mapns732j(j,ns73), PF73EUV('nTo',ns73))/1000000;
Arbejdskraft(j) = L.l(j);
Restindkomst(j) = Rest(j);
Display Output, Indenlandsk, Import, Produktskatter_B, Produktskatter_L, Produktskatter_ekso, Produktskatter_EU, Arbejdskraft, Restindkomst, BVT.l, BVTtest, BVTtot.l;

*include dummy.gms

* Forskel på marginal g gennemsnitlig forbrugsskattesats (inkl. told)
tDiff_cD.l(j) = (1+tVAT_cD.l(j))*(1 + sum(taxd,tDuty_cD.l(j,taxd))) -1 - tMarg_cD.l(j);
tDiff_cF.l(j) = (1+tVAT_cF.l(j))*(1 + sum(taxd,tDuty_cF.l(j,taxd)))*(1 + tCus_c.l(j))-1 - tMarg_cF.l(j);

* Værdien af indenlandsk og udenlandsk input beregnes inklusiv skat - hvilket er normal praksis
* Hermed skal outprisen normeres til 1, da produktionsværdien er inkl. produkt- og produktionsskat
P.l(j) = 1;
* Alle udenlandske priser normeres til 1, da vi vægter indenlandsk og udenlandsk input ens sammen
PF.l(j) = 1;
* Lønnen skal normeres til 1, da arbejdskraftinput er sat lig lønsum 
w.l  = 1;

* Vi vælger at normere de øvrige priser til 1
* Hermed skal deres mængder beregnes inkl. skat
Px.l(j,i) = 1;
Pxm.l(j,dm) = 1;
Pxe.l(j,dme) = 1;
pG.l(i) = 1;
PC.l(i) = 1;
PCH.l(dc) = 1;
PIMI.l(j,i) = 1;
PIM.l(j,dim) = 1;
PIBI.l(j,i) = 1;
PIB.l(j,dib) = 1;
P_Ex.l(i) = 1;
PIL.l(j) = 1;
PM.l(j) = 1;
PE.l(j) = 1;
PInvM.l(j) = 1;
PInvB.l(j) = 1;
P_udl.l(j) = (1+sum(taxd,tDuty_ExD.l(j,taxd)))*P.l(j);

* Aggregatet af udenlandske og indenlandske input beregnes inkl. skat
c.l(i)     = ((1+tMarg_cD.l(i))*cD.l(i) + (1+tMarg_cF.l(i))*cF.l(i))$(%NAF%)
            +((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))*cD.l(i) + (1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))*cF.l(i))$(%NOTNAF%);
x.l(j,i)   = (1+tVAT_xD.l(j,i))*(1+sum(taxd,tDuty_xD.l(j,i,taxd)))*xD.l(j,i)+(1+tVAT_xF.l(j,i))*(1+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i))*xF.l(j,i);
g.l(i)     = (1+tVAT_gD.l(i))*(1+sum(taxd,tDuty_gD.l(i,taxd)))*gD.l(i) + (1+tVAT_gF.l(i))*(1+sum(taxd,tDuty_gF.l(i,taxd)))*(1+tCus_g.l(i))*gF.l(i);
IMI.l(j,i) = (1+tVAT_IMD.l(j,i))*(1+sum(taxd,tDuty_IMD.l(j,i,taxd)))*IMID.l(j,i) + (1+tVAT_IMF.l(j,i))*(1+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i))*IMIF.l(j,i);
IBI.l(j,i) = (1+tVAT_IBD.l(j,i))*(1+sum(taxd,tDuty_IBD.l(j,i,taxd)))*IBID.l(j,i) + (1+tVAT_IBF.l(j,i))*(1+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))*IBIF.l(j,i);
Ex.l(i)    = (1+sum(taxd,tDuty_ExD.l(i,taxd)))*ExD.l(i) + (1+sum(taxd,tDuty_ExF.l(i,taxd)))*(1+tCus_Ex.l(i))*ExF.l(i);
IL.l(j)    = (1+tVAT_ILD.l(j))*(1+sum(taxd,tDuty_ILD.l(j,taxd)))*ILD.l(j) + (1+tVAT_ILF.l(j))*(1+sum(taxd,tDuty_ILF.l(j,taxd)))*(1+tCus_IL.l(j))*ILF.l(j);
M.l(j)     = sum(jjm,x.l(j,jjm));
E.l(j)     = sum(jjme,x.l(j,jjme));
cTot.l     = sum(i,c.l(i));
InvM.l(j)  = sum(i,IMI.l(j,i));
InvB.l(j)  = sum(i,IBI.l(j,i));
Ltot.l     = sum(j,L.l(j));

* Materialer
xm.l(j,dmi) = sum(i $ mapdm2i(i,dmi), x.l(j,i));
xm.l(j,dmm) = sum(dmi $ mapdm2dmo(dmm,dmi), xm.l(j,dmi));

xm.l(j,'m') = M.l(j);

m_xm.l(j,dm)$sum(dmo $ mapdm2dmo(dmo,dm), xm.l(j,dmo))  = xm.l(j,dm)/sum(dmo $ mapdm2dmo(dmo,dm), xm.l(j,dmo));

xe.l(j,dmei) = sum(i $ mapdme2i(i,dmei), x.l(j,i));
xe.l(j,dmem) = sum(dmei $ mapdme2dmeo(dmem,dmei), xe.l(j,dmei));

xe.l(j,'me') = E.l(j);

m_xe.l(j,dme)$sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo))  = xe.l(j,dme)/sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo));

* Maskininvesteringer
IM.l(j,dimi) = sum(i $ mapdim2i(i,dimi), IMI.l(j,i));
IM.l(j,dimm) = sum(dimi $ mapdim2dimo(dimm,dimi), IM.l(j,dimi));

IM.l(j,'im') = InvM.l(j);

m_IM.l(j,dim)$sum(dimo $ mapdim2dimo(dimo,dim), IM.l(j,dimo))  = IM.l(j,dim)/sum(dimo $ mapdim2dimo(dimo,dim), IM.l(j,dimo));

* Bygningsinvesteringer
IB.l(j,dibi) = sum(i $ mapdib2i(i,dibi), IBI.l(j,i));
IB.l(j,dibm) = sum(dibi $ mapdib2dibo(dibm,dibi), IB.l(j,dibi));

IB.l(j,'ib') = InvB.l(j);

m_IB.l(j,dib)$sum(dibo $ mapdib2dibo(dibo,dib), IB.l(j,dibo))  = IB.l(j,dib)/sum(dibo $ mapdib2dibo(dibo,dib), IB.l(j,dibo));

* Kapitalapparatet defineres ud fra steady state investeringerne 
KM.l(j)       = (1+grow.l)*InvM.l(j)/(grow.l + deltaKM.l(j));
KB.l(j)       = (1+grow.l)*InvB.l(j)/(grow.l + deltaKB.l(j));
KMbook.l(j)   = (1+grow.l)*PInvM.l(j)*InvM.l(j)/(grow.l + (deltaKMBook.l(j)+infl.l)/(1+infl.l));
KBbook.l(j)   = (1+grow.l)*PInvB.l(j)*InvB.l(j)/(grow.l + (deltaKBBook.l(j)+infl.l)/(1+infl.l));
KM0.l(j)      = KM.l(j);
KB0.l(j)      = KB.l(j);

* Kapitalomkostningen er givet usercost gange kapital
* Her sættes usercost lig renten plus afskrivningsraten
* De samlede omkostninger til kapital og arbejdskraft er PH.l(j)*H.l(j) = L.l(j)+uc.l(j)*K.l(j);
* Vi normerer omkostningerne til kapital og arbejdskraft
PH.l(j) = 1;
PLKE.l(j) = 1;
PKE.l(j) = 1;

* Vi definerer usercost-raten
ucM.l(j) = 1/(1-t_cor.l(j))*(r.l+deltaKM.l(j)-t_cor.l(j)*kvote_DP.l(j)*(r.l+infl.l/(1+infl.l))
          -t_cor.l(j)*deltaKMBook.l(j)/(1+infl.l)*(r.l+deltaKM.l(j))/(r.l+infl.l/(1+infl.l)+deltaKMBook.l(j)/(1+infl.l))) ;

ucB.l(j) = 1/(1-t_cor.l(j))*(r.l+deltaKB.l(j)-t_cor.l(j)*kvote_DP.l(j)*(r.l+infl.l/(1+infl.l))
          -t_cor.l(j)*deltaKBBook.l(j)/(1+infl.l)*(r.l+deltaKB.l(j))/(r.l+infl.l/(1+infl.l)+deltaKBBook.l(j)/(1+infl.l))) ;

ucB0.l(j) = ucB.l(j);
ucM0.l(j) = ucM.l(j);

tFak_w.l(j)$L.l(j) = (sum(ns73 $ mapns732j(j,ns73), FakDuty_L73V(ns73))/1000000)/ L.l(j);
tFak_B.l(j)$(KB.l(j)*ucB.l(j)) = (sum(ns73 $ mapns732j(j,ns73), FakDuty_B73V(ns73))/1000000)*(1+grow.l)/(KB.l(j)*ucB.l(j));
tFak_M.l(j) = 0;
Fak_rest.l(j) = sum(ns73 $ mapns732j(j,ns73), FakDuty_ekso73V(ns73))/1000000;

display tFak_B.l;
*$exit
tFak_B.l(j)$(tFak_B.l(j) < -1) = -0.99;
tFak_B.l(j)$(tFak_B.l(j) > 10) = 5;


* Hermed skal mængden være lig
KE.l(j)$PKE.l(j)  = ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l)+PE.l(j)*E.l(j))/PKE.l(j);

LKE.l(j)$PLKE.l(j)  = ((1+tFak_w.l(j))*w.l*L.l(j)+PKE.l(j)*KE.l(j))/PLKE.l(j);

H.l(j)$PH.l(j)  = (PLKE.l(j)*LKE.l(j)+(1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l))/PH.l(j);

* Prisen på de samlede stykomkostninger er givet ved: 
PO.l(j)$Y.l(j) = (PM.l(j)*M.l(j)+PH.l(j)*H.l(j))/Y.l(j);

* Herudfra beregnes mark-up'en
markup.l(j)$PO.l(j)  = P.l(j)/PO.l(j) - 1;
markup.l(j)$((markup.l(j) lt 0.001) AND (markup.l(j) gt -0.001)) = 0; 

Parameter Kapitalomkostning_M, Kapitalomkostning_B, Arbejdskraftomkostning;
Kapitalomkostning_M(j) = (1+tFak_M.l(j))*ucM.l(j)*KM.l(j)/(1+grow.l);
Kapitalomkostning_B(j) = (1+tFak_B.l(j))*ucB.l(j)*KB.l(j)/(1+grow.l);
Arbejdskraftomkostning(j) = (1+tFak_w.l(j))*L.l(j);

display Y.l, M.l, E.l, KE.l, LKE.l, H.l, Kapitalomkostning_M, Kapitalomkostning_B, Arbejdskraftomkostning, markup.l;
display tFak_M.l, tFak_B.l, ucM.l, ucB.l, KM.l, KB.l, deltaKM.l, deltaKB.l, InvM.l, InvB.l;

* Prisen PU normeres
PU.l = 1;
*Arbejdsmarked
hour.l = 1;

N_Emp.l$(%NYTADD%) = sum(j,L.l(j)) / hour.l;
N_Emp.l$(%NYTMUL%) = sum(j,L.l(j));

X_h.l = hour.l/(( (1 - t_w.l)*w.l)**(Elas_hour.l)*h_bar.l);

N_LabForce.l = N_Emp.l / (1-unemp.l);
N_Pop.l = N_LabForce.l / labForceShare.l; 

* Virksomhedens gæld er proportional med dens kapitalapparat
DP.l(j) = kvote_DP.l(j) * (PInvM.l(j) * KM.l(j) + PInvB.l(j) * KB.l(j));

* Virksomheden betaler sit overskud som dividender
* Bemærk PI*Inv = PI*(grow.l + delta.l(j))*K - så der udbetales profit og en vækstkorrigeret realrente på KØ
* VIRKSOMHEDERNES DIVIDENDE TOG IKKE HØJDE FOR PRODUKTIONSSKATTER + NOMINEL RENTE RETTET + VÆKST OG INFLATIONSKORREKTION AF KBook
DIV.l(j) = (1-t_cor.l(j))*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) 
                                  - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) ) - PInvM.l(j)*InvM.l(j) - PInvB.l(j)*InvB.l(j) - PIL.l(j)*IL.l(j) 
                                  - SUBEU.l(j)
                                  + t_cor.l(j)*(deltaKMBook.l(j)*KMBook.l(j)+deltaKBBook.l(j)*KBBook.l(j))/((1+grow.l)*(1+infl.l)) + (1-1/((1+grow.l)*(1+infl.l)))*DP.l(j);

* Virksomheden værdi er lig dens tilbagediskonterede værdi (burde det være den vækstkorrigerede rente?) 
V.l(j) = (1+grow.l)*DIV.l(j)/(r.l-grow.l);
* Lagerbeholdningen gives som en fast andel af produktionen
c_lager.l(j)$Y.l(j) = IL.l(j)/Y.l(j); 

* Den samlede værdi for alle virksomheder er den simple sum
Vtot = sum(j, V.l(j));

* Statisk Kalibrering
* Den grundlæggende eksport sættes lig den faktiske eksport
* Her er det inkl. import til reeksport - det kan modelleres om
X0.l(j) = Ex.l(j);

* Andelsparametre findes ved at vende modellens ligninger på hovedet
* Vi udnytter, at en masse priser er lig 1 i kalibreringsåret

* Andelsparametre for materialekøb vs. aggregat af kapital og arbejdskraft
m_YM.l(j)$Y.l(j) = PO.l(j)**(-EY.l(j))*M.l(j) / Y.l(j); 
m_YH.l(j)$Y.l(j) = PO.l(j)**(-EY.l(j))*H.l(j) / Y.l(j); 

* Andelsparametre for bygninger vs. aggregat af maskinkapital og arbejdskraft
m_HB.l(j)$H.l(j)  = ((1+tFak_B.l(j))*ucB.l(j))**EH.l(j)*(KB.l(j)/(1+grow.l)) / H.l(j); 
m_HLKE.l(j)$H.l(j) = LKE.l(j) / H.l(j); 

* Andelsparametre for arbejdskraft vs. kapital
* NB: Andelsparametrene summerer ikke, da usercost ikke er normeret til 1 - det er ok
m_LKEL.l(j)$LKE.l(j) = (1+tFak_w.l(j))**(ELKE.l(j))*L.l(j) / LKE.l(j); 
m_LKEKE.l(j)$LKE.l(j) = KE.l(j) / LKE.l(j); 
m_KEE.l(j)$KE.l(j) = E.l(j) / KE.l(j); 
m_KEK.l(j)$KE.l(j) = (1+tFak_M.l(j))*ucM.l(j)**EKE.l(j)*(KM.l(j)/(1+grow.l)) / KE.l(j); 

*Andelsparametre for branche j's materialekøb hos branche i for hhv. indenlandske og udenlandske varer 
m_xD.l(j,i)$x.l(j,i) = ((1+tVAT_xD.l(j,i))*(1+sum(taxd,tDuty_xD.l(j,i,taxd))))**(Exx.l(j)) * xD.l(j,i) / x.l(j,i); 
m_xF.l(j,i)$x.l(j,i) = ((1+tVAT_xF.l(j,i))*(1+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i)))**(Exx.l(j)) * xF.l(j,i) / x.l(j,i); 

*Andelsparametre for branche j's investeringsinput fra branche i for hhv. indenlandske og udenlandske varer 
m_IMD.l(j,i)$IMI.l(j,i) = ((1+tVAT_IMD.l(j,i))*(1+sum(taxd,tDuty_IMD.l(j,i,taxd))))**(EIMI.l(j)) * IMID.l(j,i) / IMI.l(j,i); 
m_IBD.l(j,i)$((IBI.l(j,i) ne 0) and ((1+tVAT_IBD.l(j,i))*(1+sum(taxd,tDuty_IBD.l(j,i,taxd)))) gt 0) = ((1+tVAT_IBD.l(j,i))*(1+sum(taxd,tDuty_IBD.l(j,i,taxd))))**(EIBI.l(j)) * IBID.l(j,i) / IBI.l(j,i); 
m_IMF.l(j,i)$IMI.l(j,i) = ((1+tVAT_IMF.l(j,i))*(1+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i)))**(EIMI.l(j)) * IMIF.l(j,i) / IMI.l(j,i); 
m_IBF.l(j,i)$((IBI.l(j,i) ne 0) and ((1+tVAT_IBF.l(j,i))*(1+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))) gt 0) = ((1+tVAT_IBF.l(j,i))*(1+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i)))**(EIBI.l(j)) * IBIF.l(j,i) / IBI.l(j,i); 

*Andelsparametre for branche j's lagerinvesteringer for hhv. indenlandske og udenlandske varer 
m_ILD.l(j)$IL.l(j) = ((1+tVAT_ILD.l(j))*(1+sum(taxd,tDuty_ILD.l(j,taxd))))**(EIL.l(j)) * ILD.l(j) / IL.l(j); 
m_ILF.l(j)$IL.l(j) = ((1+tVAT_ILF.l(j))*(1+sum(taxd,tDuty_ILF.l(j,taxd)))*(1+tCus_IL.l(j)))**(EIL.l(j)) * ILF.l(j) / IL.l(j); 

* Andelsparametre for hvor stor en andel af eksportefterspørgslen som mættes af import til reeksport (lidt sjov modellering - kan ændres)
m_ExD.l(j)$Ex.l(j) = (1+sum(taxd,tDuty_ExD.l(j,taxd)))**(EEx.l(j)) * ExD.l(j) / Ex.l(j); 
m_ExF.l(j)$Ex.l(j) = ((1+sum(taxd,tDuty_ExF.l(j,taxd)))*(1+tCus_Ex.l(j)))**(EEx.l(j)) * ExF.l(j) / Ex.l(j); 

* Andelsparametre for hvor stor en andel af offentligt forbrug der er import
m_gD.l(j)$g.l(j) = ((1+tVAT_gD.l(j))*(1+sum(taxd,tDuty_gD.l(j,taxd))))**(Eg.l) * gD.l(j) / g.l(j); 
m_gF.l(j)$g.l(j) = ((1+tVAT_gF.l(j))*(1+sum(taxd,tDuty_gF.l(j,taxd)))*(1+tCus_g.l(j)))**(Eg.l) * gF.l(j) / g.l(j); 

PInvM0.l(j) = 1;
PInvB0.l(j) = 1;

lumpsum.l = 0;

TaxEU.l =                  sum(i,sum(j,tCus_x.l(j,i)*xF.l(j,i))) 
                         + sum(i,sum(j,tCus_IM.l(j,i)*IMIF.l(j,i)+ tCus_IB.l(j,i)*IBIF.l(j,i)))
                         + sum(i,tCus_c.l(i)*cF.l(i)) 
                         + sum(i,tCus_g.l(i)*gF.l(i)) 
                         + sum(i,tCus_IL.l(i)*ILF.l(i))
                         + sum(i,tCus_Ex.l(i)*ExF.l(i))
                         + sum(j,SUBEU.l(j))
                         ;

Wealth.l = ((1+grow.l)*(CTot.l-(w.l*hour.l*N_Emp.l                 
                   +  sum(j,sum(i,sum(taxd,tDuty_xD.l(j,i,taxd))*xD.l(j,i) + (1+sum(taxd,tDuty_xD.l(j,i,taxd)))*tVAT_xD.l(j,i)*xD.l(j,i) + sum(taxd,tDuty_xF.l(j,i,taxd))*(1+tCus_x.l(j,i))*xF.l(j,i) + (1+sum(taxd,tDuty_xF.l(j,i,taxd)))*tVAT_xF.l(j,i)*(1+tCus_x.l(j,i))*xF.l(j,i) 
                   +  sum(taxd,tDuty_IMD.l(j,i,taxd))*IMID.l(j,i) + (1+sum(taxd,tDuty_IMD.l(j,i,taxd)))*tVAT_IMD.l(j,i)*IMID.l(j,i) + sum(taxd,tDuty_IMF.l(j,i,taxd))*(1+tCus_IM.l(j,i))*IMIF.l(j,i) + (1+sum(taxd,tDuty_IMF.l(j,i,taxd)))*tVAT_IMF.l(j,i)*(1+tCus_IM.l(j,i))*IMIF.l(j,i) 
                   +  sum(taxd,tDuty_IBD.l(j,i,taxd))*IBID.l(j,i) + (1+sum(taxd,tDuty_IBD.l(j,i,taxd)))*tVAT_IBD.l(j,i)*IBID.l(j,i) + sum(taxd,tDuty_IBF.l(j,i,taxd))*(1+tCus_IB.l(j,i))*IBIF.l(j,i) + (1+sum(taxd,tDuty_IBF.l(j,i,taxd)))*tVAT_IBF.l(j,i)*(1+tCus_IB.l(j,i))*IBIF.l(j,i)))                    
                   + sum(i,sum(taxd,tDuty_cD.l(i,taxd))*cD.l(i) + (1+sum(taxd,tDuty_cD.l(i,taxd)))*tVAT_cD.l(i)*cD.l(i) + sum(taxd,tDuty_cF.l(i,taxd))*(1+tCus_c.l(i))*cF.l(i) + (1+sum(taxd,tDuty_cF.l(i,taxd)))*tVAT_cF.l(i)*(1+tCus_c.l(i))*cF.l(i)) 
                   + sum(i,sum(taxd,tDuty_gD.l(i,taxd))*gD.l(i) + (1+sum(taxd,tDuty_gD.l(i,taxd)))*tVAT_gD.l(i)*gD.l(i) + sum(taxd,tDuty_gF.l(i,taxd))*(1+tCus_g.l(i))*gF.l(i) + (1+sum(taxd,tDuty_gF.l(i,taxd)))*tVAT_gF.l(i)*(1+tCus_g.l(i))*gF.l(i)) 
                   + sum(i,sum(taxd,tDuty_ILD.l(i,taxd))*ILD.l(i) + (1+sum(taxd,tDuty_ILD.l(i,taxd)))*tVAT_ILD.l(i)*ILD.l(i) + sum(taxd,tDuty_ILF.l(i,taxd))*(1+tCus_IL.l(i))*ILF.l(i) + (1+sum(taxd,tDuty_ILF.l(i,taxd)))*tVAT_ILF.l(i)*(1+tCus_IL.l(i))*ILF.l(i)) 
                   + sum(i,sum(taxd,tDuty_ExD.l(i,taxd))*ExD.l(i) + sum(taxd,tDuty_ExF.l(i,taxd))*(1+tCus_Ex.l(i))*ExF.l(i))                   
                  + sum(j, t_cor.l(j)*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) 
                                                       - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - (deltaKMBook.l(j)*KMBook.l(j)+deltaKBBook.l(j)*KBBook.l(j))/((1+grow.l)*(1+infl.l)) ))
                   + sum(j, tFak_w.l(j)*w.l*L.l(j) + tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) + Fak_rest.l(j)) 
                     - sum(j, PG.l(j)*g.l(j))                    
                       + sum(i,(tMarg_cD.l(i)- ((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))-p.l(i)))*cD.l(i) + (tMarg_cF.l(i)-((1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))-p.l(i)))*cF.l(i))))/(r.l-grow.l))$(%NAF%) 
 +
                    ((1+grow.l)*(CTot.l-(w.l*hour.l*N_Emp.l 
                   +  sum(j,sum(i,sum(taxd,tDuty_xD.l(j,i,taxd))*xD.l(j,i) + (1+sum(taxd,tDuty_xD.l(j,i,taxd)))*tVAT_xD.l(j,i)*xD.l(j,i) + sum(taxd,tDuty_xF.l(j,i,taxd))*(1+tCus_x.l(j,i))*xF.l(j,i) + (1+sum(taxd,tDuty_xF.l(j,i,taxd)))*tVAT_xF.l(j,i)*(1+tCus_x.l(j,i))*xF.l(j,i) 
                   +  sum(taxd,tDuty_IMD.l(j,i,taxd))*IMID.l(j,i) + (1+sum(taxd,tDuty_IMD.l(j,i,taxd)))*tVAT_IMD.l(j,i)*IMID.l(j,i) + sum(taxd,tDuty_IMF.l(j,i,taxd))*(1+tCus_IM.l(j,i))*IMIF.l(j,i) + (1+sum(taxd,tDuty_IMF.l(j,i,taxd)))*tVAT_IMF.l(j,i)*(1+tCus_IM.l(j,i))*IMIF.l(j,i) 
                   +  sum(taxd,tDuty_IBD.l(j,i,taxd))*IBID.l(j,i) + (1+sum(taxd,tDuty_IBD.l(j,i,taxd)))*tVAT_IBD.l(j,i)*IBID.l(j,i) + sum(taxd,tDuty_IBF.l(j,i,taxd))*(1+tCus_IB.l(j,i))*IBIF.l(j,i) + (1+sum(taxd,tDuty_IBF.l(j,i,taxd)))*tVAT_IBF.l(j,i)*(1+tCus_IB.l(j,i))*IBIF.l(j,i)))                    
                   + sum(i,sum(taxd,tDuty_cD.l(i,taxd))*cD.l(i) + (1+sum(taxd,tDuty_cD.l(i,taxd)))*tVAT_cD.l(i)*cD.l(i) + sum(taxd,tDuty_cF.l(i,taxd))*(1+tCus_c.l(i))*cF.l(i) + (1+sum(taxd,tDuty_cF.l(i,taxd)))*tVAT_cF.l(i)*(1+tCus_c.l(i))*cF.l(i)) 
                   + sum(i,sum(taxd,tDuty_gD.l(i,taxd))*gD.l(i) + (1+sum(taxd,tDuty_gD.l(i,taxd)))*tVAT_gD.l(i)*gD.l(i) + sum(taxd,tDuty_gF.l(i,taxd))*(1+tCus_g.l(i))*gF.l(i) + (1+sum(taxd,tDuty_gF.l(i,taxd)))*tVAT_gF.l(i)*(1+tCus_g.l(i))*gF.l(i)) 
                   + sum(i,sum(taxd,tDuty_ILD.l(i,taxd))*ILD.l(i) + (1+sum(taxd,tDuty_ILD.l(i,taxd)))*tVAT_ILD.l(i)*ILD.l(i) + sum(taxd,tDuty_ILF.l(i,taxd))*(1+tCus_IL.l(i))*ILF.l(i) + (1+sum(taxd,tDuty_ILF.l(i,taxd)))*tVAT_ILF.l(i)*(1+tCus_IL.l(i))*ILF.l(i)) 
                   + sum(i,sum(taxd,tDuty_ExD.l(i,taxd))*ExD.l(i) + sum(taxd,tDuty_ExF.l(i,taxd))*(1+tCus_Ex.l(i))*ExF.l(i))                    
                  + sum(j, t_cor.l(j)*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) 
                                                                         - (deltaKMBook.l(j)*KMBook.l(j)+deltaKBBook.l(j)*KBBook.l(j))/((1+grow.l)*(1+infl.l)) ))
                     + sum(j, tFak_w.l(j)*w.l*L.l(j) + tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) + Fak_rest.l(j)) 
 
                      - sum(j, PG.l(j)*g.l(j))                    
*                     + sum(i,(tMarg_cD.l(i)-tVAT_cD.l(i)-tDuty_cD.l(i))*p.l(i)*cD.l(i) + (tMarg_cF.l(i)-tVAT_cF.l(i)-tDuty_cF.l(i)-tCus_c.l(i))*PF.l(i)*cF.l(i))
                     ))/(r.l-grow.l))$(%NOTNAF%)                  
                     ; 
Wealth_F.l = Wealth.l - sum(j, share_D.l(j)*V.l(j));

* Trans, så saldo = 0
Trans.l       =    ( sum(j, sum(i, ((1+tVAT_xD.l(j,i))*(p.l(i)+sum(taxd,tDuty_xD.l(j,i,taxd)))-1)*xD.l(j,i) + ((1+tVAT_xF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i))-1)*xF.l(j,i)))
                          + sum(i, ((1+tVAT_CD.l(i))*(p.l(i)+sum(taxd,tDuty_CD.l(i,taxd)))-1)*cD.l(i) + ((1+tVAT_CF.l(i))*(pF.l(i)+sum(taxd,tDuty_CF.l(i,taxd)))*(1+tCus_C.l(i))-1)*cF.l(i))
                          + sum(i, ((1+tVAT_GD.l(i))*(p.l(i)+sum(taxd,tDuty_GD.l(i,taxd)))-1)*gD.l(i) + ((1+tVAT_GF.l(i))*(pF.l(i)+sum(taxd,tDuty_GF.l(i,taxd)))*(1+tCus_G.l(i))-1)*gF.l(i))
                          + sum(i, ((1+tVAT_ILD.l(i))*(p.l(i)+sum(taxd,tDuty_ILD.l(i,taxd)))-1)*ILD.l(i) + ((1+tVAT_ILF.l(i))*(pF.l(i)+sum(taxd,tDuty_ILF.l(i,taxd)))*(1+tCus_IL.l(i))-1)*ILF.l(i))
                          + sum(i, ((p.l(i)+sum(taxd,tDuty_ExD.l(i,taxd)))-1)*ExD.l(i) + ((pF.l(i)+sum(taxd,tDuty_ExF.l(i,taxd)))*(1+tCus_Ex.l(i))-1)*ExF.l(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IMD.l(j,i,taxd)))-1)*IMID.l(j,i) + ((1+tVAT_IMF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i))-1)*IMIF.l(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IBD.l(j,i,taxd)))-1)*IBID.l(j,i) + ((1+tVAT_IBF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))-1)*IBIF.l(j,i)))
                         + t_w.l * (w.l*hour.l*N_Emp.l + (N_LabForce.l-N_Emp.l)*rateComp.l*w.l)
                         + t_r.l * (r.l-grow.l) * Wealth.l/(1+grow.l)
                         + sum(j, t_cor.l(j)*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j)- PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*(ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l)) - Fak_rest.l(j) 
                                                   - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - (deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l) )))
                         - sum(j, PG.l(j)*g.l(j)) -(N_LabForce.l-N_Emp.l)*rateComp.l*w.l
                         - lumpsum.l*N_Pop.l
                         + sum(j, tFak_w.l(j)*w.l*L.l(j) + tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*(ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l)) + Fak_rest.l(j))                         
* Fratrækker told da dette går til EU og ikke staten
                         -(sum(i,sum(j,tCus_x.l(j,i)*xF.l(j,i))) 
                         + sum(i,sum(j,tCus_IM.l(j,i)*IMIF.l(j,i)+ tCus_IB.l(j,i)*IBIF.l(j,i)))
                         + sum(i,tCus_c.l(i)*cF.l(i)) 
                         + sum(i,tCus_Ex.l(i)*ExF.l(i)) 
                         + sum(i,tCus_g.l(i)*gF.l(i)) 
                         + sum(i,tCus_IL.l(i)*ILF.l(i))))/(1-t_w.l);                         


Trans0.l  = Trans.l / (N_Pop.l - N_Emp.l);

*Beregner saldo - skal give 0 ellers er der en fejl!
PSaldo.l =                 sum(j, sum(i, ((1+tVAT_xD.l(j,i))*(p.l(i)+sum(taxd,tDuty_xD.l(j,i,taxd)))-1)*xD.l(j,i) + ((1+tVAT_xF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i))-1)*xF.l(j,i)))
                          + sum(i, ((1+tVAT_CD.l(i))*(p.l(i)+sum(taxd,tDuty_CD.l(i,taxd)))-1)*cD.l(i) + ((1+tVAT_CF.l(i))*(pF.l(i)+sum(taxd,tDuty_CF.l(i,taxd)))*(1+tCus_C.l(i))-1)*cF.l(i))
                          + sum(i, ((1+tVAT_GD.l(i))*(p.l(i)+sum(taxd,tDuty_GD.l(i,taxd)))-1)*gD.l(i) + ((1+tVAT_GF.l(i))*(pF.l(i)+sum(taxd,tDuty_GF.l(i,taxd)))*(1+tCus_G.l(i))-1)*gF.l(i))
                          + sum(i, ((1+tVAT_ILD.l(i))*(p.l(i)+sum(taxd,tDuty_ILD.l(i,taxd)))-1)*ILD.l(i) + ((1+tVAT_ILF.l(i))*(pF.l(i)+sum(taxd,tDuty_ILF.l(i,taxd)))*(1+tCus_IL.l(i))-1)*ILF.l(i))
                          + sum(i, ((p.l(i)+sum(taxd,tDuty_ExD.l(i,taxd)))-1)*ExD.l(i) + ((pF.l(i)+sum(taxd,tDuty_ExF.l(i,taxd)))*(1+tCus_Ex.l(i))-1)*ExF.l(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IMD.l(j,i,taxd)))-1)*IMID.l(j,i) + ((1+tVAT_IMF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i))-1)*IMIF.l(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IBD.l(j,i,taxd)))-1)*IBID.l(j,i) + ((1+tVAT_IBF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))-1)*IBIF.l(j,i)))
                         + t_w.l * (w.l*hour.l*N_Emp.l + (N_LabForce.l-N_Emp.l)*rateComp.l*w.l + Trans.l)
                         + t_r.l * (r.l-grow.l) * Wealth.l/(1+grow.l)
                         + sum(j, t_cor.l(j)*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j)- PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) 
                                                   - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - (deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l) )))
                         - Trans.l - sum(j, PG.l(j)*g.l(j)) -(N_LabForce.l-N_Emp.l)*rateComp.l*w.l
                         - lumpsum.l*N_Pop.l
                         + sum(j, tFak_w.l(j)*w.l*L.l(j) + tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) + Fak_rest.l(j))                         
* Fratrækker told da dette går til EU og ikke staten
                         -(sum(i,sum(j,tCus_x.l(j,i)*xF.l(j,i))) 
                         + sum(i,sum(j,tCus_IM.l(j,i)*IMIF.l(j,i)+ tCus_IB.l(j,i)*IBIF.l(j,i)))
                         + sum(i,tCus_c.l(i)*cF.l(i)) 
                         + sum(i,tCus_Ex.l(i)*ExF.l(i)) 
                         + sum(i,tCus_g.l(i)*gF.l(i)) 
                         + sum(i,tCus_IL.l(i)*ILF.l(i)));
 
 
YEmp.l  = ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l
       + sum(i,(tMarg_cD.l(i)- ((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))-p.l(i)))*cD.l(i) + (tMarg_cF.l(i)-((1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))-PF.l(i)))*cF.l(i))*N_Emp.l/N_Pop.l)$(%NAF%)
       + ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l)$(%NOTNAF%);                     

YNotEmp.l = ((1 - t_w.l)*rateComp.l*w.l*(N_LabForce.l-N_Emp.l) + (1 - t_r.l)*(N_Pop.l-N_Emp.l)*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l 
        + (1-t_w.l)*Trans.l + lumpsum.l*(N_Pop.l-N_Emp.l)
        + sum(i,(tMarg_cD.l(i)- ((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))-p.l(i)))*cD.l(i) + (tMarg_cF.l(i)-((1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))-PF.l(i)))*cF.l(i))*(N_Pop.l-N_Emp.l)/N_Pop.l)$(%NAF%)
        +
          ((1 - t_w.l)*rateComp.l*w.l*(N_LabForce.l-N_Emp.l) + (1 - t_r.l)*(N_Pop.l-N_Emp.l)*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l 
        + (1-t_w.l)*Trans.l + lumpsum.l*(N_Pop.l-N_Emp.l))$(%NOTNAF%);

YZ.l = ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l - (Elas_hour.l/(Elas_hour.l+1))*(1 - t_w.l)*w.l*hour.l*N_Emp.l
     + sum(i,(tMarg_cD.l(i)- ((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))-p.l(i)))*cD.l(i) + (tMarg_cF.l(i)-((1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))-PF.l(i)))*cF.l(i))*N_Emp.l/N_Pop.l)$(%NAF% and %NYTADD%)
     +
     ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l - (Elas_hour.l/(Elas_hour.l+1))*(1 - t_w.l)*w.l*hour.l*N_Emp.l)$(%NOTNAF% and %NYTADD%)
     + 
     ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l 
     + sum(i,(tMarg_cD.l(i)- (1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd)))-1)*p.l(i)*cD.l(i) + (tMarg_cF.l(i)-(1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i))-1)*PF.l(i)*cF.l(i))*N_Emp.l/N_Pop.l)$(%NAF% and %NYTMUL%)
     +
     ((1 - t_w.l)*w.l*hour.l*N_Emp.l + (1 - t_r.l)*N_Emp.l*((r.l-grow.l)*Wealth.l/(1+grow.l))/N_Pop.l + lumpsum.l*N_Emp.l)$(%NOTNAF% and %NYTMUL%);

VV.l = (h_bar.l - hour.l)*N_Emp.l;

C_Emp.l = YEmp.l$(%NYTADD%) +(YZ.l - (1-t_w.l)*VV.l)$(%NYTMUL%);

C_NotEmp.l = YNotEmp.l;
m_UC.l = C_Emp.l/YZ.l;
m_UV.l = ((1-t_w.l)*w.l)**(EU.l)*VV.l/YZ.l;
m_cD.l(i)$c.l(i) = ((1+tMarg_cD.l(i))**(Ecc.l(i))*cD.l(i)/c.l(i))$(%NAF%) + (((1+tVAT_cD.l(i))*(1+sum(taxd,tDuty_cD.l(i,taxd))))**(Ecc.l(i))*cD.l(i)/c.l(i))$(%NOTNAF%);
m_cF.l(i)$c.l(i) = ((1+tMarg_cF.l(i))**(Ecc.l(i))*cF.l(i)/c.l(i))$(%NAF%) + (((1+tVAT_cF.l(i))*(1+sum(taxd,tDuty_cF.l(i,taxd)))*(1+tCus_c.l(i)))**(Ecc.l(i))*cF.l(i)/c.l(i))$(%NOTNAF%);
*-------------------------------------
CH.l(dci) = sum(i $ mapdc2i(i,dci), C.l(i));
CH.l(dcm) = sum(dci $ mapdc2dco(dcm,dci), CH.l(dci));

CH.l('nge') = CH.l('ng')+CH.l('ne');
CH.l('iqo') = CH.l('a')+CH.l('e')+CH.l('nf')+CH.l('nz')+CH.l('b');

CH.l('c')    = CTot.l;
CH.l('ih')   = CH.l('c')-CH.l('h');
CH.l('inge') = CH.l('ih')-CH.l('nge');
CH.l('qo')   = CH.l('inge')-CH.l('iqo');
CH.l('q')    = CH.l('qo')-CH.l('o');
CH.l('qz')   = CH.l('q')-CH.l('qs')-CH.l('qf');

m_CH.l(dc)$sum(dco $ mapdc2dco(dco,dc), CH.l(dco))  = CH.l(dc)/sum(dco $ mapdc2dco(dco,dc), CH.l(dco));

GDP.l                =    sum(j, p.l(j)*Y.l(j)) - sum(j,sum(i, p.l(i)*xD.l(j,i) + PF.l(i)*xF.l(j,i)))
                          + sum(i, ((1+tVAT_CD.l(i))*(p.l(i)+sum(taxd,tDuty_CD.l(i,taxd)))-1)*cD.l(i) + ((1+tVAT_CF.l(i))*(pF.l(i)+sum(taxd,tDuty_CF.l(i,taxd)))*(1+tCus_C.l(i))-1)*cF.l(i))
                          + sum(i, ((1+tVAT_GD.l(i))*(p.l(i)+sum(taxd,tDuty_GD.l(i,taxd)))-1)*gD.l(i) + ((1+tVAT_GF.l(i))*(pF.l(i)+sum(taxd,tDuty_GF.l(i,taxd)))*(1+tCus_G.l(i))-1)*gF.l(i))
                          + sum(i, ((1+tVAT_ILD.l(i))*(p.l(i)+sum(taxd,tDuty_ILD.l(i,taxd)))-1)*ILD.l(i) + ((1+tVAT_ILF.l(i))*(pF.l(i)+sum(taxd,tDuty_ILF.l(i,taxd)))*(1+tCus_IL.l(i))-1)*ILF.l(i))
                          + sum(i, ((p.l(i)+sum(taxd,tDuty_ExD.l(i,taxd)))-1)*ExD.l(i) + ((pF.l(i)+sum(taxd,tDuty_ExF.l(i,taxd)))*(1+tCus_Ex.l(i))-1)*ExF.l(i))
                          + sum(j, sum(i, ((1+tVAT_IMD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IMD.l(j,i,taxd)))-1)*IMID.l(j,i) + ((1+tVAT_IMF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i))-1)*IMIF.l(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IBD.l(j,i,taxd)))-1)*IBID.l(j,i) + ((1+tVAT_IBF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))-1)*IBIF.l(j,i))); 
  
 
* Fastsættelse af basisårets priser og skatter
* Basisåret sættes lig kalibreringsåret
p0.l(j)      = p.l(j);
PF0.l(j)     = PF.l(j);
tCus_x0.l(j,i) = tCus_x.l(j,i);
tCus_IM0.l(j,i) = tCus_IM.l(j,i);
tCus_IB0.l(j,i) = tCus_IB.l(j,i);
tCus_c0.l(i)   = tCus_c.l(i);  
tCus_Ex0.l(i)  = tCus_Ex.l(i); 
tCus_IL0.l(i)  = tCus_IL.l(i); 
tCus_G0.l(i)   = tCus_G.l(i);  
tDuty_xD0.l(j,i,taxd) = tDuty_xD.l(j,i,taxd);
tDuty_xF0.l(j,i,taxd) = tDuty_xF.l(j,i,taxd);
tDuty_IMD0.l(j,i,taxd) = tDuty_IMD.l(j,i,taxd);
tDuty_IBD0.l(j,i,taxd) = tDuty_IBD.l(j,i,taxd);
tDuty_IMF0.l(j,i,taxd) = tDuty_IMF.l(j,i,taxd);
tDuty_IBF0.l(j,i,taxd) = tDuty_IBF.l(j,i,taxd);
tDuty_cD0.l(i,taxd)   = tDuty_cD.l(i,taxd);  
tDuty_cF0.l(i,taxd)   = tDuty_cF.l(i,taxd);  
tDuty_ExD0.l(i,taxd)  = tDuty_ExD.l(i,taxd); 
tDuty_ExF0.l(i,taxd)  = tDuty_ExF.l(i,taxd); 
tDuty_ILD0.l(i,taxd)  = tDuty_ILD.l(i,taxd); 
tDuty_ILF0.l(i,taxd)  = tDuty_ILF.l(i,taxd); 
tDuty_GD0.l(i,taxd)   = tDuty_GD.l(i,taxd);  
tDuty_GF0.l(i,taxd)   = tDuty_GF.l(i,taxd);  
tVAT_xD0.l(j,i) = tVAT_xD.l(j,i);
tVAT_xF0.l(j,i) = tVAT_xF.l(j,i);
tVAT_IMD0.l(j,i) = tVAT_IMD.l(j,i);
tVAT_IBD0.l(j,i) = tVAT_IBD.l(j,i);
tVAT_IMF0.l(j,i) = tVAT_IMF.l(j,i);
tVAT_IBF0.l(j,i) = tVAT_IBF.l(j,i);
tVAT_cD0.l(i)   = tVAT_cD.l(i);  
tVAT_cF0.l(i)   = tVAT_cF.l(i);  
tVAT_ILD0.l(i)  = tVAT_ILD.l(i); 
tVAT_ILF0.l(i)  = tVAT_ILF.l(i); 
tVAT_GD0.l(i)   = tVAT_GD.l(i);  
tVAT_GF0.l(i)   = tVAT_GF.l(i);  

GDPf0.l                   =    sum(j, p0.l(j)*Y.l(j)) - sum(j,sum(i, p0.l(i)*xD.l(j,i) + PF0.l(i)*xF.l(j,i)))
                          + sum(i, ((1+tVAT_CD0.l(i))*(p0.l(i)+sum(taxd,tDuty_CD0.l(i,taxd)))-1)*cD.l(i) + ((1+tVAT_CF0.l(i))*(pF0.l(i)+sum(taxd,tDuty_CF0.l(i,taxd)))*(1+tCus_C0.l(i))-1)*cF.l(i))
                          + sum(i, ((1+tVAT_GD0.l(i))*(p0.l(i)+sum(taxd,tDuty_GD0.l(i,taxd)))-1)*gD.l(i) + ((1+tVAT_GF0.l(i))*(pF0.l(i)+sum(taxd,tDuty_GF0.l(i,taxd)))*(1+tCus_G0.l(i))-1)*gF.l(i))
                          + sum(i, ((1+tVAT_ILD0.l(i))*(p0.l(i)+sum(taxd,tDuty_ILD0.l(i,taxd)))-1)*ILD.l(i) + ((1+tVAT_ILF0.l(i))*(pF0.l(i)+sum(taxd,tDuty_ILF0.l(i,taxd)))*(1+tCus_IL0.l(i))-1)*ILF.l(i))
                          + sum(i, ((p0.l(i)+sum(taxd,tDuty_ExD0.l(i,taxd)))-1)*ExD.l(i) + ((pF0.l(i)+sum(taxd,tDuty_ExF0.l(i,taxd)))*(1+tCus_Ex0.l(i))-1)*ExF.l(i))
                          + sum(j, sum(i, ((1+tVAT_IMD0.l(j,i))*(p0.l(i)+sum(taxd,tDuty_IMD0.l(j,i,taxd)))-1)*IMID.l(j,i) + ((1+tVAT_IMF0.l(j,i))*(pF0.l(i)+sum(taxd,tDuty_IMF0.l(j,i,taxd)))*(1+tCus_IM0.l(j,i))-1)*IMIF.l(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD0.l(j,i))*(p0.l(i)+sum(taxd,tDuty_IBD0.l(j,i,taxd)))-1)*IBID.l(j,i) + ((1+tVAT_IBF0.l(j,i))*(pF0.l(i)+sum(taxd,tDuty_IBF0.l(j,i,taxd)))*(1+tCus_IB0.l(j,i))-1)*IBIF.l(j,i))); 

BVT.l(j) = p.l(j)*Y.l(j) - sum(i, (1+tVAT_xD.l(j,i))*(p.l(i)+sum(taxd,tDuty_xD.l(j,i,taxd)))*xD.l(j,i) + (1+tVAT_xF.l(j,i))*(PF.l(i)+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i))*xF.l(j,i));
BVTtot.l = sum(j,BVT.l(j)); 
Ktot.l = sum(j,KM.l(j)+KB.l(j)); 

BVTf0.l(j) = J_BVTf0.l(j) + p0.l(j)*Y.l(j) - sum(i, (1+tVAT_xD0.l(j,i))*(p0.l(i)+sum(taxd,tDuty_xD0.l(j,i,taxd)))*xD.l(j,i) 
                                                   + (1+tVAT_xF0.l(j,i))*(PF0.l(i)+sum(taxd,tDuty_xF0.l(j,i,taxd)))*(1+tCus_x0.l(j,i))*xF.l(j,i));
BVTf0tot.l = J_BVTf0tot.l + sum(j,BVTf0.l(j)); 
NVTf0.l(j) = J_NVTf0.l(j) + p0.l(j)*Y.l(j) - sum(i, (1+tVAT_xD0.l(j,i))*(p0.l(i)+sum(taxd,tDuty_xD0.l(j,i,taxd)))*xD.l(j,i)
*VÆKSTKORREKTION AF KAPITALAPPARAT 
                                                   + (1+tVAT_xF0.l(j,i))*(PF0.l(i)+sum(taxd,tDuty_xF0.l(j,i,taxd)))*(1+tCus_x0.l(j,i))*xF.l(j,i)) 
                                                   - (deltaKM.l(j)*PInvM0.l(j)*KM.l(j)+deltaKB.l(j)*PInvB0.l(j)*KB.l(j))/(1+grow.l); 
NVTf0tot.l = J_NVTf0tot.l + sum(j,NVTf0.l(j)); 

* Offentligt forbrug
share_G.l(i)   = PG.l(i)*G.l(i)/sum(j,BVT.l(j));

BoP.l = 0;

utility.l = ctot.l + sum(i, G.l(i));

* Vi laver dummy'er, som angiver, at der er leverancer
d1xm(j,dm)    = 1 $ ((xm.l(j,dm)    gt 0) OR (xm.l(j,dm)    lt 0));
d1xe(j,dme)   = 1 $ ((xe.l(j,dme)   gt 0) OR (xe.l(j,dme)   lt 0));
d1IM(j,dim)   = 1 $ ((IM.l(j,dim)   gt 0) OR (IM.l(j,dim)   lt 0));
d1IB(j,dib)   = 1 $ ((IB.l(j,dib)   gt 0) OR (IB.l(j,dib)   lt 0));
d1IMI(j,i)    = 1 $ ((IMI.l(j,i)    gt 0) OR (IMI.l(j,i)    lt 0));
d1IBI(j,i)    = 1 $ ((IBI.l(j,i)    gt 0) OR (IBI.l(j,i)    lt 0));
d1x(j,i)      = 1 $ ((x.l(j,i)      gt 0) OR (x.l(j,i)      lt 0));
d1Ex(i)       = 1 $ ((Ex.l(i)       gt 0) OR (Ex.l(i)       lt 0));
d1IL(j)       = 1 $ ((IL.l(j)       gt 0) OR (IL.l(j)       lt 0));
d1G(i)        = 1 $ ((G.l(i)        gt 0) OR (G.l(i)        lt 0));
d1CH(dc)      = 1 $ ((CH.l(dc)      gt 0) OR (CH.l(dc)      lt 0));
d1C(i)        = 1 $ ((C.l(i)        gt 0) OR (C.l(i)        lt 0));
d1KE(j)       = 1 $ ((KE.l(j)       gt 0) OR (KE.l(j)       lt 0));
d1L(j)        = 1 $ ((L.l(j)        gt 0) OR (L.l(j)       lt 0));

Parameter Profit, Skat_indkomst, Dividender;

Profit(j) = P.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l);
Skat_indkomst(j) = P.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - (deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l));
Dividender(j) = P.l(j)*Y.l(j) - PM.l(j)*M.l(j) - PE.l(j)*E.l(j) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) - Fak_rest.l(j) - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - t_cor.l(j)*skat_indkomst(j) - PInvB.l(j)*InvB.l(j) - PInvM.l(j)*InvM.l(j) - PIL.l(j)*IL.l(j) - SUBEU.l(j) + (1-1/((1+grow.l)*(1+infl.l)))*DP.l(j);

Display Profit, Skat_indkomst, Dividender;