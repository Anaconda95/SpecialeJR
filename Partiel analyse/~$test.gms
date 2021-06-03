* sets
* Husholdninger 
set i /1*5/;

* Firmaer
set g /1*8/;


variables
X(i,g)
p(g)
mu(i)
;

parameters
alpha(i,g)
b(i,g)
;

Equations
E_demand(i,g)
E_budget(i)
;

*Virksomehdernes efterspørgsel
E_demand(i,g)..       p(i)*x(i,g) =e= p(i)*b(i,g) + alpha(i,g)*(mu(i)-sum()

E_budget(i)..         L_G =e= Y_G;