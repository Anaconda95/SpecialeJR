
parameter Afgifter_provenu;
*sets tax_klima(tax) "Klimarelaterede afgifter" / 
*tax1        "Benzinafgift"
*        "Registreringsafgift"
*tax8        "El-afgift"
*tax9        "Visse olieprodukter (diesel)"
*tax10       "Sten og brunkul mv." 
*       "Råstofafgift"
*tax15       "Naturgas afgift"
*/;


Afgifter_provenu('V',taxd) =
                          + sum(j, sum(i, tDuty_xD.l(j,i,taxd)*xD.l(j,i) + tDuty_xF.l(j,i,taxd)*xF.l(j,i)))
*                          + sum(i, tDuty_CD.l(i,taxd)*cD.l(i) + tDuty_CF.l(i,taxd)*cF.l(i))
                          + sum(i, tDuty_GD.l(i,taxd)*gD.l(i) + tDuty_GF.l(i,taxd)*gF.l(i))
                          + sum(i, tDuty_ILD.l(i,taxd)*ILD.l(i) + tDuty_ILF.l(i,taxd)*ILF.l(i))
                          + sum(i, tDuty_ExD.l(i,taxd)*ExD.l(i) + tDuty_ExF.l(i,taxd)*ExF.l(i))   
                          + sum(j, sum(i, tDuty_IMD.l(j,i,taxd)*IMID.l(j,i) + tDuty_IMF.l(j,i,taxd)*IMIF.l(j,i)))
                          + sum(j, sum(i, tDuty_IBD.l(j,i,taxd)*IBID.l(j,i) + tDuty_IBF.l(j,i,taxd)*IBIF.l(j,i)))
                         ; 
Afgifter_provenu('HH',taxd) =                 
                          + sum(i, tDuty_CD.l(i,taxd)*cD.l(i) + tDuty_CF.l(i,taxd)*cF.l(i))
                         ;
                         
                         
display Afgifter_provenu;                 