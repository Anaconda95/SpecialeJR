function Pos(x) = ((%x)*(%x))**0.5;

* Dummy sektor
parameter m0(j,i), v0(j);
* Definition af gamX-funktioner
function splitMatrix(x) =
m0(j,i) = %x(j,i)|
%x('qzi_d',i) = dummyShare.l * m0('qzi_r',i)|
%x(j,'qzi_d') = dummyShare.l * m0(j,'qzi_r')|
%x('qzi_r',i) = (1-dummyShare.l) * m0('qzi_r',i)|
%x(j,'qzi_r') = (1-dummyShare.l) * m0(j,'qzi_r')|

%x('qzi_d','qzi_d') = dummyShare.l * m0('qzi_r','qzi_r')|
%x('qzi_r','qzi_r') = (1-dummyShare.l) * m0('qzi_r','qzi_r')|
%x('qzi_d','qzi_r') = 0|
%x('qzi_r','qzi_d') = 0|
;

function splitVector(x) =
v0(j) = %x(j)|
%x('qzi_d') = dummyShare.l * v0('qzi_r')|
%x('qzi_r') = (1-dummyShare.l) * v0('qzi_r')|
;

function setTaxMatrix(x) =
%x('qzi_d',i) = %x('qzi_r',i)|
%x(j,'qzi_d') = %x(j,'qzi_r')|
;