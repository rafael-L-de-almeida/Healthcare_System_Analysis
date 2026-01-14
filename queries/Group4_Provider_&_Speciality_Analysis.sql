/* =========================================================
   Group 4: Provider & Specialty Analysis
   ========================================================= */


/* ---------------------------------------------------------
   Q1. What is the average number of encounters per provider
       per month, segmented by specialty?
   --------------------------------------------------------- */

SELECT
    strftime('%m', e.encounter_date) AS month, -- TEXT (MM)
    pr.specialty,                              -- TEXT
    COUNT(*) AS total_encounters,              -- NUMBER
    COUNT(DISTINCT e.provider_id) AS total_providers, -- NUMBER
    ROUND(
        COUNT(*) * 1.0 / COUNT(DISTINCT e.provider_id),
        2
    ) AS avg_per_provider                      -- NUMBER
FROM encounters e
JOIN providers pr
    ON pr.provider_id = e.provider_id
GROUP BY
    month,
    pr.specialty
ORDER BY
    month,
    pr.specialty;


/* ---------------------------------------------------------
   Q2. Which specialties generate the highest
       billing amounts?
   --------------------------------------------------------- */

SELECT
    pr.specialty,                              -- TEXT
    ROUND(AVG(c.charge_amount), 2) AS Average_Charged_Amount -- NUMBER
FROM encounters e
JOIN charges c
    ON c.encounter_id = e.encounter_id
JOIN providers pr
    ON pr.provider_id = e.provider_id
GROUP BY
    pr.specialty
ORDER BY
    Average_Charged_Amount DESC;


/* ---------------------------------------------------------
   Q3. Show all providers whose specialty
       is "Cardiology".
   --------------------------------------------------------- */

SELECT
    pr.*                                      -- MIXED
FROM providers pr
WHERE
    pr.specialty = 'Cardiology';              -- TEXT


/* ---------------------------------------------------------
   Q4. List all providers and the encounters
       they handled, including providers
       with zero encounters.
   --------------------------------------------------------- */

SELECT
    pr.provider_id,                           -- NUMBER
    e.encounter_id                            -- NUMBER (NULL if none)
FROM providers pr
LEFT JOIN encounters e
    ON e.provider_id = pr.provider_id;


/* ---------------------------------------------------------
   Q5. Rank providers based on the number
       of encounters they handled.
   --------------------------------------------------------- */

SELECT
    provider_id,                              -- NUMBER
    encounter_count,                          -- NUMBER
    DENSE_RANK() OVER (
        ORDER BY encounter_count DESC
    ) AS rank                                 -- NUMBER
FROM (
    SELECT
        e.provider_id,                        -- NUMBER
        COUNT(e.encounter_id) AS encounter_count -- NUMBER
    FROM encounters e
    GROUP BY
        e.provider_id
) t;
