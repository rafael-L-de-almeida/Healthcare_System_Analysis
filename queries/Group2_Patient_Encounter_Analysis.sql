/* =========================================================
   Group 2: Patient Encounter Frequency & Patterns
   ========================================================= */


/* ---------------------------------------------------------
   Q1. Which patients have had the highest number of
       encounters in the last 12 months?
   --------------------------------------------------------- */

SELECT
    p.full_name AS Patient,           -- TEXT
    COUNT(*) AS Nr_of_Encounters      -- NUMBER
FROM patients p
JOIN encounters e
    ON e.patient_id = p.patient_id
WHERE
    e.encounter_date >= date('now', '-12 months')  -- DATE filter
GROUP BY
    p.patient_id,
    p.full_name
ORDER BY
    Nr_of_Encounters DESC
LIMIT 10;                             -- NUMBER


/* ---------------------------------------------------------
   Q2. Which patients have more than one encounter,
       all in the same facility?
   --------------------------------------------------------- */

SELECT
    p.patient_id,                     -- NUMBER
    p.full_name,                      -- TEXT
    MIN(f.facility_id) AS facility_id -- NUMBER (single facility)
FROM patients p
JOIN encounters e
    ON p.patient_id = e.patient_id
JOIN facilities f
    ON f.facility_id = e.facility_id
GROUP BY
    p.patient_id,
    p.full_name
HAVING
    COUNT(DISTINCT f.facility_id) = 1 -- NUMBER condition
ORDER BY
    p.full_name;                      -- TEXT


/* ---------------------------------------------------------
   Q3. Which patients were treated by more than one
       medical specialty?
   --------------------------------------------------------- */

SELECT
    p.patient_id,                     -- NUMBER
    p.full_name,                      -- TEXT
    pr.specialty                      -- TEXT
FROM patients p
JOIN encounters e
    ON p.patient_id = e.patient_id
JOIN providers pr
    ON pr.provider_id = e.provider_id
WHERE
    p.patient_id IN (
        SELECT
            e.patient_id              -- NUMBER
        FROM encounters e
        JOIN providers pr
            ON pr.provider_id = e.provider_id
        GROUP BY
            e.patient_id
        HAVING
            COUNT(DISTINCT pr.specialty) > 1 -- NUMBER
    )
ORDER BY
    p.patient_id,
    pr.specialty;


/* ---------------------------------------------------------
   Q4. Which providers have the highest rate
       of repeat patients?
   --------------------------------------------------------- */

SELECT
    pr.full_name AS Provider,          -- TEXT
    COUNT(e.encounter_id) AS Encounters,          -- NUMBER
    COUNT(DISTINCT e.patient_id) AS NumberOfPatients, -- NUMBER
    ROUND(
        (COUNT(e.encounter_id) - COUNT(DISTINCT e.patient_id)) * 100.0
        / COUNT(DISTINCT e.patient_id),
        2
    ) AS RepetitionRate                -- NUMBER (percentage)
FROM encounters e
JOIN providers pr
    ON pr.provider_id = e.provider_id
GROUP BY
    pr.provider_id,
    pr.full_name
ORDER BY
    RepetitionRate DESC;


/* ---------------------------------------------------------
   Q5. How many encounters has each patient had?
   --------------------------------------------------------- */

SELECT
    e.patient_id,                     -- NUMBER
    COUNT(e.encounter_id) AS encounter_count -- NUMBER
FROM encounters e
GROUP BY
    e.patient_id;


/* ---------------------------------------------------------
   Q6. Which patients have had more than
       three encounters?
   --------------------------------------------------------- */

SELECT
    e.patient_id,                     -- NUMBER
    COUNT(e.encounter_id) AS encounter_count -- NUMBER
FROM encounters e
GROUP BY
    e.patient_id
HAVING
    COUNT(e.encounter_id) > 3;        -- NUMBER


/* ---------------------------------------------------------
   Q7. For each patient, rank their encounters
       from most recent to oldest.
   --------------------------------------------------------- */

SELECT
    e.patient_id,                     -- NUMBER
    e.encounter_date,                 -- DATE
    ROW_NUMBER() OVER (
        PARTITION BY e.patient_id
        ORDER BY e.encounter_date DESC
    ) AS ranking                      -- NUMBER
FROM encounters e;


/* ---------------------------------------------------------
   Q8. Show the most recent encounter per patient.
   --------------------------------------------------------- */

SELECT
    patient_id,                       -- NUMBER
    encounter_date                    -- DATE
FROM (
    SELECT
        e.patient_id,
        e.encounter_date,
        ROW_NUMBER() OVER (
            PARTITION BY e.patient_id
            ORDER BY e.encounter_date DESC
        ) AS ranking                  -- NUMBER
    FROM encounters e
) t
WHERE
    ranking = 1;                      -- NUMBER


/* ---------------------------------------------------------
   Q9. For each patient, compare the current
       encounter date with the previous encounter date.
   --------------------------------------------------------- */

SELECT
    e.patient_id,                     -- NUMBER
    e.encounter_date,                 -- DATE
    LAG(e.encounter_date) OVER (
        PARTITION BY e.patient_id
        ORDER BY e.encounter_date
    ) AS previous_encounter_date      -- DATE
FROM encounters e;


/* ---------------------------------------------------------
   Q10. Find patients with multiple encounters
        and list their names and total encounters.
   --------------------------------------------------------- */

WITH CTE_Multiple_Encounters AS (
    SELECT
        e.patient_id,                 -- NUMBER
        COUNT(e.encounter_id) AS encounter_count -- NUMBER
    FROM encounters e
    GROUP BY
        e.patient_id
    HAVING
        COUNT(e.encounter_id) > 1     -- NUMBER
)
SELECT
    p.patient_id,                     -- NUMBER
    p.full_name,                      -- TEXT
    m.encounter_count                 -- NUMBER
FROM CTE_Multiple_Encounters m
JOIN patients p
    ON p.patient_id = m.patient_id
ORDER BY
    m.encounter_count DESC;


/* ---------------------------------------------------------
   Q11. Which patients have had at least one encounter
        at a hospital-type facility?
   --------------------------------------------------------- */

SELECT DISTINCT
    e.patient_id                      -- NUMBER
FROM encounters e
JOIN facilities f
    ON f.facility_id = e.facility_id
WHERE
    f.facility_type = 'Hospital';     -- TEXT
