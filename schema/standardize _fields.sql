/* =========================================================
                    STANDARDIZING FIELDS
   This script standardize some fields to comply with their
   proper formats.
============================================================ */ 

-- Gender
UPDATE patients
SET gender = 'Male'
WHERE gender IN ('M','m','male','MALE');

UPDATE patients
SET gender = 'Female'
WHERE gender IN ('F','f','female','FEMALE');

UPDATE patients
SET gender = 'Other'
WHERE gender NOT IN ('Male','Female');

-- Insurance claim status
UPDATE insurance
SET status = 'Paid'
WHERE status LIKE 'paid%';

UPDATE insurance
SET status = 'Pending'
WHERE status <> 'Paid';


