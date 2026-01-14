/* =========================================================
   Group 5: Prescriptions & Pharmacies
   ========================================================= */


/* ---------------------------------------------------------
   Q1. Which pharmacies have filled more than
       10 prescriptions?
   --------------------------------------------------------- */

SELECT
    pr.pharmacy_id,                       -- NUMBER
    COUNT(pr.prescription_id) AS prescription_count -- NUMBER
FROM prescriptions pr
GROUP BY
    pr.pharmacy_id
HAVING
    COUNT(pr.prescription_id) > 10;       -- NUMBER


/* ---------------------------------------------------------
   Q2. What are the most prescribed medications
       by month and facility?
   --------------------------------------------------------- */

SELECT
    f.facility_name,                      -- TEXT
    strftime('%Y-%m', e.encounter_date) AS year_month, -- TEXT (YYYY-MM)
    m.medication_name                     -- TEXT
FROM prescriptions p
JOIN encounters e
    ON e.encounter_id = p.encounter_id
JOIN facilities f
    ON f.facility_id = e.facility_id
JOIN medications m
    ON p.medication_id = m.medication_id
GROUP BY
    f.facility_name,
    year_month,
    m.medication_name,
    p.medication_id
HAVING
    COUNT(*) = (
        SELECT
            MAX(med_count)                -- NUMBER
        FROM (
            SELECT
                COUNT(*) AS med_count     -- NUMBER
            FROM prescriptions p2
            JOIN encounters e2
                ON e2.encounter_id = p2.encounter_id
            JOIN facilities f2
                ON f2.facility_id = e2.facility_id
            WHERE
                f2.facility_id = f.facility_id
                AND strftime('%Y-%m', e2.encounter_date)
                    = strftime('%Y-%m', e.encounter_date)
            GROUP BY
                p2.medication_id
        )
    )
ORDER BY
    f.facility_name,
    year_month;


/* ---------------------------------------------------------
   Q3. Retrieve all prescriptions with a quantity
       greater than 30.
   --------------------------------------------------------- */

SELECT
    ps.*                                 -- MIXED
FROM prescriptions ps
WHERE
    ps.quantity > 30;                   -- NUMBER


/* ---------------------------------------------------------
   Q4. Show all prescriptions with the medication
       name and pharmacy name.
   --------------------------------------------------------- */

SELECT
    ps.prescription_id,                 -- NUMBER
    m.medication_name,                  -- TEXT
    ph.pharmacy_name                    -- TEXT
FROM prescriptions ps
JOIN medications m
    ON m.medication_id = ps.medication_id
JOIN pharmacies ph
    ON ph.pharmacy_id = ps.pharmacy_id;


/* ---------------------------------------------------------
   Q5. List all pharmacies and the prescriptions
       filled there, including pharmacies
       with no prescriptions.
   --------------------------------------------------------- */

SELECT
    ph.pharmacy_id,                     -- NUMBER
    pr.medication_id                    -- NUMBER (NULL if none)
FROM pharmacies ph
LEFT JOIN prescriptions pr
    ON pr.pharmacy_id = ph.pharmacy_id;
