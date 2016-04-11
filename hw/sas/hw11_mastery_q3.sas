data quant_factor;                                                     
input Method $ hours mastery;                                                                                                           
datalines;                                                                                                                              
A	1	8
A	1	7
A	1	8
A	3	22
A	3	24
A	3	21
A	5	49
A	5	51
A	5	49
A	7	87
A	7	87
A	7	86
A	9	139
A	9	138
A	9	138
B	1	8
B	1	10
B	1	9
B	3	41
B	3	42
B	3	43
B	5	99
B	5	100
B	5	98
B	7	186
B	7	185
B	7	182
B	9	300
B	9	299
B	9	300
;                                                              
run;                                                                                                 
/* centering the covariate */  /* creating the quadratic */                                                       
                                                                                                                                        
data quant_factor; set quant_factor;
x = hours-5;
x2 = x**2;                                                         
run;                                                                                                                                     
proc mixed data=quant_factor;                                                            
class Method;                                                    
model mastery=Method x x2                                                
        Method*x Method*x2;
run;