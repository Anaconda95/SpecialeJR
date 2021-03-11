$call GDXmerge o=Output\lille_model2_off_stod.gdx i=Output\lille_model_off_basis.gdx Output\lille_model2_off_tau01.gdx id=X,p,p_C,Y,tau,L,w,E_x,X_total,G,lumpsum,EV_I,EV_p,EV,ev_pct,ev_p_pct,Y_G,L_G


#$call GDXmerge o=Output\lille_model2_stod.gdx i=Output\lille_model2_basis.gdx Output\lille_model2_tau01.gdx id=X,p,p_C,Y,tau,L,w,E_x,X_total,G,lumpsum,EV_I,EV_p,EV,ev_pct,ev_p_pct
#$call gdx2xls Output\lille_model_stod.gdx



 # Evt kør dette efter modellen er løst for at være sikker på at få de nyeste tal med 
#$call GDXmerge o=Output\lille_model2_homotest.gdx i=Output\lille_model2_basis.gdx Output\lille_model2_homo.gdx id=X,p,p_C,Y,tau,L,w,E_x,X_total
#$call gdx2xls Output\lille_model_stod.gdx
