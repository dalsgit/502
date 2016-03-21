data nested1;                                                                                                                   
input Type $ Species $ Nconc;                                                                                                          
datalines;  	
Type	Species	Nconc
softwood	pine	12
softwood	pine	13
softwood	pine	11
softwood	pine	12
softwood	spruce	15
softwood	spruce	19		
softwood	spruce	17
softwood	spruce	17
softwood	fir	10
softwood	fir	12
softwood	fir	11
softwood	fir	17
hardwood	maple	18
hardwood	maple	20
hardwood	maple	21
hardwood	maple	16
hardwood	oak	20
hardwood	oak	14
hardwood	oak	17
hardwood	oak	15
hardwood	ash	19
hardwood	ash	22
hardwood	ash	21
hardwood	ash	21
		
;

run;                                                                                                                                    

proc mixed data=nested1 method=type3;                                                                                                   
class Type Species;                                                                                                                
model Nconc = Type Species(Type);                                                                                             
store nested1;                                                                                                                          
run;                                                                                                                                    
                                                                                                                                        
ods graphics on;                                                                                                                        
ods html style=statistical sge=on;                                                                                                     
proc plm restore=nested1;                                                                                                               
lsmeans Type / adjust=tukey plot=meanplot cl lines;                                                                                   
lsmeans Species(Type) / adjust=tukey plot=meanplot cl lines;                                                                       
ods exclude diffs diffplot;                                                                                                             
run;
