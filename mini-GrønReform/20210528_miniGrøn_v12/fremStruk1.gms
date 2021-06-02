*$include slaa_elFVandele_fra.gms
*solve static_fremskriv using cns;

*$ontext
parameter Lpre(j);
Lpre(j) = L.l(j);


* * * * * * Fremskrivning af befolkning, arbejdsstyrke - arbejdskraftsproduktivitet og udenlandsk efterspørgsel følger med * * * * * 

* Beskæftigelse og arbejdsstyrke gemmes (til brug for 2050-fremskrivning)
Parameter L0, N_LabForce0, N_pop0;
L0(j) = L.l(j);
N_LabForce0 = N_LabForce.l;
N_pop0 = N_pop.l;

*Fra DREAM:
*E19		2030	2050   (relativt til 2016)
*Befolkning 	1.062	1.109
*Arbejdsstyrke	1.085	1.147

*Fra DREAM:
*E20		2030	2050   (relativt til 2016)
*Befolkning 	1.057	1.100
*Arbejdsstyrke	1.084	1.142


set loopstepLabF /1*5/;

loop(loopstepLabF, 
N_Pop.fx = N_Pop.l * 1.012;
N_LabForce.fx = N_LabForce.l * 1.016;
adjThetaL.fx = 0.01 + adjThetaL.l;
adjX0.fx = 0.01 + adjX0.l;

solve static_fremskriv using cns;

);


N_Pop.fx = N_Pop0 * 1.057;
N_LabForce.fx = N_LabForce0 * 1.084;

solve static_fremskriv using cns;

display GDP.l, GDPf0.l;

*$offtext


* Eksogen nedjustering af fjernvarmeandelen fra kraftværker og affaldsforbrænding (for at undgå negative andele af fjervarme fra fjernvarmeværker)
konstantKraft(j) = konstantKraft(j)*0.75;
konstantReno(j)  = konstantReno(j)*0.75;

konstantKraft('490030a') = konstantKraft('490030a')*0.2;
konstantReno('490030a')  = konstantReno('490030a')*0.2;
konstantKraft('490030b') = konstantKraft('490030b')*0.2;
konstantReno('490030b')  = konstantReno('490030b')*0.2;
konstantKraft('50000a') = konstantKraft('50000a')*0.2;
konstantReno('50000a')  = konstantReno('50000a')*0.2;
konstantKraft('50000b') = konstantKraft('50000b')*0.2;
konstantReno('50000b')  = konstantReno('50000b')*0.2;
konstantKraft('53000') = konstantKraft('53000')*0.6;
konstantReno('53000')  = konstantReno('53000')*0.6;

konstantKraft('220000') = konstantKraft('220000')*0.4;
konstantReno('220000')  = konstantReno('220000')*0.4;
konstantKraft('250000') = konstantKraft('250000')*0.6;
konstantReno('250000')  = konstantReno('250000')*0.6;
konstantKraft('383900') = konstantKraft('383900')*0.6;
konstantReno('383900')  = konstantReno('383900')*0.6;

konstantKraft('350010b') = konstantKraft('350010b')*0;
konstantReno('350010b')  = konstantReno('350010b')*0;

solve static_fremskriv using cns;

$include vis_andele.gms


*Vi sætter el-kraft andelen til nul for brancher, hvor el-kraft andelen ellers bliver negativ
d1kraftandel0('250000') = 1;
d1kraftandel0('383900') = 1;
d1kraftandel0('50000a') = 1;
d1kraftandel0('50000b') = 1;
d1kraftandel0('220000') = 1;
d1kraftandel0('53000') = 1;
*d1kraftandel0('350010b') = 1;

el_kraftandel.fx(j) $ (d1kraftandel0(j) EQ 1) = 0;

solve static_fremskriv using cns;
$include vis_andele.gms

display el_kraftandel.l, el_renoandel.l;