

* * * * * * Stepvis fremskrivning af arbejdskraftsproduktivitet, udenlandsk efterspørgsel, TFP, markup og lagerinvesteringer  * * * * *



*Fra DREAM:
*E19                            2030    2050
*GDPf0                          2610    3700
*E20                            2030    2050
*GDPf0                          2480    3509

parameters sigteGDP;
sigteGDP = 2480;

parameter
sigteDiv(j) /
01000a    0.140 ,
01000b    0.080 ,
01000c    0.054 ,
01000d    0.145 ,
020000    -0.178,
030000    0.093 ,
060000a   0.395 ,
060000b   0.395 ,
080090    0.399 ,
100010a   0.007 ,
100010b   0.007 ,
100010c   0.007 ,
100020    0.005 ,
100030    0.007 ,
100040    0.007 ,
100050    0.007 ,
11200     0.007 ,
Industri  0.038 ,
160000    0.021 ,
190000a   -0.136,
190000b   -0.136,
200010    0.049 ,
200020    0.049 ,
210000    0.063 ,
220000    0.035 ,
230010    0.035 ,
230020    0.037 ,
240000    -0.001,
250000    0.013 ,
280010    0.013 ,
280020    0.013 ,
350010a   0.080 ,
350010b   0.080 ,
350020a   0.082 ,
350020b   0.082 ,
350030a   0.073 ,
350030b   0.073 ,
36700     -0.065,
383900    -0.061,
410009    0.055 ,
420000    0.055 ,
43000     0.055 ,
45000     0.035 ,
460000    0.116 ,
470000    0.036 ,
490012    0.002 ,
490030a   -0.045,
490030b   -0.045,
50000a    -0.006,
50000b    -0.006,
51000a    -0.130,
51000b    -0.130,
52000     -0.010,
53000     0.013 ,
550000    0.053 ,
560000    0.058 ,
Tjenester 0.066 ,
Boliger   -0.056,
Offentlig -0.012,
79000  0.017
/;

sigteDiv(j) $ (sigteDiv(j) LT 0.001) = 0.001;

parameter
pejleTFPg(j) 'aarlig TFP-vaekstrate' /
01000a  0.0099,
01000b  0.0099,
01000c  0.0099,
01000d  0.0099,
020000  0.0045,
030000  0.0197,
060000a -0.0583,
060000b -0.0583,
080090  -0.0583,
100010a 0.0000,
100010b 0.0000,
100010c 0.0000,
100020  0.0000,
100030  0.0000,
100040  0.0000,
100050  0.0000,
11200   0.0000,
Industri  0.0070,
160000  0.0033,
190000a 0,
190000b 0,
200010  0.0149,
200020  0.0149,
210000  0.0094,
220000  0.0028,
230010  0.0028,
230020  0.0029,
240000  0.0029,
250000  -0.0002,
280010  0.0026,
280020  0.0026,
350010a -0.0011,
350010b -0.0011,
350020a -0.0011,
350020b -0.0011,
350030a -0.0011,
350030b -0.0011,
36700   -0.0100,
383900  -0.0099,
410009  0.0037,
420000  0.0037,
43000  0.0037,
45000  0.0065,
460000  0.0074,
470000  0.0141,
490012  -0.0095,
490030a -0.0095,
490030b -0.0095,
50000a  0.0075,
50000b  0.0075,
51000a  0.0275,
51000b  0.0275,
52000  -0.0092,
53000  -0.0205,
550000  -0.0066,
560000  -0.0066,
Tjenester 0.0024,
Boliger  0.0010,
Offentlig 0.0002,
79000  -0.0043
/;

parameter pejleTFP(j) 'Pejlemaerke for TFP-niveau i 2030';
pejleTFP(j) = (1+pejleTFPg(j))**14;
pejleTFP('060000a') = 1;
pejleTFP('060000b') = 1;

parameter pejleMarkup(j) /
01000a    -0.033,
01000b    0.026 ,
01000c    0.053 ,
01000d    -0.042,
020000    0.034 ,
030000    0.123 ,
060000a   1.316 ,
060000b   1.316 ,
080090    1.312 ,
100010a   0.012 ,
100010b   0.012 ,
100010c   0.012 ,
100020    0.015 ,
100030    0.012 ,
100040    0.012 ,
100050    0.012 ,
11200     0.012 ,
Industri  0.069 ,
160000    0.038 ,
190000a   0.025 ,
190000b   0.025 ,
200010    0.060 ,
200020    0.060 ,
210000    0.093 ,
220000    0.043 ,
230010    0.043 ,
230020    0.055 ,
240000    0.019 ,
250000    0.022 ,
280010    0.013 ,
280020    0.013 ,
350010a   0.095 ,
350010b   0.095 ,
350020a   0.091 ,
350020b   0.091 ,
350030a   0.106 ,
350030b   0.106 ,
36700     -0.101,
383900    -0.089,
410009    0.073 ,
420000    0.072 ,
43000     0.073 ,
45000     0.046 ,
460000    0.172 ,
470000    0.049 ,
490012    -0.098,
490030a   -0.033,
490030b   -0.033,
50000a    -0.013,
50000b    -0.013,
51000a    -0.135,
51000b    -0.135,
52000     -0.030,
53000     0.021 ,
550000    0.071 ,
560000    0.064 ,
Tjenester 0.080 ,
Boliger   -0.138,
Offentlig -0.027,
79000 0.012
/;

pejleMarkup('Offentlig') = 0;
pejleMarkup('060000a') = Markup.l('060000a');
pejleMarkup('060000b') = Markup.l('060000b');

parameter pejleBeskDiff(j) 'ændring i sektorens andel af den samlede beskæftigelse' /
01000a    -0.0004,
01000b    -0.0002,
01000c    -0.0003,
01000d    -0.0001,
020000    -0.0001,
030000    -0.0002,
060000a   0.0000 ,
060000b   0.0000 ,
080090    0.0000 ,
100010a   -0.0001,
100010b   -0.0006,
100010c   -0.0001,
100020    -0.0003,
100030    -0.0008,
100040    -0.0003,
100050    -0.0008,
11200     -0.0002,
Industri  -0.0053,
160000    -0.0005,
190000a   -0.0001,
190000b   -0.0000,
200010    -0.0002,
200020    -0.0003,
210000    0.0017 ,
220000    -0.0009,
230010    -0.0001,
230020    -0.0001,
240000    0.0001 ,
250000    -0.0015,
280010    -0.0007,
280020    -0.0003,
350010a   -0.0001,
350010b   -0.0000,
350020a   -0.0000,
350020b   -0.0000,
350030a   -0.0000,
350030b   -0.0000,
36700     -0.0003,
383900    -0.0004,
410009    0.0006 ,
420000    0.0007 ,
43000     0.0010 ,
45000     0.0004 ,
460000    -0.0007,
470000    -0.0014,
490012    -0.0009,
490030a   -0.0007,
490030b   -0.0006,
50000a    -0.0000,
50000b    -0.0004,
51000a    -0.0001,
51000b    -0.0003,
52000     0.0017 ,
53000     -0.0016,
550000    0.0039 ,
560000    0.0114 ,
Tjenester 0.0146 ,
Boliger   -0.0003,
Offentlig -0.0136,
79000  -0.0000
/;

parameter pejleBesk(j) 'Pejlemaerke for andelen af den samlede beskæftigelse';
pejleBesk(j) = Lpre(j)/sum(jj,Lpre(jj)) + pejleBeskDiff(j);


parameter pejleYDiff(j) 'ændring i sektorens andel af den samlede produktionsværdi' /
01000a    -0.0004,
01000b    -0.0002,
01000c    -0.0003,
01000d    -0.0001,
020000    -0.0001,
030000    -0.0002,
060000a   -0.0002,
060000b   -0.0001,
080090    -0.0001,
100010a   -0.0004,
100010b   -0.0019,
100010c   -0.0003,
100020    -0.0009,
100030    -0.0023,
100040    -0.0009,
100050    -0.0023,
11200     -0.0006,
Industri  -0.0044,
160000    -0.0009,
190000a   0.0011 ,
190000b   0.0000 ,
200010    0.0002 ,
200020    0.0003 ,
210000    0.0081 ,
220000    -0.0013,
230010    -0.0001,
230020    -0.0005,
240000    0.0001 ,
250000    -0.0032,
280010    -0.0010,
280020    -0.0005,
350010a   -0.0006,
350010b   -0.0006,
350020a   -0.0004,
350020b   -0.0000,
350030a   -0.0004,
350030b   -0.0001,
36700     0.0002 ,
383900    0.0006 ,
410009    0.0036 ,
420000    0.0043 ,
43000     0.0056 ,
45000     -0.0005,
460000    0.0038 ,
470000    -0.0029,
490012    -0.0008,
490030a   -0.0006,
490030b   -0.0005,
50000a    0.0000 ,
50000b    0.0058 ,
51000a    -0.0002,
51000b    -0.0005,
52000     0.0010 ,
53000     -0.0012,
550000    0.0001 ,
560000    0.0004 ,
Tjenester 0.0138 ,
Boliger   -0.0020,
Offentlig -0.0147,
79000  0.0000 
/;

Y.lo('060000a') = -inf;
Y.up('060000a') =  inf;
Y.lo('060000b') = -inf;
Y.up('060000b') =  inf;
markup.fx('060000a') = markup.l('060000a');
markup.fx('060000b') = markup.l('060000b');


parameter pejleY(j) 'Pejlemaerke for andelen af den samlede produktionsværdi';
pejleY(j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj)) + pejleBeskDiff(j);

parameter vis_afvigelser, d1afvig, d1lager, d1markup;
parameter luk_andel, pejleMarkup_korr, pejleTFP_korr, diffYpejle, diffBeskpejle, vis_diffYpejle, vis_diffBeskpejle, c_lagerPre;
parameter vis_fremstruk, vis_div, vis_markup, vis_TFP, vis_besk, vis_lager, vis_prod, vis_P, vis_TFP_korr;


diffYpejle(j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj))/pejleY(j) - 1;
diffBeskpejle(j) = L.l(j)/Ltot.l/pejleBesk(j) - 1;


d1lager(j) $ (c_lager.l(j)*c_lager.l(j) gt 0.001*0.001) = 1;
d1lager('offentlig') = 0;
d1lager('060000a') = 0;
d1lager('060000b') = 0;

d1markup(j) $ (d1lager(j) eq 0) = 1;
d1markup('offentlig') = 0;
d1markup('060000a') = 0;
d1markup('060000b') = 0;


set loopstepfrem /1*50/;
set loopstepfrem1(loopstepfrem)  /1*20/;
set loopstepfrem2(loopstepfrem) /21*40/;
set loopstepfrem3(loopstepfrem) /41*50/;


loop(loopstepfrem1,

* - - Makro BNP og priser rammes
adjThetaL.fx $ (GDPf0.l LT sigteGDP*0.995) =  0.005 + adjThetaL.l;
adjThetaL.fx $ (GDPf0.l GT sigteGDP*1.005) = -0.005 + adjThetaL.l;

*Hvis den aggregerede pris er under 0.99 stiger efterspørgsel
adjX0.fx $ (GDP.l LT GDPf0.l*0.99) = 0.02 + adjX0.l;
*Hvis den aggregerede pris er over 1.01 falder efterspørgsel
adjX0.fx $ (GDP.l GT GDPf0.l*1.01) = -0.02 + adjX0.l;


* Udregning af difference til pejlemærker for beskæftigelse og produktionsværdi
diffYpejle(j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj))/pejleY(j) - 1;
diffBeskpejle(j) = L.l(j)/Ltot.l/pejleBesk(j) - 1;
diffYpejle('060000a') = 0;
diffYpejle('060000b') = 0;
diffBeskpejle('060000a') = 0;
diffBeskpejle('060000b') = 0;

luk_andel = 0.1;

* - - Det vigtigste - dividenderne rammes

c_lager.fx(j) $ d1lager(j) = c_lager.l(j) -  luk_andel * (sigteDiv(j) - DivY.l(j));
markup.fx(j) $ d1markup(j) = markup.l(j) + luk_andel * (sigteDiv(j) - DivY.l(j));


* - - Det næstvigtigste - holde produktionsværdi og beskæftigelse tæt på pejlemærkerne

* Den udenlandske efterspørgsel sættes ned (op), hvis både beskæftigelsen og produktionsværdien er mere end 5 pct. over (under) deres pejlemærker
X0pre.fx(j) $ (diffBeskpejle(j) gt  0.05 and diffYpejle(j) gt  0.05) = X0pre.l(j)*(1-luk_andel*0.05);
X0pre.fx(j) $ (diffBeskpejle(j) lt -0.05 and diffYpejle(j) lt -0.05) = X0pre.l(j)*(1+luk_andel*0.05);

* Markup'en sættes op (ned), hvis beskæftigelsen er mere end 5 pct. over (under) sit pejlemærke
markup.fx(j) $ (diffBeskpejle(j) gt  0.05)  = markup.l(j) + 0.001;
markup.fx(j) $ (diffBeskpejle(j) lt -0.05)  = markup.l(j) - 0.001;

* TFP-niveauet sættes op (ned), hvis produktionsværdien er mere end 5 pct. under (over) sit pejlemærke
TFP.fx(j) $ (diffYpejle(j) lt -0.05) = TFP.l(j) + luk_andel * 0.05;
TFP.fx(j) $ (diffYpejle(j) gt  0.05) = TFP.l(j) - luk_andel * 0.05;


* - - Det tredje vigtigste - holde markup og TFP tæt på pejlemærkerne

* Markup'en sættes op (ned), hvis markup'en er mere end (luk_andel * 0.01/4) under (over) sit pejlemærke
markup.fx(j) $ (markup.l(j) lt pejleMarkup(j)-luk_andel*0.01/4)  = markup.l(j) + 0.001/4;
markup.fx(j) $ (markup.l(j) gt pejleMarkup(j)+luk_andel*0.01/4)  = markup.l(j) - 0.001/4;

* TFP-niveauet sættes op (ned), hvis TFP-niveauet er mere end (luk_andel * 0.05/2) under (over) sit pejlemærke
TFP.fx(j) $ (TFP.l(j) lt pejleTFP(j)-luk_andel*0.05/2) = TFP.l(j) + luk_andel * 0.05/2;
TFP.fx(j) $ (TFP.l(j) gt pejleTFP(j)+luk_andel*0.05/2) = TFP.l(j) - luk_andel * 0.05/2;

solve static_fremskriv using cns;


vis_fremstruk(loopstepfrem1,'GDPf0') = GDPf0.l;
vis_fremstruk(loopstepfrem1,'pGDP') = GDP.l/GDPf0.l;

vis_div(loopstepfrem1,j) = DivY.l(j);
vis_markup(loopstepfrem1,j) = markup.l(j);
vis_TFP(loopstepfrem1,j) = TFP.l(j);
vis_besk(loopstepfrem1,j) = L.l(j)/Ltot.l;
vis_lager(loopstepfrem1,j) = c_lager.l(j);
vis_prod(loopstepfrem1,j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj));
vis_p(loopstepfrem1,j) = P.l(j);
vis_diffYpejle(loopstepfrem1,j) = diffYpejle(j);
vis_diffBeskpejle(loopstepfrem1,j) = diffBeskpejle(j);

);


loop(loopstepfrem2,

* - - Makro BNP og priser rammes
adjThetaL.fx $ (GDPf0.l LT sigteGDP*0.999) =  0.0005 + adjThetaL.l;
adjThetaL.fx $ (GDPf0.l GT sigteGDP*1.001) = -0.0005 + adjThetaL.l;

*Hvis den aggregerede pris er under 0.998 stiger efterspørgsel
adjX0.fx $ (GDP.l LT GDPf0.l*0.998) = 0.002 + adjX0.l;
*Hvis den aggregerede pris er over 1.002 falder efterspørgsel
adjX0.fx $ (GDP.l GT GDPf0.l*1.002) = -0.002 + adjX0.l;


* Udregning af difference til pejlemærker for beskæftigelse og produktionsværdi
diffYpejle(j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj))/pejleY(j) - 1;
diffBeskpejle(j) = L.l(j)/Ltot.l/pejleBesk(j) - 1;


luk_andel = 0.03;

* - - Det vigtigste - dividenderne rammes

c_lager.fx(j) $ d1lager(j) = c_lager.l(j) -  luk_andel * 3 * (sigteDiv(j) - DivY.l(j));
markup.fx(j) $ d1markup(j) = markup.l(j) + luk_andel * 3 * (sigteDiv(j) - DivY.l(j));


* - - Det næstvigtigste - holde produktionsværdi og beskæftigelse tæt på pejlemærkerne

* Den udenlandske efterspørgsel sættes ned (op), hvis både beskæftigelsen og produktionsværdien er mere end 5 pct. over (under) deres pejlemærker
X0pre.fx(j) $ (diffBeskpejle(j) gt  0.05 and diffYpejle(j) gt  0.05) = X0pre.l(j)*(1-luk_andel*0.05);
X0pre.fx(j) $ (diffBeskpejle(j) lt -0.05 and diffYpejle(j) lt -0.05) = X0pre.l(j)*(1+luk_andel*0.05);

* Markup'en sættes op (ned), hvis beskæftigelsen er mere end 5 pct. over (under) sit pejlemærke
markup.fx(j) $ (diffBeskpejle(j) gt  0.05)  = markup.l(j) + 0.0005;
markup.fx(j) $ (diffBeskpejle(j) lt -0.05)  = markup.l(j) - 0.0005;

* TFP-niveauet sættes op (ned), hvis produktionsværdien er mere end 5 pct. under (over) sit pejlemærke
TFP.fx(j) $ (diffYpejle(j) lt -0.05) = TFP.l(j) + luk_andel * 0.05;
TFP.fx(j) $ (diffYpejle(j) gt  0.05) = TFP.l(j) - luk_andel * 0.05;


* - - Det tredje vigtigste - holde markup og TFP tæt på pejlemærkerne

* Markup'en sættes op (ned), hvis markup'en er mere end (luk_andel * 0.01/4) under (over) sit pejlemærke
markup.fx(j) $ (markup.l(j) lt pejleMarkup(j)-luk_andel*0.01/4)  = markup.l(j) + 0.0005/4;
markup.fx(j) $ (markup.l(j) gt pejleMarkup(j)+luk_andel*0.01/4)  = markup.l(j) - 0.0005/4;

* TFP-niveauet sættes op (ned), hvis TFP-niveauet er mere end (luk_andel * 0.05/2) under (over) sit pejlemærke
TFP.fx(j) $ (TFP.l(j) lt pejleTFP(j)-luk_andel*0.05/2) = TFP.l(j) + luk_andel * 0.05/2;
TFP.fx(j) $ (TFP.l(j) gt pejleTFP(j)+luk_andel*0.05/2) = TFP.l(j) - luk_andel * 0.05/2;

solve static_fremskriv using cns;


vis_fremstruk(loopstepfrem2,'GDPf0') = GDPf0.l;
vis_fremstruk(loopstepfrem2,'pGDP') = GDP.l/GDPf0.l;

vis_div(loopstepfrem2,j) = DivY.l(j);
vis_markup(loopstepfrem2,j) = markup.l(j);
vis_TFP(loopstepfrem2,j) = TFP.l(j);
vis_besk(loopstepfrem2,j) = L.l(j)/Ltot.l;
vis_lager(loopstepfrem2,j) = c_lager.l(j);
vis_prod(loopstepfrem2,j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj));
vis_p(loopstepfrem2,j) = P.l(j);
vis_diffYpejle(loopstepfrem2,j) = diffYpejle(j);
vis_diffBeskpejle(loopstepfrem2,j) = diffBeskpejle(j);

);


loop(loopstepfrem3,

* - - Makro BNP og priser rammes
adjThetaL.fx $ (GDPf0.l LT sigteGDP*0.999) =  0.0005 + adjThetaL.l;
adjThetaL.fx $ (GDPf0.l GT sigteGDP*1.001) = -0.0005 + adjThetaL.l;

*Hvis den aggregerede pris er under 0.998 stiger efterspørgsel
adjX0.fx $ (GDP.l LT GDPf0.l*0.998) = 0.002 + adjX0.l;
*Hvis den aggregerede pris er over 1.002 falder efterspørgsel
adjX0.fx $ (GDP.l GT GDPf0.l*1.002) = -0.002 + adjX0.l;


* Udregning af difference til pejlemærker for beskæftigelse og produktionsværdi
diffYpejle(j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj))/pejleY(j) - 1;
diffBeskpejle(j) = L.l(j)/Ltot.l/pejleBesk(j) - 1;


luk_andel = 0.01;

* - - Det vigtigste - dividenderne rammes

c_lager.fx(j) $ d1lager(j) = c_lager.l(j) -  luk_andel * 3 * (sigteDiv(j) - DivY.l(j));
markup.fx(j) $ d1markup(j) = markup.l(j) + luk_andel * 3 * (sigteDiv(j) - DivY.l(j));


* - - Det næstvigtigste - holde produktionsværdi og beskæftigelse tæt på pejlemærkerne

* Den udenlandske efterspørgsel sættes ned (op), hvis både beskæftigelsen og produktionsværdien er mere end 2 pct. over (under) deres pejlemærker
X0pre.fx(j) $ (diffBeskpejle(j) gt  0.02 and diffYpejle(j) gt  0.02) = X0pre.l(j)*(1-luk_andel*0.02);
X0pre.fx(j) $ (diffBeskpejle(j) lt -0.02 and diffYpejle(j) lt -0.02) = X0pre.l(j)*(1+luk_andel*0.02);

* Markup'en sættes op (ned), hvis beskæftigelsen er mere end 2 pct. over (under) sit pejlemærke
markup.fx(j) $ (diffBeskpejle(j) gt  0.02)  = markup.l(j) + 0.00025;
markup.fx(j) $ (diffBeskpejle(j) lt -0.02)  = markup.l(j) - 0.00025;

* TFP-niveauet sættes op (ned), hvis produktionsværdien er mere end 2 pct. under (over) sit pejlemærke
TFP.fx(j) $ (diffYpejle(j) lt -0.02) = TFP.l(j) + luk_andel * 0.02;
TFP.fx(j) $ (diffYpejle(j) gt  0.02) = TFP.l(j) - luk_andel * 0.02;


* - - Det tredje vigtigste - holde markup og TFP tæt på pejlemærkerne - tages ud i sidste omgang

solve static_fremskriv using cns;


vis_fremstruk(loopstepfrem3,'GDPf0') = GDPf0.l;
vis_fremstruk(loopstepfrem3,'pGDP') = GDP.l/GDPf0.l;

vis_div(loopstepfrem3,j) = DivY.l(j);
vis_markup(loopstepfrem3,j) = markup.l(j);
vis_TFP(loopstepfrem3,j) = TFP.l(j);
vis_besk(loopstepfrem3,j) = L.l(j)/Ltot.l;
vis_lager(loopstepfrem3,j) = c_lager.l(j);
vis_prod(loopstepfrem3,j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj));
vis_p(loopstepfrem3,j) = P.l(j);
vis_diffYpejle(loopstepfrem3,j) = diffYpejle(j);
vis_diffBeskpejle(loopstepfrem3,j) = diffBeskpejle(j);

);

* En sidste korrektion ift dividenderne uden efterfølgende korrektioner
c_lager.fx(j) $ d1lager(j) = c_lager.l(j) -  0.5 * (sigteDiv(j) - DivY.l(j));
markup.fx(j) $ d1markup(j) = markup.l(j) + 0.5 * (sigteDiv(j) - DivY.l(j));


GDPf0.fx = sigteGDP;
adjThetaL.lo =  -inf;
adjThetaL.up =   inf;

GDP.fx = sigteGDP;
adjX0.lo =  -inf;
adjX0.up =   inf;

solve static_fremskriv using cns;


vis_fremstruk('99','GDPf0') = GDPf0.l;
vis_fremstruk('99','pGDP') = GDP.l/GDPf0.l;

vis_div('99',j) = DivY.l(j);
vis_markup('99',j) = markup.l(j);
vis_TFP('99',j) = TFP.l(j);
vis_besk('99',j) = L.l(j)/Ltot.l;
vis_lager('99',j) = c_lager.l(j);
vis_prod('99',j) = P.l(j)*Y.l(j)/sum(jj,P.l(jj)*Y.l(jj));
vis_p('99',j) = P.l(j);
vis_diffYpejle('99',j) = diffYpejle(j);
vis_diffBeskpejle('99',j) = diffBeskpejle(j);


$include vis_andele.gms

*vis_markup('999',j) = pejlemarkup_korr(j);
*vis_TFP('999',j) = pejleTFP_korr(j);
vis_fremstruk('1000','GDPf0') = SigteGDP;
vis_fremstruk('1000','pGDP') = 1;
vis_div('1000',j) = sigteDiv(j);
vis_markup('1000',j) = pejlemarkup(j);
vis_TFP('1000',j) = pejleTFP(j);
vis_besk('1000',j) = pejlebesk(j);
vis_prod('1000',j) = pejleY(j);

execute_unload "fremstruk.gdx"
vis_fremstruk
vis_markup
vis_div
vis_TFP
vis_besk
vis_lager
vis_prod
vis_p
vis_diffYpejle
vis_diffBeskpejle
BoP.l
;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
 
  
  
  
 
  
  
  
  
  
  
  
  
  
 
 
 
 
 
  
 
  
  
  
  
 
 
  
  
 
  
 
 
 
  
  
 
