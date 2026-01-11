# Data Mapping & Transformation Specifications

**Standard:** CDISC SDTM IG v3.3 / ADaM IG v1.1  
**Author:** Vilda Duan

---

## 1. SDTM DM (Demographics) Specification
**Source Table(s):** `dm_raw`, `ex_raw`  
**Purpose:** To transform raw EDC and Randomization data into a standardized SDTM Demographics domain.

| Target Variable | Label | Type | Length | Mapping Logic / Controlled Terminology |
| :--- | :--- | :--- | :--- | :--- |
| **STUDYID** | Study Identifier | Char | 10 | Hardcoded: "CLN-001" |
| **DOMAIN** | Domain Abbreviation | Char | 2 | Hardcoded: "DM" |
| **USUBJID** | Unique Subject Identifier | Char | 20 | Concatenate: `STUDYID` + "-" + `subjid` |
| **SUBJID** | Subject Identifier | Char | 6 | Left-aligned character version of `subjid` |
| **SEX** | Sex | Char | 1 | If raw.gender=1 then "M"; else if raw.gender=2 then "F"; else "U" |
| **RACE** | Race | Char | 40 | 1: WHITE; 2: BLACK OR AFRICAN AMERICAN; 3: ASIAN |
| **ARM** | Description of Arm | Char | 20 | If raw.trt=1 then "Active Drug"; else "Placebo" |
| **ARMCD** | Planned Arm Code | Char | 8 | If raw.trt=1 then "ACT"; else "PBO" |

---

## 2. ADaM ADSL (Subject-Level Analysis) Specification
**Source Table(s):** `sdtm_dm`  
**Purpose:** To create an "Analysis Ready" dataset for the Safety Population.



| Target Variable | Label | Type | Source / Derivation Logic |
| :--- | :--- | :--- | :--- |
| **STUDYID** | Study Identifier | Char | From `sdtm_dm.STUDYID` |
| **USUBJID** | Unique Subject Identifier | Char | From `sdtm_dm.USUBJID` |
| **TRTP** | Planned Treatment | Char | From `sdtm_dm.ARM` |
| **TRTPN** | Planned Treatment (N) | Num | If `TRTP` = "Active Drug" then 1; else 2. |
| **AGE** | Analysis Age | Num | From `sdtm_dm.age` |
| **AGEGR1** | Analysis Age Group 1 | Char | If `AGE` < 50 then "< 50 years"; else ">= 50 years" |
| **SAFFL** | Safety Population Flag | Char | Set to "Y" for all subjects with at least one dose of study drug. |

---

## 3. TLF Specification (Table 14.1)
**Dataset:** `ADSL`  
**Selection:** `WHERE SAFFL = "Y"`

| Analysis Row | Statistic | Variable |
| :--- | :--- | :--- |
| **Age Group** | n (%) | `AGEGR1` grouped by `TRTP` |
| **Sex** | n (%) | `SEX` grouped by `TRTP` |
| **Race** | n (%) | `RACE` grouped by `TRTP` |

---

##  Validation Rules
1. **Traceability:** Every variable in `ADSL` must be traceable to `DM`.
2. **Missing Data:** Missing `SEX` values in raw data are mapped to "U" per CDISC standards.
3. **Integrity:** The total subject count (N=60) must be consistent across all stages.


