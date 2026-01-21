/* This code updates the database schema by renaming columns 
	for better handling during the project */
USE `proj_healthcare_analysis`;
	-- insurance_claim
ALTER TABLE insurance_claims RENAME COLUMN ClaimID TO claim_id;
ALTER TABLE insurance_claims RENAME COLUMN ChargeID TO charge_id;
ALTER TABLE insurance_claims RENAME COLUMN InsuranceProvider TO insurance_provider;
ALTER TABLE insurance_claims RENAME COLUMN AmountBilled TO amount_billed;
ALTER TABLE insurance_claims RENAME COLUMN AmountPaid TO amount_paid;
ALTER TABLE insurance_claims RENAME COLUMN Status TO status;

-- diagnoses
ALTER TABLE diagnoses RENAME COLUMN diagnosisid TO diagnosis_id;
ALTER TABLE diagnoses RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE diagnoses RENAME COLUMN diagnosisdescription TO diagnosis_description;

-- facilities
ALTER TABLE facilities RENAME COLUMN id TO facility_id;
ALTER TABLE facilities RENAME COLUMN name TO facility_name;
ALTER TABLE facilities RENAME COLUMN type TO facility_type;

-- medications
ALTER TABLE medications RENAME COLUMN id TO medication_id;
ALTER TABLE medications RENAME COLUMN name TO medication_name;

-- patients
ALTER TABLE patients RENAME COLUMN PatientID TO patient_id;
ALTER TABLE patients RENAME COLUMN FullName TO full_name;
ALTER TABLE patients RENAME COLUMN DateOfBirth TO date_of_birth;
ALTER TABLE patients RENAME COLUMN Gender TO gender;
ALTER TABLE patients RENAME COLUMN BloodType TO blood_type;

-- patients_contacts
ALTER TABLE patient_contacts RENAME COLUMN contactid TO contact_id;
ALTER TABLE patient_contacts RENAME COLUMN patientid TO patient_id;
ALTER TABLE patient_contacts RENAME COLUMN address TO address;
ALTER TABLE patient_contacts RENAME COLUMN phone TO phone;
ALTER TABLE patient_contacts RENAME COLUMN email TO email;

-- pharmacies
ALTER TABLE pharmacies RENAME COLUMN pharmacyid TO pharmacy_id;
ALTER TABLE pharmacies RENAME COLUMN name TO pharmacy_name;

-- prescriptions
ALTER TABLE prescriptions RENAME COLUMN prescriptionid TO prescription_id;
ALTER TABLE prescriptions RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE prescriptions RENAME COLUMN medicationid TO medication_id;
ALTER TABLE prescriptions RENAME COLUMN pharmacyid TO pharmacy_id ;
ALTER TABLE prescriptions RENAME COLUMN dateprescribed TO date_prescribed;
ALTER TABLE prescriptions RENAME COLUMN quantity TO quantity;
ALTER TABLE prescriptions RENAME COLUMN refills TO refills;

-- charges
ALTER TABLE charges RENAME COLUMN chargeid TO charge_id;
ALTER TABLE charges RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE charges RENAME COLUMN cpt_code TO cpt_code;
ALTER TABLE charges RENAME COLUMN chargeamount TO charge_amount;

-- encounters
ALTER TABLE encounters RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE encounters RENAME COLUMN patientid TO patient_id;
ALTER TABLE encounters RENAME COLUMN providerid TO provider_id;
ALTER TABLE encounters RENAME COLUMN facilityid TO facility_id;
ALTER TABLE encounters RENAME COLUMN encounterdate TO encounter_date;
ALTER TABLE encounters RENAME COLUMN encountertype TO encounter_type;

-- providers
ALTER TABLE providers RENAME COLUMN providerid TO provider_id;
ALTER TABLE providers RENAME COLUMN fullname TO full_name;
ALTER TABLE providers RENAME COLUMN specialty TO specialty;

-- vitals
ALTER TABLE vitals RENAME COLUMN vitalsid TO vital_id;
ALTER TABLE vitals RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE vitals RENAME COLUMN systolicbp TO systolic_bp;
ALTER TABLE vitals RENAME COLUMN diastolicbp TO diastolic_bp;
ALTER TABLE vitals RENAME COLUMN heartrate TO heart_rate;
ALTER TABLE vitals RENAME COLUMN temperature_f TO temperature_f;

-- procedures
ALTER TABLE procedures RENAME COLUMN procedureid TO procedure_id;
ALTER TABLE procedures RENAME COLUMN encounterid TO encounter_id;
ALTER TABLE procedures RENAME COLUMN cpt_code TO cpt_code;
ALTER TABLE procedures RENAME COLUMN proceduredescription TO procedure_description;

