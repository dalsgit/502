data nested1;                                                                                                                           
input state	city household index;
datalines;                        
1	1	1	42
1	1	2	56
1	1	3	35
1	1	4	40
1	1	5	28
1	2	1	26
1	2	2	38
1	2	3	42
1	2	4	35
1	2	5	53
1	3	1	39
1	3	2	56
1	3	3	65
1	3	4	34
1	3	5	49
2	1	1	47
2	1	2	58
2	1	3	39
2	1	4	62
2	1	5	65
2	2	1	56
2	2	2	43
2	2	3	65
2	2	4	70
2	2	5	59
2	3	1	73
2	3	2	56
2	3	3	54
2	3	4	76
2	3	5	62
3	1	1	19
3	1	2	36
3	1	3	24
3	1	4	12
3	1	5	33
3	2	1	18
3	2	2	40
3	2	3	27
3	2	4	31
3	2	5	23
3	3	1	21
3	3	2	33
3	3	3	50
3	3	4	35
3	3	5	26
;

/* MODEL 1 - ALL FIXED */
proc mixed data=nested1 method=type3;                                                                                                   
class state	city household;                                                                                                                
model index = state city(state);                                                                                             
store nested1;
run; 

ods graphics on;                                                                                                                        
ods html style=statistical sge=on;                                                                                                     

/* MODEL 2 - ALL RANDOM */
proc mixed data=nested1 covtest method=type3;
class state	city household;                                                                                                                
model index=;
random state city(state);
run;

proc varcomp data=nested1;
class state	city household;                                                                                                                
model index= state city(state);
run;

proc nested data=nested1;
class state	city;                                                                                                                
var index;
run;

/* MODEL 3 - STATE ONLY FIXED */
proc mixed data=nested1 covtest method=type3;
class state	city household;                                                                                                                
model index=state;
random city(state);
run;
