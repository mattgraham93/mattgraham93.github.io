data crime;
   infile 'T15_1_CITYCRIME.dat';
   input City$ Murder Rape Robbery Assult Burglary Larceny AutoTheft;
run;

proc cluster data=crime outtree=treecrime method=centroid nonorm;
   var Murder Rape Robbery Assult Burglary Larceny AutoTheft;
   id city;
run;

proc tree data=treecrime;
id city;
run;
