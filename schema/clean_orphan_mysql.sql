/* =========================================================
                    DELETING ORPHAN FKs
   This script deletes orphaned records from multiple tables, 
   ensuring all references are linked.
============================================================ */ 
USE `proj_healthcare_analysis`;
SET SQL_SAFE_UPDATES = 0;

-- 1. patient_contacts → patients
DELETE pc
FROM patient_contacts pc
WHERE NOT EXISTS (
    SELECT 1
    FROM patients p
    WHERE p.patient_id = pc.patient_id
);

-- 2. encounters → patients
DELETE e
FROM encounters e
WHERE NOT EXISTS (
    SELECT 1
    FROM patients p
    WHERE p.patient_id = e.patient_id
);

-- 3. encounters → providers
DELETE e
FROM encounters e
WHERE NOT EXISTS (
    SELECT 1
    FROM providers pr
    WHERE pr.provider_id = e.provider_id
);

-- 4. encounters → facilities
DELETE e
FROM encounters e
WHERE NOT EXISTS (
    SELECT 1
    FROM facilities f
    WHERE f.facility_id = e.facility_id
);

-- 5. prescriptions → encounters
DELETE pr
FROM prescriptions pr
WHERE NOT EXISTS (
    SELECT 1
    FROM encounters e
    WHERE e.encounter_id = pr.encounter_id
);

-- 6. prescriptions → medications
DELETE pr
FROM prescriptions pr
WHERE NOT EXISTS (
    SELECT 1
    FROM medications m
    WHERE m.medication_id = pr.medication_id
);

-- 7. prescriptions → pharmacies
DELETE pr
FROM prescriptions pr
WHERE NOT EXISTS (
    SELECT 1
    FROM pharmacies ph
    WHERE ph.pharmacy_id = pr.pharmacy_id
);

-- 8. charges → encounters
DELETE c
FROM charges c
WHERE NOT EXISTS (
    SELECT 1
    FROM encounters e
    WHERE e.encounter_id = c.encounter_id
);

-- 9. insurance_claim → charges
DELETE i
FROM insurance_claims i
WHERE NOT EXISTS (
    SELECT 1
    FROM charges c
    WHERE c.charge_id = i.charge_id
);

-- 10. vitals → encounters
DELETE v
FROM vitals v
WHERE NOT EXISTS (
    SELECT 1
    FROM encounters e
    WHERE e.encounter_id = v.encounter_id
);

-- 11. procedures → encounters
DELETE prc
FROM procedures prc
WHERE NOT EXISTS (
    SELECT 1
    FROM encounters e
    WHERE e.encounter_id = prc.encounter_id
);

SET SQL_SAFE_UPDATES = 1;
