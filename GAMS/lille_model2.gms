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
L(F) 
w
Y(F)
p(F)
p_C
N
X(HH,F)
G  "Offentlig produktions"
;

parameters
mu(HH,F)
gamma(F,HH)
E
E_x(HH)
rho(HH)  "produktivitets-parameter"
tau(f) 
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
e1(F)..       L(F) =e= Y(F);


#Nukprofit for hver virksomhed
e2(F)..       w*L(F) =e= p(F)*Y(F);

#Arbejdsmarked
e3..          sum(F,L(F)) =e= sum(HH,N*rho(HH));


# Privat efterspørgsel
e4(HH,F)..    X(HH,F) =e= gamma(F,HH)*((1+tau(f))*p(F)/p_C)**(-E_x(HH))*(w*rho(HH)*N/p_C);

# Budget restriktion
e5..      sum((HH,f), (1+tau(F))*p(F)*X(HH,F)) =e= sum(HH,w*rho(HH)*N);

# Varermarkedsligevægt
e6(F)..       sum((HH), X(HH,F)) =e= Y(F);

# prisen er numeraire
e7..          w =e= 1;


Model lille_model2 /e1,e2, e6, e4, e5, e7/;



####### Kalibrering ########

E_x(HH) = 0.5;

rho('L') = 0.3;
rho('H') = 0.7;

w.l = 1;

Y.l('D') = 400;
Y.l('C') = 600;

L.l(F) = Y.l(F);


p_C.l = 1;

p.l(F) = 1;

N.fx = 1000;

X.l('L','D') = Y.l('D')*0.5;
X.l('H','D') = Y.l('D')*0.5;

X.l(HH,'C') = w.l*rho(HH)*N.l-X.l(HH,'D');

gamma(F,HH) = X.l(HH,F)/(rho(HH)*N.l);

tau('D')=0;
tau('C')=0;


solve lille_model2 using cns;


execute_unload 'Output\lille_model2_basis';

tau('D')=0.1;
tau('C')=0;

solve lille_model2 using cns;

execute_unload 'Output\lille_model2_tau01';


 # Evt kør dette efter modellen er løst for at være sikker på at få de nyeste tal med 
$call GDXmerge o=Output\lille_model2_stod.gdx i=Output\lille_model2_basis.gdx Output\lille_model2_tau01.gdx id=X,p,p_C,Y,tau,L,w,E_x
#$call gdx2xls Output\lille_model_stod.gdx
