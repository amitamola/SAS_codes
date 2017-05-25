%put _all_;
run;


Title "aaj ki date kya hai = &Sysdate9. ";
proc print data=Sashelp.class;
run;

%Let OR = 100;

data Check_100;
set sashelp.class;
if weight > &or. ;
run;


%Let dept = M;

data check_M100;
set sashelp.class;
if weight > &or. and sex = "&dept.";
run;

%put _all_ ;
run;


%put &or. &dept. ;

%macro Naruto(p1=,p2=);
data &p1. ;
set sashelp.class;
if sex = "&p2.";
run;
%mend Naruto;

%Naruto (p1=male ,p2=M);

%Naruto (p1=female ,p2=F);


%macro Naruto(p1=,p2=);
data &p2. ;
set sashelp.class;
if sex = "&p2.";
run;
%mend Naruto;

%Naruto (p1=male ,p2=M);

%Naruto (p1=female ,p2=F);

%macro Naruto(p1=,p2=);
data x_&p2. ;
set sashelp.class;
if sex = "&p2.";
run;

data y_&p1.;
set x_&p2.;
if weight > &or.;
run;

proc sort data = y_&p1. out = z_&p2.;
by weight;
run;

proc sql;
create table r_&p1. as
select sum(weight) as sum_weight
from z_&p2.;
quit;

%mend Naruto;

%Naruto (p1=male ,p2=M);

%Naruto (p1=female ,p2=F);

DATA _NULL_;
CALL SYMPUT ("FIR",PUT(INTNX("YEAR",TODAY(),-1),DATE9.));
RUN;
%PUT &FIR.;

DATA _NULL_;
CALL SYMPUT ("FIR",INTNX("Days",0,14));
CALL SYMPUT ("FRI",INTNX("Days",0,16));
RUN;
%PUT &FIR. &FRI.;


data check_call;
set sashelp.class;
where age between &FIR. and &FRI.;
run;
