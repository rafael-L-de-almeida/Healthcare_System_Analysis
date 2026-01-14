/* =========================================================
   Group 6: Diagnoses & Procedures
   ========================================================= */


/* ---------------------------------------------------------
   Q1. Which diagnoses are most commonly associated
       with pre-hypertension
       (systolic blood pressure > 120)?
   --------------------------------------------------------- */

SELECT
    d.diagnosis_description,            -- TEXT
    COUNT(*) AS recurrence_of_symptoms  -- NUMBER
FROM diagnoses d
JOIN encounters e
    ON d.encounter_id = e.encounter_id
JOIN vitals v
    ON v.encounter_id = e.encounter_id
WHERE
    v.systolic_bp > 120                 -- NUMBER (threshold)
GROUP BY
    d.diagnosis_description
ORDER BY
    recurrence_of_symptoms DESC;


/* ---------------------------------------------------------
   Q2. Which CPT code generates the highest
       average revenue?
   --------------------------------------------------------- */

SELECT
    c.cpt_code,                         -- TEXT
    ROUND(AVG(c.charge_amount), 2) AS avg_charge -- NUMBER
FROM charges c
GROUP BY
    c.cpt_code
ORDER BY
    avg_charge DESC;


/* ---------------------------------------------------------
   Q3. List all procedures performed, including
       the patient name and encounter date.
   --------------------------------------------------------- */

SELECT
    prc.procedure_id,                   -- NUMBER
    p.full_name,                        -- TEXT
    e.encounter_date                    -- DATE
FROM procedures prc
JOIN encounters e
    ON e.encounter_id = prc.encounter_id
JOIN patients p
    ON p.patient_id = e.patient_id;
