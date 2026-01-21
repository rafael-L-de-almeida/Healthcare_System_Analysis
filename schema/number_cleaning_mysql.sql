/* =========================================================
                    NUMBER CLEANING
   This script perform some number cleaning actions
============================================================ */ 
USE `proj_healthcare_analysis`;
SET SQL_SAFE_UPDATES = 0;
-- 1. Remove impossible vitals 
DELETE FROM vitals
WHERE systolic_bp <= 0
   OR diastolic_bp <= 0
   OR heart_rate <= 0
   OR temperature_f < 30
   OR temperature_f > 45;

-- 2. Remove negative or zero charges
DELETE FROM charges
WHERE charge_amount <= 0;

-- 3. Remove invalid prescriptions
DELETE FROM prescriptions
WHERE quantity <= 0
   OR refills < 0;




