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

/* 2. Using PROC TABULATE for perfect clinical percentages */
proc tabulate data=adsl S=[just=c];
    where SAFFL = "Y";
    
    /* Define the rows and columns */
    class TRTP AGEGR1 SEX RACE;
    
    /* Table logic: (Rows) by (Columns) */
    table (AGEGR1="Age Group" 
           SEX="Sex" 
           RACE="Race"),
          TRTP="Planned Treatment" * (n="n" pctn<TRTP>=" (%)"*f=8.1) / 
          box="Demographic Characteristic" row=float;
run;

ods pdf close;



