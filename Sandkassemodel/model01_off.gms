*Verdens simpleste CGE-model
set hh /L,H/
    f  /c,d/;

Variables
   Y(f) 'output'
   L(f) 'arbejdskraft'
   w 'løn'
   C(hh,f) 'vareforbrug'
   p(f) 'pris'
   A 'Teknologi'
   N 'Befolkning'
   Lump 'provenu, fordeles lump sum'
   L_g;
   
Parameters
phi(hh) 'Indkomstandele'
gamma(hh,f) 'Forbrugsandele'
tau(f)  'Skat';


phi('L')=0.3;
phi('H')=0.7;

gamma('L','c')=0.5;
gamma('L','d')=0.5;
gamma('H','c')=0.6;
gamma('H','d')=0.4;

tau(f)=0;

Y.l('c')=400;
Y.l('d')=600;
L.l('c')=400;
L.l('d')=600;
w.l=1;
p.l(f)=1;

A.fx=1;
N.fx=1000;


C.l(hh,f)=gamma(hh,f)*phi(hh)*N.l;

Lump.l=0;

Equation
e1 'efterspørgsel efter arbejdskraft'
e2 'nul profit betingelse'
e3 'ligevægt på arbejdsmarkedet'
e4 'privat forbrug'
e5 'pris er numeraire'
e6 'goodeq for det ene marked'
e7 'off sektor';

e1(f)..             L(f) =e= 1/A*Y(f);

e2(f)..             (1-tau(f))*p(f)*Y(f) =e= w*L(f);       

e3..                sum(f,L(f)) + L_g =e= N;

e4(hh,f)..          C(hh,f) =e= gamma(hh,f)*[ phi(hh)*N*w]/[p(f)];

e5..                w =e= 1;

e6..                sum(hh,C(hh,'C') )=e= Y('C');

e7..                w*L_g =e= sum(f,tau(f)*p(f)*Y(f));

Model simpelcge / all /;

Solve simpelcge using CNS;

tau('D')=0.1;

solve simpelcge using CNS;
