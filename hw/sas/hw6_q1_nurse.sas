data fullnest;
input patient	nurse	rating;
datalines;
1	1	9
1	2	2
1	3	5
1	4	8
2	1	6
2	2	1
2	3	3
2	4	2
3	1	8
3	2	4
3	3	6
3	4	8
4	1	7
4	2	1
4	3	2
4	4	6
5	1	10
5	2	5
5	3	6
5	4	9
6	1	6
6	2	2
6	3	4
6	4	7
;
proc mixed data=fullnest covtest method=type3;
class nurse;
model rating=;
random nurse;
run;

proc varcomp data=fullnest;
class nurse;
model rating= nurse;
run;
