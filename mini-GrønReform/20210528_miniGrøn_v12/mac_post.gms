
*KE
*Udregning af priser med uændrede inputpriser
PHT_energixCO2(j) $ d1HT_e(j) = px_energipre(j,'01000a')*H_energi.l(j)/HT_energi.l(j) 
                              + px_energipre(j,'160000')*T_energi.l(j)/HT_energi.l(j) 
                              + px_energipre(j,'020000')*B_energi.l(j)/HT_energi.l(j);

PG_energixCO2(j) $ d1G_e(j) = px_energipre(j,'350020b')*BG_energi.l(j)/G_energi.l(j)
                            + px_energipre(j,'350020a')*NG_energi.l(j)/G_energi.l(j)
                            + px_energipre(j,'190000a')*RG_energi.l(j)/G_energi.l(j)
                            + px_energipre(j,'060000b')*NoG_energi.l(j)/G_energi.l(j);

PSB_energixCO2(j) $ d1SB_e(j) = px_energipre(j,'420000')*K_energi.l(j)/SB_energi.l(j) 
                              + px_energipre(j,'industri')*A_energi.l(j)/SB_energi.l(j) 
                              + PHT_energixCO2(j)*HT_energi.l(j)/SB_energi.l(j);
                  
PISB_energixCO2(j) $ d1ISB_e(j) = PG_energixCO2(j)*G_energi.l(j)/ISB_energi.l(j) 
                                + px_energipre(j,'190000a')*O_energi.l(j)/ISB_energi.l(j);

PfossilxCO2(j) $ d1fossil(j) = PISB_energixCO2(j)*ISB_energi.l(j)/fossil.l(j) + PSB_energixCO2(j)*SB_energi.l(j)/fossil.l(j);

PKEfoxCO2(j) $ d1fossil(j) = PfossilxCO2(j)*fossil.l(j)/KEfo.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvMpre(j)*KMfo.l(j)/(1+grow.l)/KEfo.l(j);


PKE2inputpre(j) = PKEelpre(j)*KEel.l(j)/KE2.l(j) + PKEfoxCO2(j)*KEfo.l(j)/KE2.l(j); 

CO2perKE2post(j) = (CO2Energi.l(j)-CO2BogD.l(j))/KE2.l(j);

*Udregning af MAC (pris opgjort i mia. kr. og udledninger opgjort i 1.000 tons CO2 ganges med 10**6 for at få MAC i kr. per ton)
MAC_KE(j) $ (CO2Energi.l(j)-CO2BogD.l(j) gt 1) = (PKE2inputpre(j)-PKE2xCO2pre(j))/(CO2perKE2pre(j)-CO2perKE2post(j)) * 10**6;
MAC_KE(j) $ (CO2Energi.l(j)-CO2BogD.l(j) lt 1) = 1; 

CO2KE2redukAkku(j) = CO2KE2redukAkku(j) + (CO2perKE2pre(j)-CO2perKE2post(j))*KE2base(j);


*Transport
PTFXxCO2(j)  = px_energipre(j,'190000a')*TF.l(j)/TFX.l(j) + PTX2pre(j)*TX2.l(j)/TFX.l(j);
PTFXBxCO2(j) = PTFXxCO2(j)*TFX.l(j)/TFXB.l(j) + PTBpre(j)*TB.l(j)/TFXB.l(j);
PTTFxCO2(j)  = PTFXBxCO2(j)*TFXB.l(j)/TTF.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvMpre(j)*TKf.l(j)/(1+grow.l)/TTF.l(j);
PTinputpre(j) = PTTEpre(j)*TTE.l(j)/T.l(j) + PTTFxCO2(j)*TTF.l(j)/T.l(j);

CO2perTpost(j) = CO2BogD.l(j)/T.l(j);

MAC_T(j) $ CO2perTpre(j) = (PTinputpre(j)-PTxCO2pre(j))/(CO2perTpre(j)-CO2perTpost(j)) * 10**6;

* Vægtet gennemsnit for vejtransportbrancher

MAC_T_tot = SUM(j$(not ikkevejtransport(j)), MAC_T(j) * Tbase(j)) / SUM(j$(not ikkevejtransport(j)), Tbase(j));

* Reduktion i alt for vejtransportbrancher
CO2TredukAkku_tot = CO2TredukAkku_tot + SUM(j$(not ikkevejtransport(j)), (CO2perTpre(j)-CO2perTpost(j))*Tbase(j));


*Landbrug
PKBpartxCO2e(part,j) $ j_land(j) = (1+tFak_B.l(j))*ucB.l(j)*PInvBpre(j);

PKBtotxCO2e(j) $ j_land(j) = sum(part, PKBpartxCO2e(part,j)*KBpart.l(part,j))/KBtot.l(j) + sum(part, PKBpartXpre(part,j)*KBpartX.l(part,j))/KBtot.l(j);

PHxCO2e(j) $ j_land(j) = PLKEpre(j)*LKE.l(j)/H.l(j) + PKBtotxCO2e(j)*KBtot.l(j)/(1+grow.l)/H.l(j);

POxCO2epost(j) $ j_land(j) = PMpre(j)*M.l(j)/Y.l(j) + PHxCO2e(j)*H.l(j)/Y.l(j) + PTpre(j)*T.l(j)/Y.l(j);

CO2eperYpost(j) $ j_land(j) = SUM(udled_type, Ieudled.l(j,udled_type) * CO2eVaegt(udled_type) / 1000) / Y.l(j);
NperYpost(j) $ j_land(j) = Nudled.l / Y.l(j);
NH3perYpost(j) $ j_land(j) = Ieudled.l(j,'NH3') / Y.l(j);

Display POxCO2epost,CO2eperYpost;

*Udregning af MAC (pris opgjort i mia. kr. og udledninger opgjort i tons CO2 ganges med 10**6 for at få MAC i kr. per ton)
MAC_Y(j) $ (j_land(j) and (CO2eperYpre(j) ne CO2eperYpost(j))) = (POxCO2epost(j)-POxCO2epre(j))/(CO2eperYpre(j)-CO2eperYpost(j)) * 10**6;

CO2eYredukAkku(j) $ j_land(j) = CO2eYredukAkku(j) + (CO2eperYpre(j)-CO2eperYpost(j))*Ybase(j);
NredukAkku(j) $ j_land(j) = NredukAkku(j) + (NperYpre(j)-NperYpost(j))*Ybase(j);
NH3redukAkku(j) $ j_land(j) = NH3redukAkku(j) + (NH3perYpre(j)-NH3perYpost(j))*Ybase(j);