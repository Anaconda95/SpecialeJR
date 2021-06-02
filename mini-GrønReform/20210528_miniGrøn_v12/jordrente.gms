*Vegetabilsk landbrug holdes fast via åben markup
Y.fx('01000a')      $ (%LAND% EQ 1) = Y.l('01000a'); 
markup.lo('01000a') $ (%LAND% EQ 1) = -inf;
markup.up('01000a') $ (%LAND% EQ 1) =  inf;

*Fiskeri holdes fast via åben markup
Y.fx('030000')      $ (%FISK% EQ 1) = Y.l('030000'); 
markup.lo('030000') $ (%FISK% EQ 1) = -inf;
markup.up('030000') $ (%FISK% EQ 1) =  inf;


solve static_fremskriv using cns;