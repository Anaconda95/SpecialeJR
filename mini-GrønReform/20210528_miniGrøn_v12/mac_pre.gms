* * * inputpriser
*KE2
px_energipre(j,i) = px_energi.l(j,i);
PInvMpre(j) = PInvM.l(j);
PKEelpre(j) = PKEel.l(j);
*T
PTTEpre(j) = PTTE.l(j);
PTBpre(j) = PTB.l(j);
PTX2pre(j) = PTX2.l(j);
*Landbrug
PInvBpre(j) = PInvB.l(j);
PKBpartpre(part,j)$ j_land(j) = PKBpart.l(part,j);
PKBpartXpre(part,j)$ j_land(j) = PKBpartX.l(part,j);
PLKEpre(j) = pLKE.l(j);
PMpre(j) = PM.l(j);
PTpre(j) = PT.l(j);

* * * Pre priser
*KE2
PHT_energixCO2(j) $ d1HT_e(j) = px_energi.l(j,'01000a')*H_energi.l(j)/HT_energi.l(j) 
                              + px_energi.l(j,'160000')*T_energi.l(j)/HT_energi.l(j) 
                              + px_energi.l(j,'020000')*B_energi.l(j)/HT_energi.l(j);

PG_energixCO2(j) $ d1G_e(j) = px_energi.l(j,'350020b')*BG_energi.l(j)/G_energi.l(j)
                            + px_energi.l(j,'350020a')*NG_energi.l(j)/G_energi.l(j)
                            + px_energi.l(j,'190000a')*RG_energi.l(j)/G_energi.l(j)
                            + px_energi.l(j,'060000b')*NoG_energi.l(j)/G_energi.l(j);

PSB_energixCO2(j) $ d1SB_e(j) = px_energi.l(j,'420000')*K_energi.l(j)/SB_energi.l(j) 
                              + px_energi.l(j,'industri')*A_energi.l(j)/SB_energi.l(j) 
                              + PHT_energixCO2(j)*HT_energi.l(j)/SB_energi.l(j);
                  
PISB_energixCO2(j) $ d1ISB_e(j) = PG_energixCO2(j)*G_energi.l(j)/ISB_energi.l(j) 
                                + px_energi.l(j,'190000a')*O_energi.l(j)/ISB_energi.l(j);

PfossilxCO2(j) $ d1fossil(j) = PISB_energixCO2(j)*ISB_energi.l(j)/fossil.l(j) + PSB_energixCO2(j)*SB_energi.l(j)/fossil.l(j);

PKEfoxCO2(j) $ d1fossil(j) = PfossilxCO2(j)*fossil.l(j)/KEfo.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KMfo.l(j)/(1+grow.l)/KEfo.l(j);


PKE2xCO2pre(j) = PKEel.l(j)*KEel.l(j)/KE2.l(j) + PKEfoxCO2(j)*KEfo.l(j)/KE2.l(j); 

CO2perKE2pre(j) = (CO2Energi.l(j)-CO2BogD.l(j))/KE2.l(j);

*T
PTFXxCO2(j)  = px_energi.l(j,'190000a')*TF.l(j)/TFX.l(j) + PTX2.l(j)*TX2.l(j)/TFX.l(j);
PTFXBxCO2(j) = PTFXxCO2(j)*TFX.l(j)/TFXB.l(j) + PTB.l(j)*TB.l(j)/TFXB.l(j);
PTTFxCO2(j)  = PTFXBxCO2(j)*TFXB.l(j)/TTF.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*TKf.l(j)/(1+grow.l)/TTF.l(j);
PTxCO2pre(j) = PTTE.l(j)*TTE.l(j)/T.l(j) + PTTFxCO2(j)*TTF.l(j)/T.l(j);

CO2perTpre(j) = CO2BogD.l(j)/T.l(j);

*Landbrug
PKBpartxCO2e(part,j) $ j_land(j) = (1+tFak_B.l(j))*ucB.l(j)*PInvBpre(j);

PKBtotxCO2e(j) $ j_land(j) = sum(part, PKBpartxCO2e(part,j)*KBpart.l(part,j))/KBtot.l(j) + sum(part, PKBpartXpre(part,j)*KBpartX.l(part,j))/KBtot.l(j);

PHxCO2e(j) $ j_land(j) = PLKEpre(j)*LKE.l(j)/H.l(j) + PKBtotxCO2e(j)*KBtot.l(j)/(1+grow.l)/H.l(j);

POxCO2epre(j) $ j_land(j) = PMpre(j)*M.l(j)/Y.l(j) + PHxCO2e(j)*H.l(j)/Y.l(j) + PTpre(j)*T.l(j)/Y.l(j);

CO2eperYpre(j) $ j_land(j) = SUM(udled_type, Ieudled.l(j,udled_type) * CO2eVaegt(udled_type) / 1000) / Y.l(j);
NperYpre(j) $ j_land(j) = Nudled.l / Y.l(j);
NH3perYpre(j) $ j_land(j) = Ieudled.l(j,'NH3') / Y.l(j);

Display POxCO2epre,CO2eperYpre;