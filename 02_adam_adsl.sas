/*************************************************************************
* Program Name:  02_adam_adsl.sas
* Description:   Creation of ADaM ADSL (Subject-Level Analysis)
* Input:         WORK.SDTM_DM
* Output:        WORK.ADSL
*************************************************************************/

data adsl;
    set sdtm_dm;
    
    /* 1. TRTP (Planned Treatment) and TRTPN (Numeric version) */
    /* TRTPN is used to ensure Placebo and Active appear in the correct order */
    TRTP = ARM;
    if ARMCD = "ACT" then TRTPN = 1;
    else if ARMCD = "PBO" then TRTPN = 2;
    
    /* 2. AGEGR1 (Analysis Age Group 1) */
    /* Categorizing continuous age for Table 14.1 summary rows */
    length AGEGR1 $20;
    if . < age < 50 then AGEGR1 = "< 50 years";
    else if age >= 50 then AGEGR1 = ">= 50 years";
    else AGEGR1 = "Missing";
    
    /* 3. SAFFL (Safety Population Flag) */
    /* In this study, all randomized subjects received at least one dose */
    SAFFL = "Y";
    
    /* 4. Variable Labels (Industry Standard) */
    label TRTP   = "Planned Treatment"
          TRTPN  = "Planned Treatment (N)"
          AGEGR1 = "Age Group 1"
          SAFFL  = "Safety Population Flag"
          age    = "Analysis Age";
run;

/* Quick Validation Check: Ensure the flags and groups mapped correctly */
proc freq data=adsl;
    title "Validation: Treatment and Age Group Mapping";
    tables TRTP*TRTPN AGE*AGEGR1 / list missing;
run;
title;