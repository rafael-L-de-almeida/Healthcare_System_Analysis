USE `proj_healthcare_analysis`;

/* ============================================================
   FULL DATABASE STANDARDIZATION SCRIPT (MySQL)
   Recreates tables with proper foreign keys
============================================================ */

SET FOREIGN_KEY_CHECKS = 0;

/* ------------------------------------------------------------
   1. Patients
------------------------------------------------------------ */
CREATE TABLE patients_clean (
    patient_id VARCHAR(36) PRIMARY KEY,
    full_name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(20),
    blood_type VARCHAR(5)
) ENGINE=InnoDB;

INSERT INTO patients_clean
SELECT patient_id, full_name, date_of_birth, gender, blood_type
FROM patients;

DROP TABLE patients;
ALTER TABLE patients_clean RENAME TO patients;

/* ------------------------------------------------------------
   2. Providers
------------------------------------------------------------ */
CREATE TABLE providers_clean (
    provider_id VARCHAR(36) PRIMARY KEY,
    full_name VARCHAR(255),
    specialty VARCHAR(100)
) ENGINE=InnoDB;

INSERT INTO providers_clean
SELECT provider_id, full_name, specialty
FROM providers;

DROP TABLE providers;
ALTER TABLE providers_clean RENAME TO providers;

/* ------------------------------------------------------------
   3. Facilities
------------------------------------------------------------ */
CREATE TABLE facilities_clean (
    facility_id VARCHAR(36) PRIMARY KEY,
    facility_name VARCHAR(255),
    facility_type VARCHAR(100)
) ENGINE=InnoDB;

INSERT INTO facilities_clean
SELECT facility_id, facility_name, facility_type
FROM facilities;

DROP TABLE facilities;
ALTER TABLE facilities_clean RENAME TO facilities;

/* ------------------------------------------------------------
   4. Medications
------------------------------------------------------------ */
CREATE TABLE medications_clean (
    medication_id VARCHAR(36) PRIMARY KEY,
    medication_name VARCHAR(255)
) ENGINE=InnoDB;

INSERT INTO medications_clean
SELECT medication_id, medication_name
FROM medications;

DROP TABLE medications;
ALTER TABLE medications_clean RENAME TO medications;

/* ------------------------------------------------------------
   5. Encounters
------------------------------------------------------------ */
CREATE TABLE encounters_clean (
    encounter_id VARCHAR(36) PRIMARY KEY,
    patient_id VARCHAR(36),
    provider_id VARCHAR(36),
    facility_id VARCHAR(36),
    encounter_date DATE,
    encounter_type VARCHAR(100),

    FOREIGN KEY (patient_id)  REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id),
    FOREIGN KEY (facility_id) REFERENCES facilities(facility_id)
) ENGINE=InnoDB;

INSERT INTO encounters_clean
SELECT
    encounter_id,
    patient_id,
    provider_id,
    facility_id,
    encounter_date,
    encounter_type
FROM encounters;

DROP TABLE encounters;
ALTER TABLE encounters_clean RENAME TO encounters;

/* ------------------------------------------------------------
   6. Charges
------------------------------------------------------------ */
CREATE TABLE charges_clean (
    charge_id VARCHAR(36) PRIMARY KEY,
    encounter_id VARCHAR(36),
    cpt_code INT,
    charge_amount DECIMAL(10,2),

    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
) ENGINE=InnoDB;

INSERT INTO charges_clean
SELECT
    charge_id,
    encounter_id,
    cpt_code,
    ROUND(charge_amount, 2)
FROM charges;

DROP TABLE charges;
ALTER TABLE charges_clean RENAME TO charges;

/* ------------------------------------------------------------
   7. Insurance Claims
------------------------------------------------------------ */
CREATE TABLE insurance_claims_clean (
    claim_id VARCHAR(36) PRIMARY KEY,
    charge_id VARCHAR(36),
    insurance_provider VARCHAR(255),
    amount_billed DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    status VARCHAR(50),

    FOREIGN KEY (charge_id) REFERENCES charges(charge_id)
) ENGINE=InnoDB;

INSERT INTO insurance_claims_clean
SELECT
    claim_id,
    charge_id,
    insurance_provider,
    ROUND(amount_billed, 2),
    ROUND(amount_paid, 2),
    status
FROM insurance_claims;

DROP TABLE insurance_claims;
ALTER TABLE insurance_claims_clean RENAME TO insurance_claims;

/* ------------------------------------------------------------
   8. Patient Contacts
------------------------------------------------------------ */
CREATE TABLE patient_contacts_clean (
    contact_id VARCHAR(36) PRIMARY KEY,
    patient_id VARCHAR(36),
    address VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
) ENGINE=InnoDB;

INSERT INTO patient_contacts_clean
SELECT
    contact_id,
    patient_id,
    address,
    phone,
    email
FROM patient_contacts;

DROP TABLE patient_contacts;
ALTER TABLE patient_contacts_clean RENAME TO patient_contacts;

/* ------------------------------------------------------------
   9. Pharmacies
------------------------------------------------------------ */
CREATE TABLE pharmacies_clean (
    pharmacy_id VARCHAR(36) PRIMARY KEY,
    pharmacy_name VARCHAR(255)
) ENGINE=InnoDB;

INSERT INTO pharmacies_clean
SELECT pharmacy_id, pharmacy_name
FROM pharmacies;

DROP TABLE pharmacies;
ALTER TABLE pharmacies_clean RENAME TO pharmacies;

/* ------------------------------------------------------------
   10. Prescriptions
------------------------------------------------------------ */
CREATE TABLE prescriptions_clean (
    prescription_id VARCHAR(36) PRIMARY KEY,
    encounter_id VARCHAR(36),
    medication_id VARCHAR(36),
    pharmacy_id VARCHAR(36),
    date_prescribed DATE,
    quantity INT,
    refills INT,

    FOREIGN KEY (encounter_id)  REFERENCES encounters(encounter_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
    FOREIGN KEY (pharmacy_id)   REFERENCES pharmacies(pharmacy_id)
) ENGINE=InnoDB;

INSERT INTO prescriptions_clean
SELECT
    prescription_id,
    encounter_id,
    medication_id,
    pharmacy_id,
    date_prescribed,
    quantity,
    refills
FROM prescriptions;

DROP TABLE prescriptions;
ALTER TABLE prescriptions_clean RENAME TO prescriptions;

/* ------------------------------------------------------------
   11. Procedures
------------------------------------------------------------ */
CREATE TABLE procedures_clean (
    procedure_id VARCHAR(36) PRIMARY KEY,
    encounter_id VARCHAR(36),
    cpt_code INT,
    procedure_description TEXT,

    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
) ENGINE=InnoDB;

INSERT INTO procedures_clean
SELECT
    procedure_id,
    encounter_id,
    cpt_code,
    procedure_description
FROM procedures;

DROP TABLE procedures;
ALTER TABLE procedures_clean RENAME TO procedures;

/* ------------------------------------------------------------
   12. Vitals
------------------------------------------------------------ */
CREATE TABLE vitals_clean (
    vital_id VARCHAR(36) PRIMARY KEY,
    encounter_id VARCHAR(36),
    systolic_bp INT,
    diastolic_bp INT,
    heart_rate INT,
    temperature_f DECIMAL(5,2),

    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
) ENGINE=InnoDB;

INSERT INTO vitals_clean
SELECT
    vital_id,
    encounter_id,
    systolic_bp,
    diastolic_bp,
    heart_rate,
    temperature_f
FROM vitals;

DROP TABLE vitals;
ALTER TABLE vitals_clean RENAME TO vitals;

/* ------------------------------------------------------------
   13. Diagnoses
------------------------------------------------------------ */
CREATE TABLE diagnoses_clean (
    diagnosis_id VARCHAR(36) PRIMARY KEY,
    encounter_id VARCHAR(36),
    icd10_code VARCHAR(20),
    diagnosis_description VARCHAR(255),

    FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
) ENGINE=InnoDB;

INSERT INTO diagnoses_clean
SELECT
    diagnosis_id,
    encounter_id,
    icd10_code,
    diagnosis_description
FROM diagnoses;

DROP TABLE diagnoses;
ALTER TABLE diagnoses_clean RENAME TO diagnoses;

SET FOREIGN_KEY_CHECKS = 1;
