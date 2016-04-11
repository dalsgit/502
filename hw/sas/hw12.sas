data flora;                                                                                                                          
 input  trt	$ plot	time	resp;
 datalines;  
Burn	1	1	27
Burn	1	9	25
Burn	1	12	18
Burn	1	15	21
Burn	2	1	5
Burn	2	9	15
Burn	2	12	10
Burn	2	15	12
Burn	3	1	17
Burn	3	9	26
Burn	3	12	26
Burn	3	15	25
Burn	4	1	41
Burn	4	9	41
Burn	4	12	42
Burn	4	15	38
Burn	5	1	25
Burn	5	9	28
Burn	5	12	22
Burn	5	15	27
Burn	6	1	11
Burn	6	9	24
Burn	6	12	13
Burn	6	15	20
Burn	7	1	37
Burn	7	9	40
Burn	7	12	33
Burn	7	15	31
Burn	8	1	38
Burn	8	9	38
Burn	8	12	33
Burn	8	15	38
Burn	9	1	31
Burn	9	9	33
Burn	9	12	25
Burn	9	15	30
Unburn	1	1	57
Unburn	1	9	46
Unburn	1	12	49
Unburn	1	15	51
Unburn	2	1	43
Unburn	2	9	59
Unburn	2	12	59
Unburn	2	15	60
Unburn	3	1	43
Unburn	3	9	53
Unburn	3	12	52
Unburn	3	15	53
Unburn	4	1	59
Unburn	4	9	55
Unburn	4	12	59
Unburn	4	15	60
Unburn	5	1	42
Unburn	5	9	48
Unburn	5	12	50
Unburn	5	15	48
Unburn	6	1	35
Unburn	6	9	42
Unburn	6	12	50
Unburn	6	15	55
Unburn	7	1	40
Unburn	7	9	51
Unburn	7	12	53
Unburn	7	15	57
Unburn	8	1	24
Unburn	8	9	52
Unburn	8	12	54
Unburn	8	15	59
Unburn	9	1	42
Unburn	9	9	49
Unburn	9	12	50
Unburn	9	15	54
 ;                                                                                                                                                                                                                                                             
                                                                                                                                        
/* Split plot in time */
proc mixed data=flora method=type3;
class trt time plot;
model resp=trt time trt*time / ddfm=kr;
random plot(trt); title 'Split-Plot in Time'; 
run;


/* Repeated Measures Approach */
/* Fitting covariance structures: */
/* Note:  the code beginning with "ods output...." for each
	run of the Mixed procedure generates an output that
	is tablulated at the end to enable comparison of 
	the candidate covariance structures */
title ;
 proc mixed data=flora;
 class trt time plot;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=plot(trt) type=cs rcorr;

ods output FitStatistics=FitCS (rename=(value=CS))
FitStatistics=FitCSp;
title 'Compound Symmetry'; run;


proc mixed data=flora;		
 class trt time;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=plot(trt);

ods output FitStatistics=FitVC (rename=(value=VC))
FitStatistics=FitVCp;
title 'Variance Components'; run;


title ; run;
 proc mixed data=flora;
 class trt time plot;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / type=sp(pow)(time) subject=plot(trt);

ods output FitStatistics=FitSP (rename=(value=SP))
FitStatistics=FitSPp;
title 'Spatial Power'; run;


proc mixed data=flora;
 class trt time plot;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=plot(trt) type=un rcorr;

ods output FitStatistics=FitUN (rename=(value=UN))
FitStatistics=FitUNp;
title 'Unstructured'; run;


title ;  run;
 proc mixed data=flora;
 class trt time plot;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=plot(trt) type=ar(1) rcorr;

ods output FitStatistics=FitAR1 (rename=(value=AR1))
FitStatistics=FitAR1p;
title 'Autoregressive Lag 1'; run;


title 'Covariance Summary'; run;
data fits;
merge FitCS FitVC FitSP FitAR1 FitUN;
by descr;
run;
ods listing; proc print data=fits; run;
