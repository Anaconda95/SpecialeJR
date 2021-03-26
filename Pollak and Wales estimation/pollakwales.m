clc;
clear all;
close all;
cd '/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /Pollak and Wales estimation';

%load data
load simpeldata1.mat;
data=table2array(simpeldata1(:,2:end));

%% make total expenditure and shares
mu=sum(data(:,1:3),2);
w=data(:,1:3)./mu;

%% Lets try to estimate just a's
 

