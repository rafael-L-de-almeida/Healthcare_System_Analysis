/* The script below IDs NULL and duplicate*/
USE `proj_healthcare_analysis`;
SET SQL_SAFE_UPDATES = 0;
-- 1. charges
DELETE c
FROM charges c
JOIN (
    SELECT charge_id, ROW_NUMBER() OVER (PARTITION BY charge_id ORDER BY charge_id) AS rn
    FROM charges
) x ON c.charge_id = x.charge_id
WHERE x.rn > 1 OR c.charge_id IS NULL;

-- 2. encounters
DELETE e
FROM encounters e
JOIN (
    SELECT encounter_id, ROW_NUMBER() OVER (PARTITION BY encounter_id ORDER BY encounter_id) AS rn
    FROM encounters
) x ON e.encounter_id = x.encounter_id
WHERE x.rn > 1 OR e.encounter_id IS NULL;

-- 3. facilities
DELETE f
FROM facilities f
JOIN (
    SELECT facility_id, ROW_NUMBER() OVER (PARTITION BY facility_id ORDER BY facility_id) AS rn
    FROM facilities
) x ON f.facility_id = x.facility_id
WHERE x.rn > 1 OR f.facility_id IS NULL;

-- 4. insurance
DELETE i
FROM insurance_claims i
JOIN (
    SELECT claim_id, ROW_NUMBER() OVER (PARTITION BY claim_id ORDER BY claim_id) AS rn
    FROM insurance_claims
) x ON i.claim_id = x.claim_id
WHERE x.rn > 1 OR i.claim_id IS NULL;

-- 5. medications
DELETE m
FROM medications m
JOIN (
    SELECT medication_id, ROW_NUMBER() OVER (PARTITION BY medication_id ORDER BY medication_id) AS rn
    FROM medications
) x ON m.medication_id = x.medication_id
WHERE x.rn > 1 OR m.medication_id IS NULL;

-- 6. patients
DELETE p
FROM patients p
JOIN (
    SELECT patient_id, ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY patient_id) AS rn
    FROM patients
) x ON p.patient_id = x.patient_id
WHERE x.rn > 1 OR p.patient_id IS NULL;

-- 7. patient_contacts
DELETE pc
FROM patient_contacts pc
JOIN (
    SELECT patient_id, ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY patient_id) AS rn
    FROM patient_contacts
) x ON pc.patient_id = x.patient_id
WHERE x.rn > 1 OR pc.patient_id IS NULL;

-- 8. pharmacies
DELETE ph
FROM pharmacies ph
JOIN (
    SELECT pharmacy_id, ROW_NUMBER() OVER (PARTITION BY pharmacy_id ORDER BY pharmacy_id) AS rn
    FROM pharmacies
) x ON ph.pharmacy_id = x.pharmacy_id
WHERE x.rn > 1 OR ph.pharmacy_id IS NULL;

-- 9. prescriptions
DELETE pr
FROM prescriptions pr
JOIN (
    SELECT prescription_id, ROW_NUMBER() OVER (PARTITION BY prescription_id ORDER BY prescription_id) AS rn
    FROM prescriptions
) x ON pr.prescription_id = x.prescription_id
WHERE x.rn > 1 OR pr.prescription_id IS NULL;

-- 10. procedures
DELETE prc
FROM procedures prc
JOIN (
    SELECT procedure_id, ROW_NUMBER() OVER (PARTITION BY procedure_id ORDER BY procedure_id) AS rn
    FROM procedures
) x ON prc.procedure_id = x.procedure_id
WHERE x.rn > 1 OR prc.procedure_id IS NULL;

-- 11. providers
DELETE pr
FROM providers pr
JOIN (
    SELECT provider_id, ROW_NUMBER() OVER (PARTITION BY provider_id ORDER BY provider_id) AS rn
    FROM providers
) x ON pr.provider_id = x.provider_id
WHERE x.rn > 1 OR pr.provider_id IS NULL;

-- 12. vitals
DELETE v
FROM vitals v
JOIN (
    SELECT vital_id, ROW_NUMBER() OVER (PARTITION BY vital_id ORDER BY vital_id) AS rn
    FROM vitals
) x ON v.vital_id = x.vital_id
WHERE x.rn > 1 OR v.vital_id IS NULL;

-- 13. diagnoses
DELETE d
FROM diagnoses d
JOIN (
    SELECT diagnosis_id, ROW_NUMBER() OVER (PARTITION BY diagnosis_id ORDER BY diagnosis_id) AS rn
    FROM diagnoses
) x ON d.diagnosis_id = x.diagnosis_id
WHERE x.rn > 1 OR d.diagnosis_id IS NULL;


SET SQL_SAFE_UPDATES = 1;