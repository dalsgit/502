	data hicks;
input trt $ resp ic1 ic2 ic3 ec1 ec2 ec3;
        /* ic=indicator coding ec=effect coding */
datalines;
c1      56      1      0      0      1      0      0
c1      55      1      0      0      1      0      0
c1      62      1      0      0      1      0      0
c1      59      1      0      0      1      0      0
c1      60      1      0      0      1      0      0
c2      64      0      1      0      0      1      0
c2      61      0      1      0      0      1      0
c2      50      0      1      0      0      1      0
c2      55      0      1      0      0      1      0
c2      56      0      1      0      0      1      0
c3      45      0      0      1      0      0      1
c3      46      0      0      1      0      0      1
c3      45      0      0      1      0      0      1
c3      39      0      0      1      0      0      1
c3      43      0      0      1      0      0      1
c4      42      0      0      0      -1      -1      -1
c4      39      0      0      0      -1      -1      -1
c4      45      0      0      0      -1      -1      -1
c4      43      0      0      0      -1      -1      -1
c4      41      0      0      0      -1      -1      -1
;
run;
proc summary data=hicks;
class trt; var resp; output out=a mean=; run;
proc print; title 'Summary Output'; run;

proc mixed data=hicks method=type3;
class trt;
model resp = trt / noint solution;
ods select Type3 SolutionF;
title 'Full (Means) Model';
run;

proc mixed data=hicks method=type3;
class;
model resp = / solution;
ods select Type3 SolutionF;
title 'Reduced model';
run;

proc mixed data=hicks method=type3;
class trt;
model resp=trt / solution;
lsmeans trt;
ods select Type3 SolutionF LSmeans;
title 'Regular ANOVA';
run;

proc reg data=hicks;
model resp=ic1 ic2 ic3;
ods select ANOVA FitStatistics ParameterEstimates;
title 'Indicator Coding';         
run;

proc reg data=hicks;
model resp=ec1 ec2 ec3;
ods select ANOVA FitStatistics ParameterEstimates;
title 'Effect coding';
run;
