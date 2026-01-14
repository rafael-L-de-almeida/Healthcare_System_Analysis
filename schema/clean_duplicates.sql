/* The script below IDs NULL and duplicate*/

---- 1. CHARGES
DELETE FROM charges
WHERE charge_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM charges
       GROUP BY charge_id
   );

-- 2. ENCOUNTERS
DELETE FROM encounters
WHERE encounter_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM encounters
       GROUP BY encounter_id
   );

-- 3. FACILITIES
DELETE FROM facilities
WHERE facility_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM facilities
       GROUP BY facility_id
   );

-- 4. INSURANCE_CLAIM
DELETE FROM insurance
WHERE claim_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM insurance
       GROUP BY claim_id
   );

-- 5. MEDICATIONS
DELETE FROM medications
WHERE medication_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM medications
       GROUP BY medication_id
   );

-- 6. PATIENTS
DELETE FROM patients
WHERE patient_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM patients
       GROUP BY patient_id
   );

-- 7. PATIENT_CONTACTS
DELETE FROM patient_contacts
WHERE patient_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM patient_contacts
       GROUP BY patient_id
   );

-- 8. PHARMACIES
DELETE FROM pharmacies
WHERE pharmacy_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM pharmacies
       GROUP BY pharmacy_id
   );

-- 9. PRESCRIPTIONS
DELETE FROM prescriptions
WHERE prescription_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM prescriptions
       GROUP BY prescription_id
   );

-- 10. PROCEDURES
DELETE FROM procedures
WHERE procedure_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM procedures
       GROUP BY procedure_id
   );

-- 11. PROVIDERS
DELETE FROM providers
WHERE provider_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM providers
       GROUP BY provider_id
   );

-- 12. VITALS
DELETE FROM vitals
WHERE vital_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM vitals
       GROUP BY vital_id
   );

-- 13. DIAGNOSES
DELETE FROM diagnoses
WHERE diagnosis_id IS NULL
   OR rowid NOT IN (
       SELECT MIN(rowid)
       FROM diagnoses
       GROUP BY diagnosis_id
   );
