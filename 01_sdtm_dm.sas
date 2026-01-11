libname raw "/home/u64409252/data";

proc sort data=raw.dm_raw out=dm_sorted; by subjid; run;
proc sort data=raw.ex_raw out=ex_sorted; by subjid; run;

data sdtm_dm;
    merge dm_sorted(in=a) ex_sorted(in=b);
    by subjid;
    if a; /* Keep only subjects in Demographics */

    /* Standardize Variables */
    length SEX $1 ARM $20;
    if gender = 1 then SEX = "M";
    else if gender = 2 then SEX = "F";
    else SEX = "U";

    if trt = 1 then ARM = "Active Treatment";
    else ARM = "Placebo";
run;
