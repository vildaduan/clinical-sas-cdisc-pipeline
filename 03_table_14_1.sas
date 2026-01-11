/*************************************************************************
* Program Name:  03_table_14_1.sas
* Description:   Table 14.1 - Summary of Demographic Characteristics
* Input:         WORK.ADSL
* Output:        PDF/RTF Report
*************************************************************************/

/* 1. Set Output Destination */
ods pdf file="/home/u64409252/Table_14_1_Demographics.pdf" style=Pearl;

title1 "Table 14.1: Summary of Demographic Characteristics";
title2 "Safety Population";

/* 2. Generate the Summary Table */
proc report data=adsl nowd headline headskip split='|';
    /* Filter for Safety Population using your ADaM Flag */
    where SAFFL = "Y";
    
    column AGEGR1 SEX RACE TRTP, (n pct);
    
    define AGEGR1 / group "Age Group" order=internal;
    define SEX    / group "Sex" order=internal;
    define RACE   / group "Race" order=internal;
    define TRTP   / across "Planned Treatment";
    define n      / "n";
    define pct    / "%" format=8.1;
    
    /* Formatting for professional appearance */
    compute after;
        line @1 "Note: Percentages are based on the number of subjects in the Safety Population.";
    endcomp;
run;

ods pdf close;