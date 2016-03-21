data hw4_1;                                                                                                                   
		input A	$ B $ resp;                                                                                                          
datalines;  	
  1    1    12.9
  1    1    11.3
  1    1    11.7
  1    1    12.1
  1    1    12.3
  1    2    13.7
  1    2    12.8
  1    2    13.6
  1    2    13.1
  1    2    13.5
  2    1    14.2
  2    1    14.5
  2    1    13.9
  2    1    13.6
  2    1    14.4
  2    2    13.5
  2    2    13.1
  2    2    13.3
  2    2    13.1
  2    2    13.4
;

run;                                                                                                                                    
                                                                                                                                        
proc mixed data=hw4_1 method=type3;                                                                                           
class A B;                                                                                                                     
model resp = A B A*B;                                                                                               
store out2way;                                                                                                                          
run;                                                                                                                                    
                                                                                                                                        
ods graphics on;                                                                                                                        
ods html style=statistical sge=on;                                                                                                      
proc plm restore=out2way;                                                                                                               
lsmeans A*B / adjust=tukey plot=meanplot cl lines;                                                                             
/* Because the 2-factor interaction is significant, we need to work with                                                                
the treatment combination means */                                                                                                      
ods exclude diffs diffplot;                                                                                                             
run; title; run;
