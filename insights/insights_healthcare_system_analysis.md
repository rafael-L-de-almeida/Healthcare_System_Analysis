# INSIGHTS

As a start, for an overview of the patients and encounters of the healthcare system, it was developed an Power BI two reports. Click [here](https://app.powerbi.com/view?r=eyJrIjoiMjE2NmQ4NGUtNThmYS00YTZkLTlmY2UtN2U1NzVhYTY3YWUwIiwidCI6ImFkYWMzNzYyLWYzMWQtNDliNS1iYWI1LWY3NjcxNzZmZjQyNSJ9) to access the **Power BI** report and interact with it.

After interating with it and getting familiar with the data, we can go for the queries.

# Group 1: Patient Demographics & Contact Info

### Q1 – **Business question:** Age distribution by gender and blood type  
Comment: Identifies demographic patterns and risk segmentation across patient groups.  

**Query:** `Q1 from Group 1`

**Insight:** The chart shows that A+ and B+ are the most common blood types. Patient ages are fairly similar across groups. This information helps with blood supply planning and understanding patient demographics. 

![Patient Data Chart](https://i.imgur.com/uBevFMn.png) 

### Q2 – **Business question:** Patients with missing contact info  
Comment: Reveals patients unreachable for follow-ups and communications.  

**Query:** `Q2 from Group 1`

**Insight:** The query returned an empty table, indicating that reception staff are accurately recording contact information. Current processes should be maintained.  

### Q3 – **Business question:** Average vitals pressure by age group and blood type  
Comment: Highlights clinical risk trends and early indicators of hypertension.  

**Query:** `Q3 from Group 1`

**Insight:** No significant differences were observed between Young, Adult, and Elderly groups. Blood pressure averages appear uniform, suggesting that neither age group nor blood type meaningfully affects average blood pressure in this dataset.  

![Age Classification](https://i.imgur.com/HCEE3Da.png)

### Q4 – **Business question:** Patients ordered by date of birth (oldest first)  
Comment: Helps identify elderly populations for priority care programs, such as blood donations.  

**Query:** `Q4 from Group 1`

**Insight:** The list allows identification of elderly patients for targeted programs.  

### Q5 – **Business question:** All vitals recorded with patient name and encounter date  
Comment: Enables longitudinal health monitoring and clinical trend analysis.  

**Query:** `Q5 from Group 1`

**Insight:** This table shows when vitals were checked, allowing tracking of health trends over time while maintaining patient privacy.  

# Group 2: Patient Encounter Frequency & Patterns

### Q1 – **Business question:** Patients with highest encounters in the last 12 months  
Comment: Identifies high-utilization and potentially chronic patients.  

**Query:** `Q1 from Group 2`

**Insight:** The list helps identify patients who frequently use facilities and may have chronic conditions.  

### Q2 – **Business question:** Patients with multiple encounters at the same facility  
Comment: Shows facility loyalty and potential care continuity.  

**Query:** `Q2 from Group 2`

**Insight:** The list identifies patients demonstrating loyalty to specific facilities and potential persistent health issues.  

### Q3 – **Business question:** Patients treated by multiple specialties  
Comment: Indicates complex or multi-condition patients.  

**Query:** `Q3 from Group 2`

**Insight:** Helps flag patients with complex conditions requiring multiple specialties.  

### Q4 – **Business question:** Providers with highest repeat-patient rate  
Comment: Measures provider continuity and patient trust.  

**Query:** `Q4 from Group 2`

**Insight:** Identifies providers who retain patients, useful for recognition or performance evaluation. 

![Repetition Rate Chart](https://i.imgur.com/OEHG4X5.png)
![High Encounters Chart](https://i.imgur.com/mHYrFGc.png)
### Q5 – **Business question:** Encounter count per patient  
Comment: Establishes baseline utilization metrics.  

**Query:** `Q5 from Group 2`

**Insight:** Helps identify high- and low-utilization patients, indicating potential chronic conditions or under-engagement.  

### Q6 – **Business question:** Patients with more than 3 encounters  
Comment: Flags frequent users and cost-intensive patients.  

**Query:** `Q6 from Group 2`

**Insight:** Highlights patients who frequently visit and potentially incur higher healthcare costs.  

### Q7 – **Business question:** Ranking encounters per patient by recency  
Comment: Supports timeline analysis and recent care evaluation.  

**Query:** `Q7 from Group 2`

**Insight:** Allows identification of active versus inactive patients and those returning frequently in a short period.  

### Q8 – **Business question:** Most recent encounter per patient  
Comment: Identifies latest patient interaction for follow-ups.  

**Query:** `Q8 from Group 2`

**Insight:** Quickly identifies active versus inactive patients.  

### Q9 – **Business question:** Compare current vs previous encounter dates  
Comment: Measures revisit intervals and care frequency.  

**Query:** `Q9 from Group 2`

**Insight:** Provides insight into patient revisit patterns and potential health conditions.  

### Q10 – **Business question:** Patients with multiple encounters and total counts  
Comment: Quantifies repeat engagement per patient.  

**Query:** `Q10 from Group 2`

**Insight:** Highlights repeat or high-utilization patients, showing frequency of facility usage.  

### Q11 – **Business question:** Patients with encounters at hospital facilities  
Comment: Identifies higher-acuity or inpatient care usage.  

**Query:** `Q11 from Group 2`

**Insight:** Flags patients requiring hospital-level care, indicating more serious or complex conditions.  

# Group 3: Facility & Encounter Analysis

### Q1 – **Business question:** Monthly 2024 encounters by facility and type  
Comment: Tracks demand trends and seasonal utilization patterns.  

**Query:** `Q1 from Group 3`

**Insight:** Helps forecast trends and plan resources based on facility and encounter type.  

### Q2 – **Business question:** Average encounters per patient by facility type  
Comment: Compares efficiency and patient load across facility types.  

**Query:** `Q2 from Group 3`

**Insight:** Provides insight into efficiency and workload distribution.  

### Q3 – **Business question:** Facilities with highest revisit rate  
Comment: Identifies facilities with strong patient retention.  

**Query:** `Q3 from Group 3`

**Insight:** Highlights facilities with high patient retention, useful for investment decisions.  

### Q4 – **Business question:** Emergency case rate per facility  
Comment: Highlights emergency load and resource strain.  

**Query:** `Q4 from Group 3`

**Insight:** Identifies facilities under greater emergency pressure that may need additional resources.  

### Q5 – **Business question:** Average heart rate per facility  
Comment: Indicates patient acuity levels by location.  

**Query:** `Q5 from Group 3`

**Insight:** Shows trends in patient cardiac activity and potential health patterns per facility.  

![Multiple Encounters Chart](https://i.imgur.com/xkSBKzh.png)

### Q6 – **Business question:** Encounters in a specific year  
Comment: Supports time-based reporting and audits.  

**Query:** `Q6 from Group 3`

**Insight:** Shows total patient encounters per facility for the year, indicating volume and resource needs.  

### Q7 – **Business question:** Encounters with patient name and date  
Comment: Enables patient-level encounter tracking.  

**Query:** `Q7 from Group 3`

**Insight:** Provides detailed individual visit information.  

### Q8 – **Business question:** Encounters with provider and facility  
Comment: Connects care delivery to responsible entities.  

**Query:** `Q8 from Group 3`

**Insight:** Shows which provider saw which patient and at which facility.  

### Q9 – **Business question:** Encounters billed above average  
Comment: Identifies high-cost encounters.  

**Query:** `Q9 from Group 3`

**Insight:** Flags encounters generating higher-than-average charges.  

### Q10 – **Business question:** Encounters with total billing > 200  
Comment: Flags high-revenue or potentially costly cases.  

**Query:** `Q10 from Group 3`

**Insight:** Identifies higher-cost visits that may require review or resource planning.  


# Group 4: Provider & Specialty Analysis

### Q1 – **Business question:** Average encounters per provider per month by specialty  
Comment: Measures workload distribution and specialty demand.  

**Query:** `Q1 from Group 4`

**Insight:** Guides resource allocation and hiring based on specialty demand.  

### Q2 – **Business question:** Specialties with highest total billing  
Comment: Identifies revenue-driving clinical areas.  

**Query:** `Q2 from Group 4`

**Insight:** Highlights specialties generating the most revenue.  

![Age Distribution Chart](https://i.imgur.com/ryKKDb5.png)

### Q3 – **Business question:** Providers in Cardiology  
Comment: Supports specialty-specific reporting.  

**Query:** `Q3 from Group 4`

**Insight:** Lists cardiology specialists for reporting or workforce planning.  

### Q4 – **Business question:** Providers and their encounters (including zero)  
Comment: Identifies underutilized or inactive providers.  

**Query:** `Q4 from Group 4`

**Insight:** Helps allocate resources and identify underperforming staff.  

### Q5 – **Business question:** Providers ranked by encounter volume  
Comment: Highlights high-performing or overloaded providers.  

**Query:** `Q5 from Group 4`

**Insight:** Shows workload distribution and identifies heavily utilized providers.  


# Group 5: Prescriptions & Pharmacies

### Q1 – **Business question:** Pharmacies with >10 prescriptions  
Comment: Identifies high-volume dispensing partners.  

**Query:** `Q1 from Group 5`

**Insight:** Flags pharmacies with high prescription volumes.  

### Q2 – **Business question:** Most prescribed medications by month and facility  
Comment: Reveals prescribing trends and demand patterns.  

**Query:** `Q2 from Group 5`

**Insight:** Helps plan medication inventory and anticipate demand.  

### Q3 – **Business question:** Prescriptions with quantity >30  
Comment: Flags long-term or chronic medication usage.  

**Query:** `Q3 from Group 5`

**Insight:** Provides insight into patients with long-term or chronic medication needs.  

### Q4 – **Business question:** Prescriptions with medication and pharmacy names  
Comment: Enables prescription fulfillment analysis.  

**Query:** `Q4 from Group 5`

**Insight:** Tracks which medications were dispensed by which pharmacies.  

### Q5 – **Business question:** Pharmacies with prescriptions (including none)  
Comment: Identifies inactive or underused pharmacies.  

**Query:** `Q5 from Group 5`

**Insight:** Flags pharmacies with little or no prescription activity.  


# Group 6: Diagnoses & Procedures

### Q1 – **Business question:** Diagnoses linked to pre-hypertension  
Comment: Identifies conditions correlated with elevated blood pressure.  

**Query:** `Q1 from Group 6`

**Insight:** Highlights diagnoses commonly associated with elevated systolic BP, useful for research.  

### Q2 – **Business question:** CPT code with highest average revenue  
Comment: Highlights the most profitable procedures.  

**Query:** `Q2 from Group 6`

**Insight:** Identifies procedures generating the highest revenue.  

### Q3 – **Business question:** Procedures with patient name and encounter date  
Comment: Enables procedure-level clinical and billing analysis.  

**Query:** `Q3 from Group 6`

**Insight:** Tracks which procedures patients have undergone.  


# Group 7: Insurance & Billing

### Q1 – **Business question:** Total charges vs total paid by insurer  
Comment: Measures insurer reimbursement efficiency.  

**Query:** `Q1 from Group 7`

**Insight:** Provides insight into actual insurer reimbursements for patients.  

### Q2 – **Business question:** % of claims paid below 80% by facility and provider  
Comment: Identifies underpayment risks and revenue leakage.  

**Query:** `Q2 from Group 7`

**Insight:** Highlights trends in partial payments by facility and provider.  

### Q3 – **Business question:** Average charge per encounter by encounter type  
Comment: Compares cost intensity across encounter categories.  

**Query:** `Q3 from Group 7`

**Insight:** Helps plan pricing and resource allocation.  

### Q4 – **Business question:** Total billed vs paid per insurance provider  
Comment: Assesses insurer payment behavior.  

**Query:** `Q4 from Group 7`

**Insight:** Shows overall reimbursement patterns per insurer.  

### Q5 – **Business question:** Encounters with insurance claims (including none)  
Comment: Identifies uninsured encounters and billing gaps.  

**Query:** `Q5 from Group 7`

**Insight:** Highlights patient encounters using insurance and identifies potential gaps in coverage.  



# **Summary and Final Analysis**

## **Key Areas & Insights**

### 1. Patient Demographics & Data Quality

-   Segmented patients by **age, gender, and blood type** to identify at-risk populations.
    
-   Identified **missing or incomplete contact information**, impacting outreach, follow-ups, and recalls.
    
-   Analyzed **average blood pressure by age and blood type** to flag potential pre-hypertension trends.
    
-   Tracked **patient vitals over time** to support longitudinal health monitoring.
    

### 2. Patient Encounter Patterns

-   Identified **high-frequency patients** to support chronic care and care-management planning.
    
-   Analyzed **continuity of care** by tracking repeated encounters at the same facility.
    
-   Flagged patients treated across **multiple specialties** as complex or high-needs cases.
    
-   Measured provider influence using **repeat-patient rates** and encounter timelines.
    

### 3. Facility & Encounter Analysis

-   Measured **monthly encounter volumes and trends** by facility and encounter type.
    
-   Calculated **revisit rates and emergency case proportions** per facility.
    
-   Identified **high-value encounters** and analyzed average vitals to infer patient acuity.
    

### 4. Provider & Specialty Analysis

-   Analyzed **encounter volume per provider and specialty** to assess workload distribution.
    
-   Identified **specialties generating the highest revenue**.
    
-   Ranked providers to evaluate **performance, utilization, and contribution**.
    

### 5. Prescriptions & Pharmacies

-   Tracked **high-volume pharmacies** and the most frequently prescribed medications.
    
-   Identified **long-term prescriptions** to support chronic care analysis.
    
-   Highlighted **inactive or underutilized pharmacies**.
    

### 6. Diagnoses & Procedures

-   Identified diagnoses associated with **pre-hypertension** to support preventive care initiatives.
    
-   Determined **CPT codes generating the highest revenue**.
    
-   Linked procedures to encounters to enable **clinical and billing correlation**.
    

### 7. Insurance & Billing

-   Compared **total charges versus paid amounts** by insurer.
    
-   Flagged **underpaid claims (below 80%)** by facility and provider.
    
-   Calculated **average charge per encounter** for financial benchmarking.
    
-   Identified encounters **with and without insurance claims**.
    

----------

## **Tools & Skills**

-   **SQL** for data extraction, cleaning, and aggregation
    
-   **Data quality analysis**, including orphan record and consistency checks
    
-   **Analytical modeling** across patients, encounters, facilities, providers, prescriptions, and billing
    
-   **Data visualization** using Excel for exploratory analysis and reporting
    

----------

## **Impact**

-   Improved **understanding of patient demographics and risk profiles**
    
-   Enabled **targeted outreach and preventive care strategies**
    
-   Identified **high-utilization patients and provider performance patterns**
    
-   Exposed **clinical, operational, and financial inefficiencies**
    
-   Supported **data-driven decision-making** for care optimization, resource allocation, and revenue improvement
