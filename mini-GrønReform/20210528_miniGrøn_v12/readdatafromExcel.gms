$CALL GDXXRW.EXE test.xlsx par=YC73V rng=YC73V!A4:B74 rdim=1 cdim=0 par=YF73V rng=YF73V!A4:C4807 rdim=2 cdim=0
*$CALL GDXXRW.EXE test.xlsx par=YF73V rng=YF73V!A4:C4807 rdim=2 cdim=0


$ontext
$GDXIN test.gdx
$LOAD YF73V
$GDXIN



$CALL GDXXRW.EXE test.xlsx par=YC73V rng=YC73V!A4:B74   rdim=1 cdim=0
$GDXIN test.gdx
$LOAD YF73V
$LOAD YC73V
$GDXIN



$LOAD YG73V


$LOAD YIM73V
$LOAD YIB73V
$LOAD YX73V
$LOAD YZ73V
$LOAD MF73V
$LOAD MC73V
$LOAD MG73V
$LOAD MIM73V
$LOAD MIB73V
$LOAD MX73V
$LOAD MZ73V
$LOAD PF73V
$LOAD PF73EUV
$LOAD PC73V
$LOAD PG73V
$LOAD PIM73V
$LOAD PIB73V
$LOAD PX73V
$LOAD PZ73V
$LOAD CF73V
$LOAD CC73V
$LOAD CG73V
$LOAD CIM73V
$LOAD CIB73V
$LOAD CX73V
$LOAD CZ73V
$LOAD Kmu73V
$LOAD Kbu73V
$LOAD DKm73V
$LOAD DKb73V
*$LOAD dKMavg
*$LOAD dKBavg
$LOAD DutyYFVx
$LOAD DutyMFVx
$LOAD DutyYCVx
$LOAD DutyMCVx
$LOAD DutyYGVx
$LOAD DutyMGVx
$LOAD DutyYXVx
$LOAD DutyMXVx
$LOAD DutyYZVx
$LOAD DutyMZVx
$LOAD DutyYIMVx
$LOAD DutyMIMVx
$LOAD DutyYIBVx
$LOAD DutyMIBVx
$LOAD FakDuty_B73V
$LOAD FakDuty_L73V
$LOAD FakDuty_ekso73V
$LOAD FKMU73V
$LOAD FKBU73V
$GDXIN

$offtext