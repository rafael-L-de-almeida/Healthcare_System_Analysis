/* ============================================================
   This script standardizes recreates tables with proper foreign 
   keys to ensure consistency and maintain referential integrity.
============================================================ */ 

/* --------------------------
   1. Charges Table
-------------------------- */

CREATE TABLE charges_clean (
    charge_id TEXT PRIMARY KEY,
    encounter_id TEXT,
    cpt_code INTEGER,
    charge_amount DECIMAL(10,2),
    
    FOREIGN KEY (encounter_id)
        REFERENCES encounters(encounter_id)
);

INSERT INTO charges_clean 
SELECT
    CAST(charge_id AS TEXT),
    CAST(encounter_id AS TEXT),
    CAST(cpt_code AS INTEGER),
    ROUND(CAST(charge_amount AS DECIMAL(10,2)), 2)
FROM charges;

DROP TABLE charges;
ALTER TABLE charges_clean RENAME TO charges;

/* --------------------------
   2. Encounters Table
-------------------------- */
CREATE TABLE encounters_clean (
    encounter_id TEXT PRIMARY KEY,
    patient_id TEXT,
    provider_id TEXT,
    facility_id TEXT,
    encounter_date TEXT,
    encounter_type TEXT,
    
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id),
    FOREIGN KEY (facility_id) REFERENCES facilities(facility_id)
);

INSERT INTO encounters_clean 
SELECT
    CAST(encounter_id AS TEXT),
    CAST(patient_id AS TEXT),
    CAST(provider_id AS TEXT),
    CAST(facility_id AS TEXT),
    CAST(encounter_date AS TEXT),
    CAST(encounter_type AS TEXT)
FROM encounters;

DROP TABLE encounters;
ALTER TABLE encounters_clean RENAME TO encounters;

/* --------------------------
   3. Facilities Table
-------------------------- */
CREATE TABLE facilities_clean (
    facility_id TEXT PRIMARY KEY,
    facility_name TEXT,
    facility_type TEXT
);

INSERT INTO facilities_clean
SELECT
    CAST(facility_id AS TEXT),
    CAST(facility_name AS TEXT),
    CAST(facility_type AS TEXT)
FROM facilities;

DROP TABLE facilities;
ALTER TABLE facilities_clean RENAME TO facilities;

/* --------------------------
   4. Insurance Claims Table
-------------------------- */
CREATE TABLE insurance_claims_clean (
    claim_id TEXT,
    charge_id TEXT,
    insurance_provider TEXT,
    amount_billed DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    status TEXT,
  
    FOREIGN KEY (charge_id) REFERENCES charges(charge_id)
);

INSERT INTO insurance_claims_clean
SELECT
    CAST(claim_id AS TEXT),
    CAST(charge_id AS TEXT),
    CAST(insurance_provider AS TEXT),
    ROUND(CAST(amount_billed AS DECIMAL(10,2)), 2),
    ROUND(CAST(amount_paid AS DECIMAL(10,2)), 2),
    CAST(status AS TEXT)
FROM insurance;

DROP TABLE insurance;
ALTER TABLE insurance_claims_clean RENAME TO insurance;

/* --------------------------
   5. Patients Table
-------------------------- */
CREATE TABLE patients_clean (
    patient_id TEXT PRIMARY KEY,
    full_name TEXT,
    date_of_birth TEXT,
    gender TEXT,
    blood_type TEXT
);

INSERT INTO patients_clean
SELECT
    CAST(patient_id AS TEXT),
    CAST(full_name AS TEXT),
    CAST(date_of_birth AS TEXT),
    CAST(gender AS TEXT),
    CAST(blood_type AS TEXT)
FROM patients;

DROP TABLE patients;
ALTER TABLE patients_clean RENAME TO patients;

/* --------------------------
   6. Patient Contacts Table
-------------------------- */
CREATE TABLE patient_contacts_clean (
    contact_id TEXT PRIMARY KEY,
    patient_id TEXT,
    address TEXT,
    phone TEXT,
    email TEXT,
    
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

INSERT INTO patient_contacts_clean
SELECT
    CAST(contact_id AS TEXT),
    CAST(patient_id AS TEXT),
    CAST(address AS TEXT),
    CAST(phone AS TEXT),
    CAST(email AS TEXT)
FROM patient_contacts;

DROP TABLE patient_contacts;
ALTER TABLE patient_contacts_clean RENAME TO patient_contacts;

/* --------------------------
   7. Pharmacies Table
-------------------------- */
CREATE TABLE pharmacies_clean (
    pharmacy_id TEXT PRIMARY KEY,
    pharmacy_name TEXT
);

INSERT INTO pharmacies_clean
SELECT
    CAST(pharmacy_id AS TEXT),
    CAST(pharmacy_name AS TEXT)
FROM pharmacies;

DROP TABLE pharmacies;
ALTER TABLE pharmacies_clean RENAME TO pharmacies;

/* --------------------------
   8. Prescriptions Table
-------------------------- */
CREATE TABLE prescriptions_clean (
    prescription_id TEXT PRIMARY KEY,
    encounter_id TEXT,
    medication_id TEXT,
    pharmacy_id TEXT,
    date_prescribed TEXT,
    quantity INTEGER,
    refills INTEGER,
    
    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id)
);

INSERT INTO prescriptions_clean
SELECT
    CAST(prescription_id AS TEXT),
    CAST(encounter_id AS TEXT),
    CAST(medication_id AS TEXT),
    CAST(pharmacy_id AS TEXT),
    CAST(date_prescribed AS TEXT),
    CAST(quantity AS INTEGER),
    CAST(refills AS INTEGER)
FROM prescriptions;

DROP TABLE prescriptions;
ALTER TABLE prescriptions_clean RENAME TO prescriptions;

/* --------------------------
   9. Procedures Table
-------------------------- */
CREATE TABLE procedures_clean (
    procedure_id TEXT PRIMARY KEY,
    encounter_id TEXT,
    cpt_code INTEGER,
    procedure_description TEXT,
    
    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
);

INSERT INTO procedures_clean
SELECT
    CAST(procedure_id AS TEXT),
    CAST(encounter_id AS TEXT),
    CAST(cpt_code AS INTEGER),
    CAST(procedure_description AS TEXT)
FROM procedures;

DROP TABLE procedures;
ALTER TABLE procedures_clean RENAME TO procedures;

/* --------------------------
   10. Providers Table
-------------------------- */
CREATE TABLE providers_clean (
    provider_id TEXT PRIMARY KEY,
    full_name TEXT,
    specialty TEXT
);

INSERT INTO providers_clean
SELECT
    CAST(provider_id AS TEXT),
    CAST(full_name AS TEXT),
    CAST(specialty AS TEXT)
FROM providers;

DROP TABLE providers;
ALTER TABLE providers_clean RENAME TO providers;

/* --------------------------
   11. Vitals Table
-------------------------- */
CREATE TABLE vitals_clean (
    vital_id TEXT PRIMARY KEY,
    encounter_id TEXT,
    systolic_bp INTEGER,
    diastolic_bp INTEGER,
    heart_rate INTEGER,
    temperature_f DECIMAL(10,2),
  
    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
);

INSERT INTO vitals_clean
SELECT
    CAST(vital_id AS TEXT),
    CAST(encounter_id AS TEXT),
    CAST(systolic_bp AS INTEGER),
    CAST(diastolic_bp AS INTEGER),
    CAST(heart_rate AS INTEGER),
    CAST(temperature_f AS DECIMAL(10,2))
FROM vitals;

DROP TABLE vitals;
ALTER TABLE vitals_clean RENAME TO vitals;

