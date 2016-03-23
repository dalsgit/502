data fert;
input plant	trt	$ yield	ht;
datalines;
1.0	c	12.2	45
2.0	c	12.4	52
3.0	c	11.9	42
4.0	c	11.3	35
5.0	c	11.8	40
6.0	c	12.1	48
7.0	c	13.1	60
8.0	c	12.7	61
9.0	c	12.4	50
10.0	c	11.4	33
11.0	s	16.6	63
12.0	s	15.8	50
13.0	s	16.5	63
14.0	s	15.0	33
15.0	s	15.4	38
16.0	s	15.6	45
17.0	s	15.8	50
18.0	s	15.8	48
19.0	s	16.0	50
20.0	s	15.8	49
21.0	f	9.5	52
22.0	f	9.5	54
23.0	f	9.6	58
24.0	f	8.8	45
25.0	f	9.5	57
26.0	f	9.8	62
27.0	f	9.1	52
28.0	f	10.3	67
29.0	f	9.5	55
30.0	f	8.5	40
;
proc reg data=fert;
where trt='c';
model yield=ht;
title 'Fert = c';
run;

proc reg data=fert;
where trt='s';
model yield=ht;
title 'Fert = s';
run;

proc reg data=fert;
where trt='f';
model yield=ht;
title 'Fert = f';
run;

proc mixed data=fert;
class trt;
model yield=ht trt ht*trt;
title 'Covariance test for equal slopes';
run;

proc mixed data=fert;
class trt;
model yield=ht trt / noint solution;
lsmeans trt / pdiff adjust=tukey;
title 'Equal slopes model';
run;

title;
