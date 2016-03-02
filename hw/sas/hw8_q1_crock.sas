data crock;                                                                                                                           
input crock	soaktime $ recipe rating;
datalines;                        

1	long	1	45
1	long	2	50
1	long	3	44
2	short	1	33
2	short	2	40
2	short	3	40
3	long	1	46
3	long	2	49
3	long	3	45
4	short	1	32
4	short	2	41
4	short	3	41
;

proc mixed data=crock method=type3 plots=all; 
class crock	soaktime recipe  rating;
model rating=soaktime recipe soaktime*recipe;
random crock(soaktime);
store abc123; /*Stores results for the next procedure (abc123 is name I give)*/
title 'ANOVA of crock Data';
run;

ods html style=statistical sge=on;
proc plm restore=abc123; 
lsmeans soaktime / adjust=tukey plot=meanplot cl lines;  
lsmeans recipe / adjust=tukey plot=meanplot cl lines;  
lsmeans soaktime*recipe / adjust=tukey plot=meanplot cl lines;  
/* The lsmeans statement here prints out the model fit means, performs the Tukey
      mean comparisons, and plots the data. */
ods exclude diffplot; 
run; title; run;

