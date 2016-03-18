data lesson3;                                                                                                                           
input method $ em;                                                                                                                    
datalines;                                                                                                                              

m1	5.95
m1	4.78
m1	4.28
m1	5.04
m1	4.56
m2	10.61
m2	13.13
m2	10.51
m2	9.26
m2	11.04
m3	17
m3	20.88
m3	20.06
m3	15.25
m3	23.74
m4	7.51
m4	6.82
m4	6.23
m4	6.49
m4	5.91
;

/* */
proc print data= lesson3;                                                                                                                
title 'Raw Data for Lesson 3'; run;                                                                                                     
                                                                                                                                        
proc summary data=lesson3;                                                                                                              
class method;                                                                                                                             
var em;                                                                                                                             
output out=output1 mean=mean stderr=se;                                                                                                 
run;    
                                                                                                                                
proc print data=output1;                                                                                                                
title 'Summary Output for Lesson 3';                                                                                                    
run;                                                                                                                                    


/* Check Settings: From Main toolbar, choose
Tools > Options > Preferences > Results
make sure HTML box is checked and listing box is not checked */

/* I want to enable the Output Delivery System Graphics package
because I will want to produce some diagnostic plots */

ods graphics on;

/* ANOVA: We will be using Proc Mixed for most of our ANOVA work. The mixed 
procedure has several options for how the solutions
for ANOVA are reached.  I am specifying the 'Method=type3'
to use ordinary least squares rather than a maximum likelihood method
for this example. This will produce the conventional (ANOVA table) output. */

proc mixed data=lesson3 method=type3 plots=all;
class method;
model em=method;
store abc123; /*Stores results for the next procedure (abc123 is name I give)*/
title 'ANOVA of tablet compaction Data';
run;

ods html style=statistical sge=on;
proc plm restore=abc123; 
lsmeans method / adjust=tukey plot=meanplot cl lines; 
/* The lsmeans statement here prints out the model fit means, performs the Tukey
      mean comparisons, and plots the data. */
ods exclude diffplot; 
run; title; run;

