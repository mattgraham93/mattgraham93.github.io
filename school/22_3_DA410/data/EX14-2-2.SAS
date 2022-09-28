/* EXAMPLES 14.2.2, 14.3.3, 14.4 */   

data gradedat;
  infile 'T14_1_GRADES.dat';
  input Labmean	Hwmean	Pqmean	Exam1	Exam2	ExamFin;
run;


title 'PROC CALIS: Evaluating a specific hypothesis about the structure: f1 mastery f2 effort';
proc calis method=ml cov;
  lineqs
     Labmean =            lam12 f2 + e1,
	 Hwmean  =                  f2 + e2,
	 Pqmean  = lam31 f1 + lam32 f2 + e3,
	 Exam1   = lam41 f1            + e4,
	 Exam2   = lam51 f1            + e5,
	 ExamFin =       f1            + e6;
  std
     e1-e6= psi1-psi6,
	 f1 f2= phi1 phi2;
  cov
     f1 f2= phi12;
  bounds
     0 <= phi1-phi2,
	 0 <= psi1-psi6;
run;




title 'PROC CALIS: Revised model';
proc calis method=ml cov;
  lineqs
     Labmean =            lam12 f2 + e1,
	 Hwmean  =                  f2 + e2,
	 Pqmean  = lam31 f1            + e3,
	 Exam1   = lam41 f1            + e4,
	 Exam2   = lam51 f1            + e5,
	 ExamFin =       f1            + e6;
  std
     e1-e6= psi1-psi6,
	 f1 f2= phi1 phi2;
  cov
     f1 f2= phi12;
  bounds
     0 <= phi1-phi2,
	 0 <= psi1-psi6;
run;

