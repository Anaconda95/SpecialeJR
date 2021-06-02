

TB.fx(j) $ (d1TB(j) eq 0)   = 0;
energiGJ.fx(j,'Bioolie')  $ (d1TB(j) eq 0) = 0;
PTB.fx(j) $ (d1TB(j) eq 0)  = 1;



fossil.fx(j)  $ (d1fossil(j) eq 0) = 0;
KEfo.fx(j)  $ (d1KE(j) eq 0) = 0;
KMfo.fx(j)  $ (d1fossil(j) eq 0) = 0;


Pfossil.fx(j) $ (d1fossil(j) eq 0) = 1;
PKEfo.fx(j) $ (d1fossil(j) eq 0) = 1;

TF.fx(j) $ (d1TX2(j) eq 1)    = 0;
TX2.fx(j) $ (d1TX2(j) eq 0)   = 0;

*x_energi.lo(j,'190000a') = -inf;
*x_energi.up(j,'190000a') =  inf;
*x_energi.lo(j,'190000b') $ d1TB(j) = -inf;
*x_energi.up(j,'190000b') $ d1TB(j) =  inf;

*x_energi.lo(j,'industri') = -inf;
*x_energi.up(j,'industri') =  inf;