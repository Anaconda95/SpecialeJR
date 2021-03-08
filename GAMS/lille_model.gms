############# Lille model ###############


#  Vi vil gerne have en model med:
#  To husholdninger med forskellige produktiviteter
#  To virksomheder, en clean og en dirty, der bruger husholdningernes arbejdskraft som input
#  Husholdningerne køber begge varer med CES præferencer
#  En offentlig sektor, der beskatter dirty og smider provenuet ud 



# sets
set HH /"L","H"/;

set F /"D","C"/;


# Vars 
variables
L(HH,F) 
w(HH)
Y(F)
pp
p(F)
p_C
N(HH)
X(HH,F)
;

parameters
mu(HH,F)
gamma(F,HH)
E
E_x(HH)
rho(HH)  "produktivitets-parameter"
;

equations
e1
e2
e3
e4
e5
e6
e7
;


#Virksomehdernes efterspørgsel
e1(HH,F)..    L(HH,F) =e= mu(HH,F)*(w(HH)/pp)**(-E)*Y(F);

#Nukprofit for hver virksomehd

e2(F)..       sum((HH), w(HH)*L(HH,F)) =e= pp*Y(F);

#Arbejdsmarked
e3(HH)..      sum(F,L(HH,F)) =e= N(HH)*rho(HH);


# Privat efterspørgsel
e4(HH,F)..    X(HH,F) =e= gamma(F,HH)*(p(F)/p_C)**(-E_x(HH))*(w(HH)*rho(HH)*N(HH)/p_C);

# Budget restriktion
e5(HH)..      sum(F, p(F)*X(HH,F)) =e= w(HH)*rho(HH)*N(HH);

# Varermarkedsligevægt    #lidt i tvivl om hvilket prisindeks her - uden priser måske?
e6..          sum((F,HH), X(HH,F)) =e= sum(F,Y(F));

# prisen er numeraire
e7..       pp =e= 1;


Model lille_model /e1, e2, e3, e4, e5, e6, e7/;



####### Lav data ########
*--------------------------------------------*
* Nationalregnskabet til opgave 3.1
* NR = 1000
*--------------------------------------------*

parameter NR, lonsum(HH);
NR          = 1000;
lonsum('H') = 650;
lonsum('L') = 350;


*--------------------------------------------*
* Befolkning og BNP
*--------------------------------------------*

parameter
bef(HH) "arbejdsstyrke med uddannelsestype j"
;
bef('L') = 1100;
bef('H') = 1100;

E = 2;

E_x(HH) = 0.5;

rho(HH) = lonsum(HH)/bef(HH);

w.l(HH) = 1;

Y.l('D') = 400;
Y.l('C') = 600;

L.l(HH,F) = lonsum(HH)*Y.l(F)/NR;


pp.l = 1;

p_C.l = 1;

p.l(F) = 1;

N.fx(HH) = bef(HH);

X.l('L','D') = Y.l('D')*0.5;
X.l('H','D') = Y.l('D')*0.5;

X.l(HH,'C') = w.l(HH)*rho(HH)*N.l(HH)-p.l('D')*X.l(HH,'D');

# mu er ens på tværs af F ?? 
mu(HH,F) = L.l(HH,F)/Y.l(F);


# gamma er meget høj for L og lav for H
gamma(F,HH) = X.l(HH,F)/lonsum(HH);




solve lille_model using cns;


execute_unload 'Output\lille_model';

#  set objekter /Y, w1, w2, L1, L2, C, p, N1, N2, N, mu1, mu2/;

#  set eksperiment /baseline, stod1, stod2, stod3/;

#  parameter output(objekter,eksperiment);

#  Output('Y','baseline') = Y.l;
#  Output('w1', 'baseline') =w.l('L');
#  Output('w2','baseline') =w.l('H');
#  Output('L1','baseline') = L.l('L');
#  Output('L2','baseline') = L.l('H');
#  Output('C','baseline') = C.l;
#  Output('p','baseline') = p.l;
#  Output('N1','baseline') = N.l('L');
#  Output('N2','baseline') = N.l('H');
#  Output('N','baseline') = sum(j, N.l(HH));
#  Output('mu1','baseline') = mu('L');
#  Output('mu2','baseline') = mu('HH');


