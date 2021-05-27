****************************************************************************************
***********************       Calibration to real data      ****************************
****************************************************************************************

******************* 'DATA' ****************************
Table alphas(i,g) "Alphaer"
    1     2     3     4     5     6     7     8
1   0.008 0.032 0.131 0.105 0.03  0.231 0.291 0.172   
2   0.039 0.081 0.104 0.029 0.025 0.276 0.244 0.202
3   0.034 0.067 0.122 0.122 0.025 0.244 0.169 0.217
4   0.029 0.037 0.11  0.068 0.018 0.207 0.286 0.244
5   0.028 0.036 0.072 0.112 0.03  0.241 0.293 0.188
;



Table min_cons(i,g) "b'er"
    1       2       3       4       5       6       7       8
1   10821   21847   42808   14298   2399    6665    19287   33753
2   11143   22634   53459   17990   4850    5361    34469   55109
3   13129   26875   64495   18501   6440    16588   38986   64683
4   15838   31219   76719   24004   8812    36676   51615   87761
5   14087   32069   99980   18914   8167    35575   40409   86531
;

*** må justere 1,1 og 1,2 lidt ned, da de er højere end cons
min_cons("1","1") = 10100;
min_cons('1','2') = 21500;


Table cons(i,g) "samlet forbrug"
    1       2       3       4       5       6       7       8
1   10256   21605   53703   21172   4269    19137   32006   44053
2   11974   24952   60790   22313   5245    25933   39999   60168
3   15165   31208   76997   26468   8292    37151   52196   84311
4   16065   33840   82148   26185   10166   44085   61141   92510
5   17722   37644   115872  27160   10329   62408   85645   114118
;

parameter cons_share(i) "kvintilers forbrugsandel"/
1   0.126784
2   0.154558
3   0.204001
4   0.225123
5   0.289534/
;

parameter income(i) "Kvintilers indkomst 2019"/
1   392009.15
2   612026.48
3   927983.33
4   1083464.21
5   1698144.8/
;

parameter income_share(i) "Indkomstandel 2019"/
1   0.083165059
2   0.129841915
3   0.196872417
4   0.229857812
5   0.360262798/
;

parameter Emissions(g)  "Udledninger: ton co2e"/
1	2255
2	6524
3	5493
4	10223
5	918
6	6499
7	5340
8	8041/
;


parameter CO2_koef(g) "Varegruppernes co2-andel af produktion"/
1   0.0823176
2   0.129274392
3   0.024987882
4   0.401554549
5   0.115478351
6   0.113095265
7   0.052594913
8   0.034791298/
;

parameter production(g) "Varergruppernes produktion"/
1   27391
2   50467
3   219834
4   25460
5   7949
6   57465
7   101538
8   231129/
;

parameter prod_share(g) "Varergruppers andel af produktion"/
1	0.037977464
2	0.069973028
3	0.304804092
4	0.035300281
5	0.011020854
6	0.079676811
7	0.140784025
8	0.320463445/
;

parameter prices(g) "varergruppers 2015-priser for 2019"/
1   1.04
2   1.03
3   1.06
4   0.96
5   1.05
6   1.01
7   0.95
8   1.05/
;

parameter production2019(g) "Varergruppernes produktion i 2019-priser"/
1	26338
2	48997
3	207391
4	26521
5	7570
6	56896
7	106882
8	220123/
;


