display scalar_PKBx;
parameter justeringP(j);
justeringP('230020')  = -0.4;
justeringP('383900')  = -0.3;
justeringP('350010a') = -0.4;

scalar_PKBx(part,j)  $ (d1KBpartX(part,j) EQ 0) = 1 + (scalar_PKBx(part,j)-1)*(1+justeringP(j));
