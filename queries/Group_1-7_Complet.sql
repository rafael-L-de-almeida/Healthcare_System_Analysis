/* =========================================================
   COMPLETE HEALTHCARE SQL ANALYSIS – GROUPS 1 TO 7
   ========================================================= */


/* =========================================================
   Group 1: Patient Demographics & Contact Info
   ========================================================= */

/* Q1. Age distribution of patients by gender and blood type */

SELECT
    p.gender,                                
    p.blood_type,                            
    ROUND(
        AVG(
            strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
            - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
        ),
        2
    ) AS Age_AVG,
    MIN(
        strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
        - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
    ) AS Age_MIN,
    MAX(
        strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
        - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
    ) AS Age_MAX,
    COUNT(*) AS Total
FROM patients p
GROUP BY p.gender, p.blood_type;


/* Q2. Patients with missing contact info (phone or email) */

SELECT
    p.patient_id,
    pc.email,
    pc.phone
FROM patients p
LEFT JOIN patient_contacts pc ON p.patient_id = pc.patient_id
WHERE pc.address IS NULL OR pc.phone IS NULL;


/* Q3. Average systolic and diastolic BP by age group and blood type */

SELECT
    CASE
        WHEN strftime('%Y', 'now') - strftime('%Y', p.date_of_birth) <= 30 THEN 'Young'
        WHEN strftime('%Y', 'now') - strftime('%Y', p.date_of_birth) BETWEEN 31 AND 60 THEN 'Adult'
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

SELECT
    p.patient_id,
    p.date_of_birth,
    p.blood_type
FROM patients p
ORDER BY p.date_of_birth;


/* Q5. Listing all vitals with patient name and encounter date */

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

SELECT
    p.full_name AS Patient,
    COUNT(*) AS Nr_of_Encounters
FROM patients p
JOIN encounters e ON e.patient_id = p.patient_id
WHERE e.encounter_date >= date('now','-12 months')
GROUP BY p.patient_id
ORDER BY Nr_of_Encounters DESC
LIMIT 10;


/* Q2. Patients with more than 1 encounter all in same facility */

SELECT
    p.patient_id,
    p.full_name,
    f.facility_id
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
JOIN facilities f ON f.facility_id = e.facility_id
GROUP BY p.patient_id
HAVING COUNT(DISTINCT f.facility_id) = 1
ORDER BY p.full_name;


/* Q3. Patients treated by more than one specialty */

SELECT 
    p.patient_id,
    e.encounter_id,
    pr.specialty
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
JOIN providers pr ON pr.provider_id = e.provider_id
WHERE p.patient_id IN (
    SELECT patient_id
    FROM encounters e
    JOIN providers pr ON pr.provider_id = e.provider_id
    GROUP BY patient_id
    HAVING COUNT(DISTINCT specialty) > 1
);


/* Q4. Providers with highest repeat-patient rate */

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

SELECT
    e.patient_id,
    COUNT(e.encounter_id) AS encounter_count
FROM encounters e
GROUP BY e.patient_id;


/* Q6. Patients with more than 3 encounters */

SELECT
    e.patient_id,
    COUNT(e.encounter_id) AS encounter_count
FROM encounters e
GROUP BY e.patient_id
HAVING COUNT(e.encounter_id) > 3;


/* Q7. Ranking encounters per patient (most recent to oldest) */

SELECT
    e.patient_id,
    e.encounter_date,
    ROW_NUMBER() OVER(PARTITION BY e.patient_id ORDER BY e.encounter_date DESC) AS ranking
FROM encounters e;


/* Q8. Most recent encounter per patient */

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

SELECT
    e.patient_id,
    e.encounter_date,
    LAG(e.encounter_date) OVER(PARTITION BY e.patient_id ORDER BY e.encounter_date) AS previous_encounter_date
FROM encounters e;


/* Q10. Patients with multiple encounters, listing total encounters */

WITH CTE_Multiple_Encounters AS (
    SELECT
        e.patient_id,
        COUNT(e.encounter_id) AS encounter_count
    FROM encounters e
    GROUP BY e.patient_id
    HAVING COUNT(e.encounter_id) > 1
)
SELECT
    p.patient_id,
    p.full_name,
    m.encounter_count
FROM CTE_Multiple_Encounters m
JOIN patients p ON p.patient_id = m.patient_id;


/* Q11. Patients with at least one encounter at hospital-type facility */

SELECT DISTINCT
    e.patient_id
FROM encounters e
JOIN facilities f 
    ON f.facility_id = e.facility_id
WHERE f.facility_type = 'Hospital';



/* =========================================================
   Group 3: Facility & Encounter Analysis
   ========================================================= */

/* Q1. Monthly 2024 encounter volume by facility and type */

SELECT
    f.facility_id,
    e.encounter_type,
    strftime('%m', e.encounter_date) AS month,
    COUNT(*) AS encounter_count
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
WHERE strftime('%Y', e.encounter_date) = '2024'
GROUP BY f.facility_id, e.encounter_type, month
ORDER BY f.facility_id, e.encounter_type, month;


/* Q2. Average encounters per patient by facility type */

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

SELECT
    f.facility_name,
    (1 - (COUNT(DISTINCT e.patient_id) * 1.0 / COUNT(e.patient_id))) * 100 AS RevisitRate
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
GROUP BY f.facility_name
ORDER BY RevisitRate DESC;


/* Q4. Rate of emergency cases per facility */

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

SELECT
    f.facility_name,
    ROUND(AVG(v.heart_rate), 2) AS Avg_Heart_Rate
FROM facilities f
JOIN encounters e ON f.facility_id = e.facility_id
JOIN vitals v ON v.encounter_id = e.encounter_id
GROUP BY f.facility_name;


/* Q6. Encounters in specific year (2024) */

SELECT
    e.*
FROM encounters e
WHERE e.encounter_date LIKE '2024%';


/* Q7. Each encounter with patient name and date */

SELECT
    e.encounter_date,
    p.full_name
FROM encounters e
JOIN patients p ON p.patient_id = e.patient_id;


/* Q8. Encounters with provider and facility names */

SELECT
    e.encounter_date,
    f.facility_name,
    pr.full_name
FROM encounters e
JOIN facilities f ON f.facility_id = e.facility_id
JOIN providers pr ON pr.provider_id = e.provider_id;


/* Q9. Encounters where total billed exceeds average billed */

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

SELECT
    strftime('%m', e.encounter_date) AS month,
    pr.specialty,
    COUNT(*) AS total_encounters,
    COUNT(DISTINCT e.provider_id) AS total_providers,
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT e.provider_id), 2) AS avg_per_provider
FROM encounters e
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY month, pr.specialty
ORDER BY month, pr.specialty;


/* Q2. Specialties with highest total billing amount */

SELECT
    pr.specialty,
    ROUND(AVG(c.charge_amount), 2) AS Average_Charged_Amount
FROM encounters e
JOIN charges c ON c.encounter_id = e.encounter_id
JOIN providers pr ON pr.provider_id = e.provider_id
GROUP BY pr.specialty
ORDER BY Average_Charged_Amount DESC;


/* Q3. Providers whose specialty is Cardiology */

SELECT
    pr.*
FROM providers pr
WHERE pr.specialty = 'Cardiology';


/* Q4. All providers and encounters including zero encounters */

SELECT
    pr.provider_id,
    e.encounter_id
FROM providers pr
LEFT JOIN encounters e 
    ON e.provider_id = pr.provider_id;


/* Q5. Ranking providers by number of encounters */

SELECT
    provider_id,
    counting AS encounter_count,
    DENSE_RANK() OVER(ORDER BY counting DESC) AS rank
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

SELECT 
    pr.pharmacy_id,
    COUNT(pr.prescription_id) AS prescription_count
FROM prescriptions pr
GROUP BY pr.pharmacy_id
HAVING COUNT(pr.prescription_id) > 10;


/* Q2. Most prescribed medications by month and facility */

SELECT
    f.facility_name,
    strftime('%Y-%m', e.encounter_date) AS Y_M,
    m.medication_name
FROM prescriptions p
JOIN encounters e ON e.encounter_id = p.encounter_id
JOIN facilities f ON f.facility_id = e.facility_id
JOIN medications m ON p.medication_id = m.medication_id
GROUP BY f.facility_name, Y_M, m.medication_name, p.medication_id
HAVING COUNT(*) = (
    SELECT MAX(med_count)
    FROM (
        SELECT COUNT(*) AS med_count
        FROM prescriptions p2
        JOIN encounters e2 ON e2.encounter_id = p2.encounter_id
        JOIN facilities f2 ON f2.facility_id = e2.facility_id
        WHERE f2.facility_id = f.facility_id
          AND strftime('%Y-%m', e2.encounter_date) = strftime('%Y-%m', e.encounter_date)
        GROUP BY p2.medication_id
    )
)
ORDER BY f.facility_name, Y_M;


/* Q3. Prescriptions with quantity > 30 */

SELECT ps.*
FROM prescriptions ps
WHERE ps.quantity > 30;


/* Q4. Prescriptions with medication name and pharmacy name */

SELECT
    ps.prescription_id,
    m.medication_name,
    ph.pharmacy_name
FROM prescriptions ps
JOIN medications m ON m.medication_id = ps.medication_id
JOIN pharmacies ph ON ph.pharmacy_id = ps.pharmacy_id;


/* Q5. All pharmacies and prescriptions including pharmacies with no prescriptions */

SELECT
    ph.pharmacy_id,
    pr.medication_id
FROM pharmacies ph
LEFT JOIN prescriptions pr 
    ON pr.pharmacy_id = ph.pharmacy_id;


/* =========================================================
   Group 6: Diagnoses & Procedures
   ========================================================= */

/* Q1. Diagnoses associated with pre-hypertension (systolic_bp > 121) */

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

SELECT
    c.cpt_code,
    ROUND(AVG(c.charge_amount), 2) AS Avg_Charge
FROM charges c
GROUP BY c.cpt_code
ORDER BY Avg_Charge DESC;


/* Q3. All procedures with patient name and encounter date */

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

SELECT 
    c.charge_id,
    i.amount_billed,
    i.amount_paid,
    ROUND(i.amount_billed - i.amount_paid, 2) AS Amount_Not_Paid
FROM charges c
JOIN insurance i ON c.charge_id = i.charge_id
ORDER BY c.charge_id;


/* Q2. % of claims paid < 80% by facility and provider */

SELECT
    e.facility_id,
    e.provider_id,
    ROUND(
        COUNT(CASE WHEN i.amount_paid / i.amount_billed < 0.8 THEN 1 END) * 1.0
        / COUNT(*), 2
    ) AS Low_Paid_Percentage
FROM encounters e
JOIN charges c ON c.encounter_id = e.encounter_id
JOIN insurance i ON i.charge_id = c.charge_id
GROUP BY e.facility_id, e.provider_id;


/* Q3. Average charge per encounter by encounter type */

SELECT
    e.encounter_type,
    ROUND(AVG(c.charge_amount), 2) AS Avg_Charge
FROM encounters e 
JOIN charges c ON c.encounter_id = e.encounter_id
GROUP BY e.encounter_type;


/* Q4. Total billed and paid per insurance provider */

SELECT
    ic.insurance_provider,
    SUM(ic.amount_billed) AS total_billed,
    SUM(ic.amount_paid) AS total_paid
FROM insurance ic
GROUP BY ic.insurance_provider;


/* Q5. All encounters with associated insurance claims (including encounters without claims) */

SELECT
    e.encounter_id,
    ic.claim_id
FROM encounters e
LEFT JOIN charges c 
    ON c.encounter_id = e.encounter_id
LEFT JOIN insurance ic 
    ON ic.charge_id = c.charge_id;
