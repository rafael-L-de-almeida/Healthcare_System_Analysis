/* =========================================================
   Group 7: Insurance & Billing
   ========================================================= */


/* ---------------------------------------------------------
   Q1. What are the billed amounts, paid amounts,
       and unpaid amounts per charge?
   --------------------------------------------------------- */

SELECT
    c.charge_id,                          -- NUMBER
    i.amount_billed,                     -- NUMBER
    i.amount_paid,                       -- NUMBER
    ROUND(
        i.amount_billed - i.amount_paid,
        2
    ) AS amount_not_paid                 -- NUMBER
FROM charges c
JOIN insurance i
    ON c.charge_id = i.charge_id
ORDER BY
    c.charge_id;


/* ---------------------------------------------------------
   Q2. For each facility and provider, what percentage
       of claims were paid at less than 80%
       of the billed amount?
   --------------------------------------------------------- */

SELECT
    e.facility_id,                       -- NUMBER
    e.provider_id,                       -- NUMBER
    ROUND(
        COUNT(
            CASE
                WHEN i.amount_paid * 1.0 / i.amount_billed < 0.8
                THEN 1
            END
        ) * 1.0
        / COUNT(*),
        2
    ) AS low_paid_percentage             -- NUMBER
FROM encounters e
JOIN charges c
    ON c.encounter_id = e.encounter_id
JOIN insurance i
    ON i.charge_id = c.charge_id
GROUP BY
    e.facility_id,
    e.provider_id;


/* ---------------------------------------------------------
   Q3. What is the average charge amount per encounter
       by encounter type?
   --------------------------------------------------------- */

SELECT
    e.encounter_type,                    -- TEXT
    ROUND(AVG(c.charge_amount), 2) AS avg_charge -- NUMBER
FROM encounters e
JOIN charges c
    ON c.encounter_id = e.encounter_id
GROUP BY
    e.encounter_type;


/* ---------------------------------------------------------
   Q4. What is the total amount billed and total amount
       paid per insurance provider?
   --------------------------------------------------------- */

SELECT
    ic.insurance_provider,               -- TEXT
    SUM(ic.amount_billed) AS total_billed, -- NUMBER
    SUM(ic.amount_paid) AS total_paid      -- NUMBER
FROM insurance ic
GROUP BY
    ic.insurance_provider;


/* ---------------------------------------------------------
   Q5. Show all encounters and any associated insurance
       claims, including encounters without claims.
   --------------------------------------------------------- */

SELECT
    e.encounter_id,                      -- NUMBER
    ic.claim_id                          -- NUMBER (NULL if none)
FROM encounters e
LEFT JOIN charges c
    ON c.encounter_id = e.encounter_id
LEFT JOIN insurance ic
    ON ic.charge_id = c.charge_id;
