/* =========================================================
   Group 1: Patient Demographics & Contact Info Anasylis
   ========================================================= */

/* ---------------------------------------------------------
   Q1. What is the age distribution of patients
       by gender and blood type?
   --------------------------------------------------------- */

SELECT
    p.gender AS Gender,              -- TEXT
    p.blood_type AS Blood_Type,      -- TEXT

    /* Average age (NUMBER) */
    ROUND(
        AVG(
            strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
            - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
        ),
        2
    ) AS Age_AVG,                    -- NUMBER

    /* Minimum age (NUMBER) */
    MIN(
        strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
        - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
    ) AS Age_MIN,                    -- NUMBER

    /* Maximum age (NUMBER) */
    MAX(
        strftime('%Y', 'now') - strftime('%Y', p.date_of_birth)
        - (strftime('%m-%d', 'now') < strftime('%m-%d', p.date_of_birth))
    ) AS Age_MAX,                    -- NUMBER

    COUNT(*) AS Total                -- NUMBER
FROM patients p
GROUP BY
    p.gender,
    p.blood_type;


/* ---------------------------------------------------------
   Q2. What patients have missing contact information
       (phone or email)?
   --------------------------------------------------------- */

SELECT
    p.patient_id,                    -- NUMBER
    pc.email,                        -- TEXT
    pc.phone                         -- TEXT
FROM patients p
LEFT JOIN patient_contacts pc
    ON p.patient_id = pc.patient_id
WHERE
    pc.email IS NULL                 -- NULL check
    OR pc.phone IS NULL;             -- NULL check


/* ---------------------------------------------------------
   Q3. What is the average systolic and diastolic blood
       pressure by age group and blood type?
   --------------------------------------------------------- */

SELECT
    CASE
        WHEN strftime('%Y', 'now') - strftime('%Y', p.date_of_birth) <= 30
            THEN 'Young'              -- TEXT
        WHEN strftime('%Y', 'now') - strftime('%Y', p.date_of_birth) BETWEEN 31 AND 60
            THEN 'Adult'              -- TEXT
        ELSE 'Elderly'                -- TEXT
    END AS AgeClassification,         -- TEXT

    p.blood_type,                     -- TEXT

    ROUND(AVG(v.systolic_bp), 2) AS Avg_Systolic_BP,     -- NUMBER
    ROUND(AVG(v.diastolic_bp), 2) AS Avg_Diastolic_BP    -- NUMBER
FROM patients p
JOIN encounters e
    ON e.patient_id = p.patient_id
JOIN vitals v
    ON v.encounter_id = e.encounter_id
GROUP BY
    AgeClassification,
    p.blood_type
ORDER BY
    CASE AgeClassification
        WHEN 'Young' THEN 1           -- TEXT → ORDER INDEX (NUMBER)
        WHEN 'Adult' THEN 2
        WHEN 'Elderly' THEN 3
    END;


/* ---------------------------------------------------------
   Q4. List all patients with their date of birth
       and blood type, ordered by oldest first.
   --------------------------------------------------------- */

SELECT
    p.patient_id,                    -- NUMBER
    p.date_of_birth,                 -- DATE
    p.blood_type                     -- TEXT
FROM patients p
ORDER BY
    p.date_of_birth;                 -- DATE (oldest first)


/* ---------------------------------------------------------
   Q5. List all recorded vitals including patient name
       and encounter date.
   --------------------------------------------------------- */

SELECT
    v.vital_id,                      -- NUMBER
    p.full_name,                     -- TEXT
    e.encounter_date                 -- DATE
FROM vitals v
JOIN encounters e
    ON e.encounter_id = v.encounter_id
JOIN patients p
    ON p.patient_id = e.patient_id;
