
  FV_FjernVEandel.fx('50000a') = FV_FjernVEandel.l('50000a');
J_FV_FjernVEandel.lo('50000a') = -inf;
J_FV_FjernVEandel.up('50000a') =  inf;
  FV_kraftandel.fx('50000a') = FV_kraftandel.l('50000a');
J_FV_kraftandel.lo('50000a') = -inf;
J_FV_kraftandel.up('50000a') =  inf;
  FV_Renoandel.fx('50000a') = FV_Renoandel.l('50000a');
J_FV_Renoandel.lo('50000a') = -inf;
J_FV_Renoandel.up('50000a') =  inf;
  FV_Fjernandel.fx('50000a') = FV_Fjernandel.l('50000a');
J_FV_Fjernandel.lo('50000a') = -inf;
J_FV_Fjernandel.up('50000a') =  inf;

  FV_FjernVEandel.fx('50000b') = FV_FjernVEandel.l('50000b');
J_FV_FjernVEandel.lo('50000b') = -inf;
J_FV_FjernVEandel.up('50000b') =  inf;
  FV_kraftandel.fx('50000b') = FV_kraftandel.l('50000b');
J_FV_kraftandel.lo('50000b') = -inf;
J_FV_kraftandel.up('50000b') =  inf;
  FV_Renoandel.fx('50000b') = FV_Renoandel.l('50000b');
J_FV_Renoandel.lo('50000b') = -inf;
J_FV_Renoandel.up('50000b') =  inf;
  FV_Fjernandel.fx('50000b') = FV_Fjernandel.l('50000b');
J_FV_Fjernandel.lo('50000b') = -inf;
J_FV_Fjernandel.up('50000b') =  inf;

solve static_fremskriv using cns;