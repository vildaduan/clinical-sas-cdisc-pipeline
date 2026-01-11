# Clinical SAS Programming Pipeline: End-to-End CDISC Implementation

This repository demonstrates a professional clinical data workflow, transforming raw EDC (Electronic Data Capture) data into a submission-ready Demographic Table (TLF) by implementing **CDISC SDTM** and **ADaM** standards.



## 🧬 Project Overview
The study analyzes demographic characteristics for a safety population of **60 subjects**. The pipeline is built to handle real-world clinical data challenges, such as:
* **Merging disparate sources** (Demographics and Treatment assignments).
* **Handling missing values** (Mapping Subject 712's missing gender to CDISC standards).
* **Data Traceability** from raw source to final analysis output.

##  Repository Structure & Pipeline

### 1. Data Foundation ([00_create_raw_data.sas](00_create_raw_data.sas))
* **Source:** Simulated raw EDC exports (`dm_raw` and `ex_raw`).
* **Function:** Establishes the permanent "Raw" library and simulates the initial database structure.

### 2. SDTM Mapping ([01_sdtm_dm.sas](01_sdtm_dm.sas))
* **Domain:** DM (Demographics).
* **Skills:** * Mapped numeric raw codes to **CDISC Controlled Terminology** (e.g., `gender=1` → `SEX="M"`).
    * Standardized missing data for Subject 712 using the "U" (Unknown) standard.
    * Implemented **ISO 8601** date standards and generated **USUBJID**.

### 3. ADaM Transformation ([02_adam_adsl.sas](02_adam_adsl.sas))
* **Dataset:** ADSL (Subject-Level Analysis Dataset).
* **Skills:** * **Derivations:** Created `AGEGR1` (Categorical Age Groups) for statistical summary.
    * **Population Flags:** Implemented `SAFFL` (Safety Population Flag) to define the Analysis Set.
    * **Sorting Logic:** Created `TRTPN` (Numeric Treatment) to ensure correct column ordering in reports.

### 4. TLF Generation ([03_table_14_1.sas](03_table_14_1.sas))
* **Output:** Table 14.1 - Summary of Demographic Characteristics.
* **Execution:** Generated via `PROC REPORT`, sourcing exclusively from the ADaM layer to ensure data integrity and audit-readiness.

##  Mapping Specifications
Detailed mapping logic and metadata can be found in the [specifications.md](specifications.md) file.



##  Technical Environment
* **Language:** SAS 9.4
* **Platform:** Developed and validated using **SAS On Demand for Academics**.
* **Compliance:** SDTM IG v3.3 | ADaM IG v1.1.

