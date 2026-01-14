/* =========================================================
                    DELETING ORPHAN FKs
   This script deletes orphaned records from multiple tables, 
   ensuring all references are linked.
============================================================ */ 

-- 1. patients_contacts → patients
DELETE FROM patient_contacts
WHERE patient_id NOT IN (SELECT patient_id FROM patients);

-- 2. encounters → patients
DELETE FROM encounters
WHERE patient_id NOT IN (SELECT patient_id FROM patients);

-- 3. encounters → providers
DELETE FROM encounters
WHERE provider_id NOT IN (SELECT provider_id FROM providers);

-- 4. encounters → facilities
DELETE FROM encounters
WHERE facility_id NOT IN (SELECT facility_id FROM facilities);

-- 5. prescriptions → encounters
DELETE FROM prescriptions
WHERE encounter_id NOT IN (SELECT encounter_id FROM encounters);

-- 6. prescriptions → medications
DELETE FROM prescriptions
WHERE medication_id NOT IN (SELECT medication_id FROM medications);

-- 7. prescriptions → pharmacies
DELETE FROM prescriptions
WHERE pharmacy_id NOT IN (SELECT pharmacy_id FROM pharmacies);

-- 8. charges → encounters
DELETE FROM charges
WHERE encounter_id NOT IN (SELECT encounter_id FROM encounters);

-- 9. insurance_claim → charges
DELETE FROM insurance
WHERE charge_id NOT IN (SELECT charge_id FROM charges);

-- 10. vitals → encounters
DELETE FROM vitals
WHERE encounter_id NOT IN (SELECT encounter_id FROM encounters);

-- 11. procedures → encounters
DELETE FROM procedures
WHERE encounter_id NOT IN (SELECT encounter_id FROM encounters);

