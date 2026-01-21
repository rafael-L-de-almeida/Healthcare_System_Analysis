/* =========================================================
   COMPLETE HEALTHCARE SQL ANALYSIS – GROUPS 1 TO 7
   ========================================================= */


/* =========================================================
   Group 1: Patient Demographics & Contact Info
   ========================================================= */

/* Q1. Age distribution of patients by gender and blood type */
CREATE VIEW v1_age_by_gender_by_blood_type AS
SELECT
    p.gender,
    p.blood_type,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE())), 2) AS Age_AVG,
    MIN(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE())) AS Age_MIN,
    MAX(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE())) AS Age_MAX,
    COUNT(*) AS Total
FROM patients p
GROUP BY p.gender, p.blood_type;

/* Q2. Patients with missing contact info (phone or email) */
CREATE VIEW v2_patients_missing_contact AS
SELECT
    p.patient_id,
    pc.email,
    pc.phone
FROM patients p
LEFT JOIN patient_contacts pc ON p.patient_id = pc.patient_id
WHERE pc.address IS NULL OR pc.phone IS NULL;

/* Q3. Average systolic and diastolic BP by age group and blood type */
CREATE VIEW v3_avg_bp_by_agegroup_bloodtype AS
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 30 THEN 'Young'
        WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) BETWEEN 31 AND 60 THEN 'Adult'
        ELSE 'Elderly'
    END AS AgeClassification,
    p.blood_type,
    ROUND(AVG(v.systolic_bp), 2) AS Avg_Systolic_BP,
    ROUND(AVG(v.diastolic_bp), 2) AS Avg_Diastolic_BP
FROM patients p
JOIN encounters e ON e.patient_id = p.patient_id
JOIN vitals v ON v.encounter_id = e.encounter_id
GROUP BY AgeClassification, p.blood_type
ORDER BY
    CASE AgeClassification
        WHEN 'Young' THEN 1
        WHEN 'Adult' THEN 2
        WHEN 'Elderly' THEN 3
    END;

/* Q4. Listing all patients with date of birth and blood type (oldest first) */
CREATE VIEW v4_patients_dob_bloodtype AS
SELECT
    p.patient_id,
    p.date_of_birth,
    p.blood_type
FROM patients p
ORDER BY p.date_of_birth;

/* Q5. Listing all vitals with patient name and encounter date */
CREATE VIEW v5_vitals_with_patient_and_encounter AS
SELECT
    v.vital_id,
    p.full_name,
    e.encounter_date
FROM vitals v
JOIN encounters e ON e.encounter_id = v.encounter_id
JOIN patients p ON p.patient_id = e.patient_id;


/* =========================================================
   Group 2: Patient Encounter Frequency & Patterns
   ========================================================= */

/* Q1. Highest number of encounters in last 12 months */
CREATE VIEW v6_top_patients_last_12_months AS
SELECT
    p.full_name AS Patient,
    COUNT(*) AS Nr_of_Encounters
FROM patients p
JOIN encounters e ON e.patient_id = p.patient_id
WHERE e.encounter_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY p.patient_id
ORDER BY Nr_of_Encounters DESC
LIMIT 10;

/* Q2. Patients with more than 1 encounter all in same facility */
CREATE VIEW v7_patients_single_facility AS
SELECT
    p.patient_id,
    p.full_name,
    MIN(f.facility_id) AS facility_id
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
JOIN facilities f ON f.facility_id = e.facility_id
GROUP BY p.patient_id, p.full_name
HAVING COUNT(DISTINCT f.facility_id) = 1
ORDER BY p.full_name;

/* Q3. Patients treated by more than one specialty */
CREATE VIEW v8_patients_multiple_specialties AS
SELECT 
    p.patient_id,
    COUNT(DISTINCT pr.specialty) AS specialties_count
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY p.patient_id
HAVING specialties_count > 1;

/* Q4. Providers with highest repeat-patient rate */
CREATE VIEW v9_provider_repeat_rate AS
SELECT
    pr.full_name,
    COUNT(e.encounter_id) AS Encounters,
    COUNT(DISTINCT e.patient_id) AS NumberOfPatients,
    ROUND(
        (COUNT(e.encounter_id) - COUNT(DISTINCT e.patient_id)) * 100.0
        / COUNT(DISTINCT e.patient_id), 2
    ) AS RepetitionRate
FROM encounters e
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY pr.full_name
ORDER BY RepetitionRate DESC;

/* Q5. Number of encounters per patient */
CREATE VIEW v10_encounters_per_patient AS
SELECT
    e.patient_id,
    COUNT(e.encounter_id) AS encounter_count
FROM encounters e
GROUP BY e.patient_id;

/* Q6. Patients with more than 3 encounters */
CREATE VIEW v11_patients_more_than_3_encounters AS
SELECT
    e.patient_id,
    COUNT(e.encounter_id) AS encounter_count
FROM encounters e
GROUP BY e.patient_id
HAVING COUNT(e.encounter_id) > 3;

/* Q7. Ranking encounters per patient (most recent to oldest) */
CREATE VIEW v12_encounter_ranking_per_patient AS
SELECT
    e.patient_id,
    e.encounter_date,
    ROW_NUMBER() OVER(PARTITION BY e.patient_id ORDER BY e.encounter_date DESC) AS ranking
FROM encounters e;

/* Q8. Most recent encounter per patient */
CREATE VIEW v13_most_recent_encounter_per_patient AS
SELECT
    patient_id,
    encounter_date
FROM (
    SELECT
        e.patient_id,
        e.encounter_date,
        ROW_NUMBER() OVER(PARTITION BY e.patient_id ORDER BY e.encounter_date DESC) AS ranking
    FROM encounters e
) AS t
WHERE ranking = 1;

/* Q9. Compare current and previous encounter date per patient */
CREATE VIEW v14_current_previous_encounter AS
SELECT
    e.patient_id,
    e.encounter_date,
    LAG(e.encounter_date) OVER(PARTITION BY e.patient_id ORDER BY e.encounter_date) AS previous_encounter_date
FROM encounters e;

/* Q10. Patients with multiple encounters, listing total encounters */
CREATE VIEW v15_patients_multiple_encounters AS
SELECT
    p.patient_id,
    p.full_name,
    COUNT(e.encounter_id) AS encounter_count
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
GROUP BY p.patient_id
HAVING COUNT(e.encounter_id) > 1;

/* Q11. Patients with at least one encounter at hospital-type facility */
CREATE VIEW v16_patients_at_hospital AS
SELECT DISTINCT
    e.patient_id
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
WHERE f.facility_type = 'Hospital';


/* =========================================================
   Group 3: Facility & Encounter Analysis
   ========================================================= */

/* Q1. Monthly 2024 encounter volume by facility and type */
CREATE VIEW v17_monthly_2024_encounters_by_facility AS
SELECT
    f.facility_id,
    e.encounter_type,
    DATE_FORMAT(e.encounter_date, '%m') AS month,
    COUNT(*) AS encounter_count
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
WHERE YEAR(e.encounter_date) = 2024
GROUP BY f.facility_id, e.encounter_type, month
ORDER BY f.facility_id, e.encounter_type, month;

/* Q2. Average encounters per patient by facility type */
CREATE VIEW v18_avg_encounters_per_patient_by_facility_type AS
SELECT
    t.facility_type,
    AVG(t.encounters_per_patient) AS avg_encounters
FROM (
    SELECT
        f.facility_type,
        COUNT(e.encounter_id) AS encounters_per_patient
    FROM patients p
    JOIN encounters e ON p.patient_id = e.patient_id
    JOIN facilities f ON f.facility_id = e.facility_id
    GROUP BY p.patient_id, f.facility_type
) AS t
GROUP BY t.facility_type;

/* Q3. Facilities with highest patient revisit rate */
CREATE VIEW v19_facility_revisit_rate AS
SELECT
    f.facility_name,
    (1 - (COUNT(DISTINCT e.patient_id) * 1.0 / COUNT(e.patient_id))) * 100 AS RevisitRate
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
GROUP BY f.facility_name
ORDER BY RevisitRate DESC;

/* Q4. Rate of emergency cases per facility */
CREATE VIEW v20_emergency_rate_by_facility AS
SELECT
    f.facility_name,
    ROUND(
        COUNT(CASE WHEN e.encounter_type = 'Emergency' THEN 1 END) * 1.0
        / COUNT(e.encounter_id), 2
    ) AS EmergencyRate
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
GROUP BY e.facility_id;

/* Q5. Average heart rate per facility */
CREATE VIEW v21_avg_heart_rate_by_facility AS
SELECT
    f.facility_name,
    ROUND(AVG(v.heart_rate), 2) AS Avg_Heart_Rate
FROM facilities f
JOIN encounters e ON f.facility_id = e.facility_id
JOIN vitals v ON v.encounter_id = e.encounter_id
GROUP BY f.facility_name;

/* Q6. Encounters in specific year (2024) */
CREATE VIEW v22_encounters_2024 AS
SELECT
    e.*
FROM encounters e
WHERE YEAR(e.encounter_date) = 2024;

/* Q7. Each encounter with patient name and date */
CREATE VIEW v23_encounter_patient_names AS
SELECT
    e.encounter_date,
    p.full_name
FROM encounters e
JOIN patients p ON p.patient_id = e.patient_id;

/* Q8. Encounters with provider and facility names */
CREATE VIEW v24_encounters_with_provider_and_facility AS
SELECT
    e.encounter_date,
    f.facility_name,
    pr.full_name
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
JOIN providers pr ON pr.provider_id = e.provider_id;

/* Q9. Encounters where total billed exceeds average billed */
CREATE VIEW v25_encounters_total_billed_above_avg AS
WITH CTE_AvgBilled AS (
    SELECT AVG(c.charge_amount) AS avg_billed
    FROM charges c
)
SELECT
    e.encounter_id,
    e.patient_id,
    e.encounter_date,
    SUM(c.charge_amount) AS total_billed
FROM encounters e
JOIN charges c ON c.encounter_id = e.encounter_id
GROUP BY e.encounter_id, e.patient_id, e.encounter_date
HAVING SUM(c.charge_amount) > (SELECT avg_billed FROM CTE_AvgBilled);

/* Q10. Total billed per encounter exceeding 200 */
CREATE VIEW v26_total_billed_per_encounter_above_200 AS
WITH CTE_TotalAmount AS (
    SELECT
        e.encounter_id,
        SUM(c.charge_amount) AS total_billed
    FROM encounters e
    JOIN charges c ON e.encounter_id = c.encounter_id
    GROUP BY e.encounter_id
)
SELECT *
FROM CTE_TotalAmount
WHERE total_billed > 200;


/* =========================================================
   Group 4: Provider & Specialty Analysis
   ========================================================= */

/* Q1. Average encounters per provider per month by specialty */
CREATE VIEW v27_avg_encounters_per_provider_by_specialty AS
SELECT
    DATE_FORMAT(e.encounter_date, '%m') AS month,
    pr.specialty,
    COUNT(*) AS total_encounters,
    COUNT(DISTINCT e.provider_id) AS total_providers,
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT e.provider_id), 2) AS avg_per_provider
FROM encounters e
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY month, pr.specialty
ORDER BY month, pr.specialty;

/* Q2. Specialties with highest total billing amount */
CREATE VIEW v28_specialties_highest_avg_billing AS
SELECT
    pr.specialty,
    ROUND(AVG(c.charge_amount), 2) AS Average_Charged_Amount
FROM encounters e
JOIN charges c ON c.encounter_id = e.encounter_id
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY pr.specialty
ORDER BY Average_Charged_Amount DESC;

/* Q3. Providers whose specialty is Cardiology */
CREATE VIEW v29_cardiology_providers AS
SELECT
    pr.*
FROM providers pr
WHERE pr.specialty = 'Cardiology';

/* Q4. All providers and encounters including zero encounters */
CREATE VIEW v30_providers_with_zero_encounters AS
SELECT
    pr.provider_id,
    e.encounter_id
FROM providers pr
LEFT JOIN encounters e ON e.provider_id = pr.provider_id;

/* Q5. Ranking providers by number of encounters */
CREATE VIEW v31_provider_ranking_by_encounters AS
SELECT
    provider_id,
    counting AS encounter_count,
    DENSE_RANK() OVER(ORDER BY counting DESC) AS provider_rank
FROM (
    SELECT
        e.provider_id,
        COUNT(e.encounter_id) AS counting
    FROM encounters e
    GROUP BY e.provider_id
) t;

/* =========================================================
   Group 5: Prescriptions & Pharmacies
   ========================================================= */

/* Q1. Pharmacies with more than 10 prescriptions */
CREATE VIEW v32_pharmacies_more_than_10_prescriptions AS
SELECT 
    pr.pharmacy_id,
    COUNT(pr.prescription_id) AS prescription_count
FROM prescriptions pr
GROUP BY pr.pharmacy_id
HAVING COUNT(pr.prescription_id) > 10;

/* Q2. Most prescribed medications by month and facility */
CREATE VIEW v33_most_prescribed_med_by_month_facility AS
SELECT
    f.facility_name,
    DATE_FORMAT(e.encounter_date, '%Y-%m') AS Y_M,
    m.medication_name,
    COUNT(*) AS med_count
FROM prescriptions p
JOIN encounters e ON e.encounter_id = p.encounter_id
JOIN facilities f ON f.facility_id = e.facility_id
JOIN medications m ON p.medication_id = m.medication_id
GROUP BY f.facility_name, Y_M, m.medication_name
ORDER BY f.facility_name, Y_M, med_count DESC;

/* Q3. Prescriptions with quantity > 30 */
CREATE VIEW v34_prescriptions_quantity_gt_30 AS
SELECT ps.*
FROM prescriptions ps
WHERE ps.quantity > 30;

/* Q4. Prescriptions with medication name and pharmacy name */
CREATE VIEW v35_prescriptions_with_med_and_pharmacy AS
SELECT
    ps.prescription_id,
    m.medication_name,
    ph.pharmacy_name
FROM prescriptions ps
JOIN medications m ON m.medication_id = ps.medication_id
JOIN pharmacies ph ON ph.pharmacy_id = ps.pharmacy_id;

/* Q5. All pharmacies and prescriptions including pharmacies with no prescriptions */
CREATE VIEW v36_all_pharmacies_and_prescriptions AS
SELECT
    ph.pharmacy_id,
    pr.medication_id
FROM pharmacies ph
LEFT JOIN prescriptions pr ON pr.pharmacy_id = ph.pharmacy_id;


/* =========================================================
   Group 6: Diagnoses & Procedures
   ========================================================= */

/* Q1. Diagnoses associated with pre-hypertension (systolic_bp > 121) */
CREATE VIEW v37_diagnoses_prehypertension AS
SELECT
    d.diagnosis_description,
    COUNT(*) AS Recurrence_of_Symptoms
FROM diagnoses d
JOIN encounters e ON d.encounter_id = e.encounter_id
JOIN vitals v ON v.encounter_id = e.encounter_id
WHERE v.systolic_bp > 121
GROUP BY d.diagnosis_description
ORDER BY Recurrence_of_Symptoms DESC;

/* Q2. CPT codes with highest average revenue */
CREATE VIEW v38_cpt_highest_avg_revenue AS
SELECT
    c.cpt_code,
    ROUND(AVG(c.charge_amount), 2) AS Avg_Charge
FROM charges c
GROUP BY c.cpt_code
ORDER BY Avg_Charge DESC;

/* Q3. All procedures with patient name and encounter date */
CREATE VIEW v39_procedures_with_patient_and_date AS
SELECT
    prc.procedure_id,
    p.full_name,
    e.encounter_date
FROM procedures prc
JOIN encounters e ON e.encounter_id = prc.encounter_id
JOIN patients p ON p.patient_id = e.patient_id;


/* =========================================================
   Group 7: Insurance & Billing
   ========================================================= */

/* Q1. Total charges vs paid amounts by charge */
CREATE VIEW v40_charges_vs_paid_by_charge AS
SELECT 
    c.charge_id,
    ic.amount_billed,
    ic.amount_paid,
    ROUND(ic.amount_billed - ic.amount_paid, 2) AS Amount_Not_Paid
FROM charges c
JOIN insurance_claims ic ON c.charge_id = ic.charge_id
ORDER BY c.charge_id;

/* Q2. % of claims paid < 80% by facility and provider */
CREATE VIEW v41_low_paid_claims_by_facility_provider AS
SELECT
    e.facility_id,
    e.provider_id,
    ROUND(
        COUNT(CASE WHEN ic.amount_paid / ic.amount_billed < 0.8 THEN 1 END) * 1.0
        / COUNT(*), 2
    ) AS Low_Paid_Percentage
FROM encounters e
JOIN charges c ON c.encounter_id = e.encounter_id
JOIN insurance_claims ic ON ic.charge_id = c.charge_id
GROUP BY e.facility_id, e.provider_id;

/* Q3. Average charge per encounter by encounter type */
CREATE VIEW v42_avg_charge_by_encounter_type AS
SELECT
    e.encounter_type,
    ROUND(AVG(c.charge_amount), 2) AS Avg_Charge
FROM encounters e 
JOIN charges c ON c.encounter_id = e.encounter_id
GROUP BY e.encounter_type;

/* Q4. Total billed and paid per insurance provider */
CREATE VIEW v43_total_billed_paid_per_insurance_provider AS
SELECT
    ic.insurance_provider,
    SUM(ic.amount_billed) AS total_billed,
    SUM(ic.amount_paid) AS total_paid
FROM insurance_claims ic
GROUP BY ic.insurance_provider;

/* Q5. All encounters with associated insurance claims (including encounters without claims) */
CREATE VIEW v44_encounters_with_claims_including_none AS
SELECT
    e.encounter_id,
    ic.claim_id
FROM encounters e
LEFT JOIN charges c ON c.encounter_id = e.encounter_id
LEFT JOIN insurance_claims ic ON ic.charge_id = c.charge_id;
