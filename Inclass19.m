%In class 19
clear all
% Problem 1. Imagine a clincal trial for two drugs that are intended to lower
% cholesterol. Assume 30 subjects are randomly divided into 3 groups that
% either receive a placebo or one of the two treatments. The mean initials
% levels of total cholesterol in each group are the same. The final
% measurements look like

placebo = [   194   183   199   189   189   214   212   186   191   190];
treatment1 = [    138   217   188   126   249   217   255   196   279   123];
treatment2 =[   152   152   151   143   161   142   142   141   161   135];

%A. Make a bar plot of the means of each group with errorbars (Hint, use
%bar and then use 'hold on' and then errorbar).
placebo_avg = mean(placebo);
placebo_std = std(placebo);
treatment1_avg = mean(treatment1);
treatment1_std = std(treatment1);
treatment2_avg = mean(treatment2);
treatment2_std = std(treatment2);

bar_data = [placebo_avg,treatment1_avg,treatment2_avg];
bar_stats = [placebo_std,treatment1_std,treatment2_std]
figure(1);bar(bar_data);hold on;
errorbar(bar_data,bar_stats,'o','MarkerSize',1);
hold off;

%B. Run a one way ANOVA analysis to see whether any of the treatment groups showed
%a statistically signficant difference. 
all_data = [placebo',treatment1',treatment2'];
data_labels = {'placebo','treatment1','treatment2'};

[p, table, stats] = anova1(all_data,data_labels);

%the pvalue was was 0.0029, which shows that there is atleast one group
%that is significantly different from the others.

%C. use the multcompare function to look at all pairs of samples and
%indicate which are significantly different. 
multcompare(stats)

%Adam Howard: Treatment 2 shows significant difference from both the placebo and
%treatment 1. There is no significant difference between Placebo and
%treatment 2. 

%%
%Problem 2. In this directory, you will find a .mat file with three
%variables, xdat, ydat, and ydat2. For each pair (xdat, ydat) and (xdat,
%ydat2), fit the data to a first, second and third order polynomial. Which
%one is the best fit in each case? In at least one of the cases, do the
%problem with both the polyfit/polyval functions and with the 'fit' function.


%Adam Howard: Using the code below, for the comparison between xdat and
%ydat, a first order polynomial (or a linear fit) works best to describe
%the pattern of the data. In the xdat vs ydat2, the 3rd order polynomial
%fits the data best. 
[data_mat] = load('data.mat');
xdat = [data_mat.xdat];
ydat = [data_mat.ydat];
ydat2 = [data_mat.ydat2];

figure(3);
plot(xdat,ydat,'r.'); hold on;
lncolor = 'k-';

for ii = 1:3
[coeff, s] = polyfit(xdat,ydat,ii)
plot(xdat,polyval(coeff,xdat),lncolor,'LineWidth',3);
hold on;

switch ii
    case 1
        lncolor = 'b-';
        clear coeff;
        clear s;
    case 2 
        lncolor = 'g-';
        clear coeff;
        clear s;
    case 3
        break;
end

end
hold off;

figure(4);
plot(xdat,ydat2,'r.'); hold on;

for ii = 1:3
switch ii
    case 1
        fitshape = 'poly1';
    case 2
        fitshape = 'poly2';
    case 3
        fitshape = 'poly3';
end
figure(4);
fit_out = fit(xdat',ydat2',fitshape);
plot(fit_out); set(gca,'Fontsize',8); hold on;
end


