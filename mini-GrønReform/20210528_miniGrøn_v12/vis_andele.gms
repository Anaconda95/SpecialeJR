nega_andel('el_kraft',j)   = 0;
nega_andel('el_reno',j)    = 0;
nega_andel('el_vind',j)    = 0;
nega_andel('FV_kraft',j)   = 0;
nega_andel('FV_fjern',j)   = 0;
nega_andel('FV_FjernVE',j) = 0;
nega_andel('FV_reno',j)    = 0;


nega_andel('el_kraft',j) $ (el_kraftandel.l(j) LE 0) = el_kraftandel.l(j);
nega_andel('el_reno',j) $ (el_renoandel.l(j) LE 0) = el_renoandel.l(j);
nega_andel('el_vind',j) $ (el_vindandel.l(j) LE 0) = el_vindandel.l(j);
nega_andel('FV_kraft',j)   $ (FV_kraftandel.l(j) LE 0) = FV_kraftandel.l(j);
nega_andel('FV_fjern',j)   $ (FV_fjernandel.l(j) LE 0) = FV_fjernandel.l(j);
nega_andel('FV_FjernVE',j) $ (FV_fjernVEandel.l(j) LE 0) = FV_fjernVEandel.l(j);
nega_andel('FV_reno',j)    $ (FV_renoandel.l(j) LE 0) = FV_renoandel.l(j);

$ontext
nega_andel('el_kraft',j) $ (el_kraftandel.l(j) LE 0.05) = el_kraftandel.l(j);
nega_andel('el_reno',j) $ (el_renoandel.l(j) LE 0.0) = el_renoandel.l(j);
nega_andel('el_vind',j) $ (el_vindandel.l(j) LE 0.01) = el_vindandel.l(j);
nega_andel('FV_kraft',j)   $ (FV_kraftandel.l(j) LE 0.01) = FV_kraftandel.l(j);
nega_andel('FV_fjern',j)   $ (FV_fjernandel.l(j) LE 0.01) = FV_fjernandel.l(j);
nega_andel('FV_FjernVE',j) $ (FV_fjernVEandel.l(j) LE 0) = FV_fjernVEandel.l(j);
nega_andel('FV_reno',j)    $ (FV_renoandel.l(j) LE 0) = FV_renoandel.l(j);
$ontext
$offtext

display nega_andel;