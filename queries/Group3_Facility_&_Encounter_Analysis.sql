/* =========================================================
   Group 3: Facility & Encounter Analysis
   ========================================================= */


/* ---------------------------------------------------------
   Q1. What is the monthly encounter volume in 2024
       by facility and encounter type?
   --------------------------------------------------------- */

SELECT
    f.facility_id,                         -- NUMBER
    e.encounter_type,                      -- TEXT
    strftime('%m', e.encounter_date) AS month, -- TEXT (MM)
    COUNT(*) AS encounter_count            -- NUMBER
FROM encounters e
JOIN facilities f
    ON f.facility_id = e.facility_id
WHERE
    strftime('%Y', e.encounter_date) = '2024'  -- TEXT (year)
GROUP BY
    f.facility_id,
    e.encounter_type,
    month
ORDER BY
    f.facility_id,
    e.encounter_type,
    month;


/* ---------------------------------------------------------
   Q2. What is the average number of encounters per patient
       by facility type?
   --------------------------------------------------------- */

SELECT
    t.facility_type,                       -- TEXT
    AVG(t.encounters_per_patient) AS avg_encounters -- NUMBER
FROM (
    SELECT
        f.facility_type,                   -- TEXT
        COUNT(e.encounter_id) AS encounters_per_patient -- NUMBER
    FROM patients p
    JOIN encounters e
        ON p.patient_id = e.patient_id
    JOIN facilities f
        ON f.facility_id = e.facility_id
    GROUP BY
        p.patient_id,
        f.facility_type
) t
GROUP BY
    t.facility_type;


/* ---------------------------------------------------------
   Q3. Which facilities have the highest patient
       revisit rate?
   --------------------------------------------------------- */

SELECT
    f.facility_name,                       -- TEXT
    (1 - (COUNT(DISTINCT e.patient_id) * 1.0
          / COUNT(e.patient_id))) * 100
        AS RevisitRate                     -- NUMBER (percentage)
FROM encounters e
JOIN facilities f
    ON f.facility_id = e.facility_id
GROUP BY
    f.facility_name
ORDER BY
    RevisitRate DESC;


/* ---------------------------------------------------------
   Q4. What is the rate of emergency cases per facility?
   --------------------------------------------------------- */

SELECT
    f.facility_name,                       -- TEXT
    ROUND(
        COUNT(
            CASE
                WHEN e.encounter_type = 'Emergency' THEN 1 -- TEXT
            END
        ) * 1.0
        / COUNT(e.encounter_id),
        2
    ) AS EmergencyRate                     -- NUMBER
FROM encounters e
JOIN facilities f
    ON f.facility_id = e.facility_id
GROUP BY
    f.facility_id,
    f.facility_name;


/* ---------------------------------------------------------
   Q5. What is the average heart rate per facility?
   --------------------------------------------------------- */

SELECT
    f.facility_name,                       -- TEXT
    ROUND(AVG(v.heart_rate), 2) AS Avg_Heart_Rate -- NUMBER
FROM facilities f
JOIN encounters e
    ON f.facility_id = e.facility_id
JOIN vitals v
    ON v.encounter_id = e.encounter_id
GROUP BY
    f.facility_name;


/* ---------------------------------------------------------
   Q6. Find all encounters that occurred in a
       specific year (example: 2024).
   --------------------------------------------------------- */

SELECT
    e.*                                   -- MIXED
FROM encounters e
WHERE
    e.encounter_date LIKE '2024%';        -- TEXT (YYYY prefix)


/* ---------------------------------------------------------
   Q7. List each encounter with the patient's
       full name and encounter date.
   --------------------------------------------------------- */

SELECT
    e.encounter_date,                     -- DATE
    p.full_name                           -- TEXT
FROM encounters e
JOIN patients p
    ON p.patient_id = e.patient_id;


/* ---------------------------------------------------------
   Q8. List all encounters with provider name
       and facility name.
   --------------------------------------------------------- */

SELECT
    e.encounter_date,                     -- DATE
    f.facility_name,                      -- TEXT
    pr.full_name AS provider_name         -- TEXT
FROM encounters e
JOIN facilities f
    ON f.facility_id = e.facility_id
JOIN providers pr
    ON pr.provider_id = e.provider_id;


/* ---------------------------------------------------------
   Q9. List encounters where the total billed amount
       is higher than the average billed amount
       across all encounters.
   --------------------------------------------------------- */

WITH CTE_AvgBilled AS (
    SELECT
        AVG(c.charge_amount) AS avg_billed -- NUMBER
    FROM charges c
)
SELECT
    e.encounter_id,                       -- NUMBER
    e.patient_id,                         -- NUMBER
    e.encounter_date,                     -- DATE
    SUM(c.charge_amount) AS total_billed  -- NUMBER
FROM encounters e
JOIN charges c
    ON c.encounter_id = e.encounter_id
GROUP BY
    e.encounter_id,
    e.patient_id,
    e.encounter_date
HAVING
    SUM(c.charge_amount) >
        (SELECT avg_billed FROM CTE_AvgBilled);


/* ---------------------------------------------------------
   Q10. Calculate the total billed amount per encounter
        and show only encounters where the total
        exceeds 200.
   --------------------------------------------------------- */

WITH CTE_TotalAmount AS (
    SELECT
        e.encounter_id,                   -- NUMBER
        SUM(c.charge_amount) AS total_billed -- NUMBER
    FROM encounters e
    JOIN charges c
        ON e.encounter_id = c.encounter_id
    GROUP BY
        e.encounter_id
)
SELECT
    *                                     -- MIXED
FROM CTE_TotalAmount
WHERE
    total_billed > 200;                   -- NUMBER
