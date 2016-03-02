data wheat;                                                                                                                           
input Variety $ Field DiseaseTrt resp;
datalines;                        

V1	1	1	42.9
V1	2	1	41.6
V1	3	1	28.9
V1	4	1	30.8
V2	1	1	53.3
V2	2	1	69.6
V2	3	1	45.4
V2	4	1	35.1
V3	1	1	62.3
V3	2	1	58.5
V3	3	1	44.6
V3	4	1	50.3
V4	1	1	75.4
V4	2	1	65.6
V4	3	1	54
V4	4	1	52.7
V1	1	2	53.8
V1	2	2	58.5
V1	3	2	43.9
V1	4	2	46.3
V2	1	2	57.6
V2	2	2	69.6
V2	3	2	42.4
V2	4	2	51.9
V3	1	2	63.4
V3	2	2	50.4
V3	3	2	45
V3	4	2	46.7
V4	1	2	70.3
V4	2	2	67.3
V4	3	2	57.6
V4	4	2	58.5
V1	1	3	49.5
V1	2	3	53.8
V1	3	3	40.7
V1	4	3	39.4
V2	1	3	59.8
V2	2	3	65.8
V2	3	3	41.4
V2	4	3	45.4
V3	1	3	64.5
V3	2	3	46.1
V3	3	3	62.6
V3	4	3	50.3
V4	1	3	68.8
V4	2	3	65.3
V4	3	3	45.6
V4	4	3	51
V1	1	4	44.4
V1	2	4	41.8
V1	3	4	28.3
V1	4	4	34.7
V2	1	4	64.1
V2	2	4	57.4
V2	3	4	44.1
V2	4	4	51.6
V3	1	4	63.6
V3	2	4	56.1
V3	3	4	52.7
V3	4	4	51.8
V4	1	4	71.6
V4	2	4	69.4
V4	3	4	56.6
V4	4	4	47.4
;

proc mixed data=wheat method=type3 plots=all; 
class Field Variety DiseaseTrt;
model resp=Variety DiseaseTrt Variety*DiseaseTrt;
random Field Field*Variety;
store wheat123; 
title 'ANOVA of wheat Data';
run;

ods html style=statistical sge=on;
proc plm restore=wheat123; 
lsmeans Variety / adjust=tukey plot=meanplot cl lines;  
lsmeans DiseaseTrt / adjust=tukey plot=meanplot cl lines;  
lsmeans Variety*DiseaseTrt / adjust=tukey plot=meanplot cl lines;  
/*
lsmeans Field / adjust=tukey plot=meanplot cl lines;  
lsmeans Field*Variety / adjust=tukey plot=meanplot cl lines;*/
/* The lsmeans statement here prints out the model fit means, performs the Tukey
      mean comparisons, and plots the data. */
ods exclude diffplot; 
run; title; run;
