data grain;                                                     
input density	yield;
datalines;                                                                                                                              
10      12.2	
10      11.4	
10      12.4	
20      16	
20      15.5	
20      16.5	
30      18.6	
30      20.2	
30      18.2	
40      17.6	
40      19.3	
40      17.1	
50      18	
50      16.4	
50      16.6	
;                                                              
run;                                                                                                 
/* generate ortho polynomials */
proc iml;
x={10 20 30 40 50};
xpoly=orpol(x,4);
density=x`; new=density || xpoly;
create out1 from new[colname={"density" "xp0" "xp1" "xp2" "xp3" "xp4"}];
append from new; close out1;
quit;
proc print data=out1; run;

/* sort data and merge with original */
proc sort data=grain; by density; run;
data ortho_poly; merge out1 grain; by density; run;
proc print data=ortho_poly; run;

/**/
proc mixed data=ortho_poly method=type3;
class;
model yield=xp1 xp2 xp3 xp4;
title 'Using Orthog polynomials from IML';
run;
