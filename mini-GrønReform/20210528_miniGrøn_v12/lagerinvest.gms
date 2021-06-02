* * * * Korrektion af lagerinvesteringer * * * *

* Lagerinvesteringer sættes ens som andel af output på tværs af brancher

Display c_lager.l;

c_lager.fx(j)$Y.l(j)  = SUM(i, IL.l(i)) / SUM(i, Y.l(i));

solve static_tilskud using cns;

Display c_lager.l

display BoP.l;
execute_unload "gekko\gdx_work\base_l.gdx";