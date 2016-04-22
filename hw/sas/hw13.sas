data trial;                                                                                                                             
input per	seq	$ trt $ id	response x1	x2;
datalines;                                                                                                                              
1	ABC	A	1	174	0	0
1	ABC	A	2	145	0	0
1	ACB	A	3	192	0	0
1	ACB	A	4	194	0	0
1	BAC	B	5	184	0	0
1	BAC	B	6	140	0	0
1	BCA	B	7	136	0	0
1	BCA	B	8	145	0	0
1	CAB	C	9	206	0	0
1	CAB	C	10	160	0	0
1	CBA	C	11	180	0	0
1	CBA	C	12	210	0	0
2	ABC	B	1	146	1	0
2	ABC	B	2	125	1	0
2	ACB	C	3	150	0	1
2	ACB	C	4	208	0	1
2	BAC	A	5	192	-1	-1
2	BAC	A	6	150	-1	-1
2	BCA	C	7	132	1	0
2	BCA	C	8	154	1	0
2	CAB	A	9	220	0	1
2	CAB	A	10	180	0	1
2	CBA	B	11	180	-1	-1
2	CBA	B	12	160	-1	-1
3	ABC	C	1	164	0	1
3	ABC	C	2	130	0	1
3	ACB	B	3	160	-1	-1
3	ACB	B	4	160	-1	-1
3	BAC	C	5	176	1	0
3	BAC	C	6	150	1	0
3	BCA	A	7	138	-1	-1
3	BCA	A	8	166	-1	-1
3	CAB	B	9	210	1	0
3	CAB	B	10	145	1	0
3	CBA	A	11	208	0	1
3	CBA	A	12	226	0	1                                                                             
;                                                                                                                                       
run;                                                                                                                                    
                    
/* Analyze all covariance structures */

proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq) type=csh r rcorr;                                                                                     
lsmeans trt / pdiff adjust=tukey;                                                                                                      
title 'Full Model, CSH, With covariates';                                                                                               
run;                                                                                                                                    

title ; run;
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq) type=csh r rcorr;                                                                                     

ods output FitStatistics=FitCS (rename=(value=CS))
FitStatistics=FitCSp;
title 'Compound Symmetry'; run;


title ; run;
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq);

ods output FitStatistics=FitVC (rename=(value=VC))
FitStatistics=FitVCp;
title 'Variance Components'; run;


title ; run;
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq) type=sp(pow)(time);

ods output FitStatistics=FitSP (rename=(value=SP))
FitStatistics=FitSPp;
title 'Spatial Power'; run;


title ; run;
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq) type=un rcorr;

ods output FitStatistics=FitUN (rename=(value=UN))
FitStatistics=FitUNp;
title 'Unstructured'; run;


title ; run;
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;  
repeated per / subject=id(seq) type=ar(1) rcorr;

ods output FitStatistics=FitAR1 (rename=(value=AR1))
FitStatistics=FitAR1p;
title 'Autoregressive Lag 1'; run;


title 'Covariance Summary'; run;
data fits;
merge FitCS FitVC FitSP FitUN FitAR1;
by descr;
run;
ods listing; proc print data=fits; run;


/* Best Fitting Model: CSH */                                                                                                           
/* Full model with carryover covariates */                                                                                              
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq x1 x2 / ddfm=kr;                                                                                               
repeated per / subject=id(seq) type=csh r rcorr;                                                                                     
lsmeans trt / pdiff adjust=tukey;                                                                                                      
title 'Full Model, CSH, With covariates';                                                                                               
run;  
					                                                                                                                                      
/* Reduced Model without carry-over covariates */                                                                                       
proc mixed data= trial;                                                                                                                 
class per seq trt id;                                                                                                               
model response = per trt seq / ddfm=kr;                                                                                                     
repeated per / subject=id(seq) type=csh;                                                                                             
lsmeans trt / pdiff adjust=tukey;                                                                                                      
title 'Reduced model, CSH, Without covariates';                                                                                         
run;                                                                                                                                    
            