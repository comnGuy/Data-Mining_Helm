dm 'log; clear;';
dm 'odsresults; clear;';

LIBNAME readData 'C:\Clouds\OwnCloud\Studium\Data Mining\Aufgaben\Aufgabe 2';

DATA reg_aufgabe;
	set readData.reg_aufgabe;
	*rename x=Raw_P;
RUN;
/*
PROC PRINT data = reg_aufgabe NOOBS;
	title 'Tolle Daten';
RUN;
*/

title 'Stepwise Selection';
ods graphics on;
proc phreg data=reg_aufgabe;
      model y= 	x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
				/ selection=stepwise slentry=0.25
                              slstay=0.15 details;
run;
ods graphics off;


title 'Best Subset Selection';
ods graphics on;
proc phreg data=reg_aufgabe plots=SURVIVAL;
      model y= 	x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
				/ selection=score  slentry=0.25 slstay=0.15 best=1 details;
run;
ods graphics off;



title 'Lasso';
ods graphics on;
   
/*proc glmselect plots=all;*/
proc glmselect plots=all;
      model y= 	x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
				/ selection=lasso details=all;
   run;
ods graphics off;
