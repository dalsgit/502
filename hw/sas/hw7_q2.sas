data RCBD_oneway;
input block Fert $ Species $ Height;
datalines;
1	control	SppA	19.5
2	control	SppA	20.5
3	control	SppA	21
4	control	SppA	21
5	control	SppA	21.5
6	control	SppA	22.5
1	control	SppB	22.8
2	control	SppB	23.7
3	control	SppB	23.7
4	control	SppB	23.8
5	control	SppB	23.8
6	control	SppB	24.4
1	f1	SppA	25
2	f1	SppA	27.5
3	f1	SppA	28
4	f1	SppA	28.6
5	f1	SppA	30.5
6	f1	SppA	32
1	f1	SppB	28.9
2	f1	SppB	30.1
3	f1	SppB	30.9
4	f1	SppB	32.7
5	f1	SppB	32.7
6	f1	SppB	34.4
1	f2	SppA	22.5
2	f2	SppA	25.2
3	f2	SppA	26
4	f2	SppA	26.5
5	f2	SppA	27
6	f2	SppA	28
1	f2	SppB	25.5
2	f2	SppB	28.1
3	f2	SppB	30.1
4	f2	SppB	30.6
5	f2	SppB	31.1
6	f2	SppB	34.9
1	f3	SppA	27.5
2	f3	SppA	28
3	f3	SppA	29.2
4	f3	SppA	29.5
5	f3	SppA	30
6	f3	SppA	31
1	f3	SppB	36.1
2	f3	SppB	36.6
3	f3	SppB	36.8
4	f3	SppB	37.1
5	f3	SppB	37.1
6	f3	SppB	38.7
;

/* CRD for comparison */
proc mixed data=RCBD_oneway method=type3;
class fert species;                                                                                                                     
model height = fert species fert*species;  
run;

/* RCBD */
proc mixed data=RCBD_oneway method=type3;
class block fert species;                                                                                                                     
model height = fert species fert*species;  
random block;
run;
