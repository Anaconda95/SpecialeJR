clc;
clear all;
close all;
cd '/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /OLS Rasmus';

%indlæser data
load pmatlab.mat;
load qmatlab.mat;

%% lav til arrays
plevel=table2array(pmatlab(:,2:end));
qlevel=table2array(qmatlab(:,2:end));

%% logs
qlevel=max(qlevel,0);
q=reallog(1+qlevel);
p=reallog(plevel);
qlag=lagmatrix(q,1);


%% okay, OLS-tid i et loop LETS GO

tab=[]
for i = 2:45;
    y=q(:,i);
    X=[q(:,1) , p(:,i), qlag(:,i)];
    mdl=fitlm(X,y,'VarNames',{'Income','Price','Qlag','Quantity'});
    inci=table2array(mdl.Coefficients(2,1));
    t_inci=table2array(mdl.Coefficients(2,3));
    pricei=table2array(mdl.Coefficients(3,1));
    t_pricei=table2array(mdl.Coefficients(3,3));
    tab=[tab [inci;t_inci;pricei;t_pricei]];
end
clear pricei inci t_inci t_pricei X y;

tab=[tab; qlevel(26,2:45); plevel(26,2:45)];
R=qlevel(26,1)*1.51056976344575; %super lazy solution, pasted prices of consumption in 2019.

tab=[tab; tab(1,:).*tab(6,:).*tab(5,:)./R];
tab=[tab; (1+tab(3,:)).*tab(5,:)./(1-tab(7,:))];
tab_gns=tab; %saving

%% make a nice table
varnames = pmatlab.Properties.VariableNames;
varnames = varnames(:,3:end);
rownames = {'Income','t-value inc','Price','t-value price','Quantity (2019)','Price (2019)',...
            'alpha', 'Minimum Quantity'};
table_gns=array2table(tab_gns,'VariableNames',varnames,'Rownames',rownames);

%check sum of alphas
alphas=tab(7,:)
%apparently you cannot sum negative elements???
sum(abs(alphas));

%% okay
% 5 households
tab=[];

for hh=1,;
q_j=hh   
for i = 2:45;
    y=q_j(:,i);
    X=[q_j(:,1) , p(:,i), q_jlag(:,i)];
    mdl=fitlm(X,y,'VarNames',{'Income','Price','Qlag','Quantity'});
    inci=table2array(mdl.Coefficients(2,1));
    t_inci=table2array(mdl.Coefficients(2,3));
    pricei=table2array(mdl.Coefficients(3,1));
    t_pricei=table2array(mdl.Coefficients(3,3));
    tab=[tab [inci;t_inci;pricei;t_pricei]];
end
clear pricei inci t_inci t_pricei X y;
end

%%
tab=[tab; qlevel(26,47:90); plevel(26,2:45)];
R=qlevel(26,46)*1.51056976344575; %super lazy solution, pasted prices of consumption in 2019.

tab=[tab; tab(1,:).*tab(6,:).*tab(5,:)./R];
tab=[tab; (1+tab(3,:)).*tab(5,:)./(1-tab(7,:))];
tab_u250=tab; %saving



%% less than 250k
tab=[];
q_j=q(:,46:90);
q_jlag=qlag(:,46:90);

for i = 2:45;
    y=q_j(:,i);
    X=[q_j(:,1) , p(:,i), q_jlag(:,i)];
    mdl=fitlm(X,y,'VarNames',{'Income','Price','Qlag','Quantity'});
    inci=table2array(mdl.Coefficients(2,1));
    t_inci=table2array(mdl.Coefficients(2,3));
    pricei=table2array(mdl.Coefficients(3,1));
    t_pricei=table2array(mdl.Coefficients(3,3));
    tab=[tab [inci;t_inci;pricei;t_pricei]];
end
clear pricei inci t_inci t_pricei X y;

tab=[tab; qlevel(26,47:90); plevel(26,2:45)];
R=qlevel(26,46)*1.51056976344575; %super lazy solution, pasted prices of consumption in 2019.

tab=[tab; tab(1,:).*tab(6,:).*tab(5,:)./R];
tab=[tab; (1+tab(3,:)).*tab(5,:)./(1-tab(7,:))];
tab_u250=tab; %saving

%% Make loop

for hh=1:5;

if hh==1;
    q_j=q(:,46:90);
elseif hh==2
    q_j=q(:,91:135);
elseif hh==3
    q_j=q(:,136:180);
elseif hh==4
    q_j=q(:,181:225);
elseif hh==5
    q_j=q(:,226:270);
end

q_jlag=lagmatrix(q_j,1);
tr = [1:26]';

tab=[];
    for i = 2:45;
        y=q_j(:,i);
        X=[q_j(:,1) , p(:,i), q_jlag(:,i), tr];
        mdl=fitlm(X,y,'VarNames',{'Income','Price','Qlag','trend','Quantity'});
        inci=table2array(mdl.Coefficients(2,1));
        t_inci=table2array(mdl.Coefficients(2,3));
        pricei=table2array(mdl.Coefficients(3,1));
        t_pricei=table2array(mdl.Coefficients(3,3));
        tab=[tab [inci;t_inci;pricei;t_pricei]];
    end
clear pricei inci t_inci t_pricei X y;

tab=[tab; exp(q_j(26,2:45)); plevel(26,2:45)];
R=exp(q_j(26,1))*1.51056976344575; %super lazy solution, pasted prices of consumption in 2019.

tab=[tab; tab(1,:).*tab(6,:).*tab(5,:)./R];
tab=[tab; (1+tab(3,:)).*tab(5,:)./(1-tab(7,:))];

if hh==1;
    tab_u250=tab;
elseif hh==2
    tab_250_450=tab;
elseif hh==3
    tab_450_700=tab;
elseif hh==4
    tab_700_1m=tab;
elseif hh==5
    tab_1mioplus=tab;
end

end

%% LAV EN KÆMPE TABEL
bigtab=[tab_gns; tab_u250; tab_250_450 ; tab_450_700; tab_700_1m; tab_1mioplus];
varnames = pmatlab.Properties.VariableNames;
varnames = varnames(:,3:end);
rownames = {'Income gns','t-value inc gns','Price gns','t-value price gns',...
            'Quantity (2019) gns','Price (2019) gns','alpha gns', 'Minimum Quantity gns',...
            'Income u250','t-value inc u250','Price u250','t-value price u250',...
            'Quantity u250 (2019)','Price u250 (2019)','alpha u250', 'Minimum Quantity u250',...
            'Income u450','t-value inc u450','Price u450','t-value price u450',...
            'Quantity (2019) u450','Price (2019) u450','alpha u450', 'Minimum Quantity u450',...
            'Income u700','t-value inc u700','Price u700','t-value price u700',...
            'Quantity (2019) u700','Price (2019) u700','alpha u700', 'Minimum Quantity u700',...
            'Income u1mio','t-value inc u1mio','Price u1mio','t-value price u1mio',...
            'Quantity (2019) u1mio','Price (2019 u1mio)','alpha u1mio', 'Minimum Quantity u1mio',...
            'Income o1mio','t-value inc o1mio','Price o1mio','t-value price o1mio',...
            'Quantity (2019) o1mio','Price (2019) o1mio','alpha o1mio', 'Minimum Quantity o1mio'
            };
table_big=array2table(bigtab,'VariableNames',varnames,'Rownames',rownames);

%very big table
table2latex(table_big,'OLS 44 goods');






