/* =========================================================
                    NUMBER CLEANING
   This script perform some number cleaning actions
============================================================ */ 

-- impossible vitals 
DELETE FROM vitals
WHERE systolic_bp <= 0
   OR diastolic_bp <= 0
   OR heart_rate <= 0
   OR temperature_f < 30
   OR temperature_f > 45;

-- Negative values
DELETE FROM charges
WHERE charge_amount <= 0;

-- invalid quantity
DELETE FROM prescriptions
WHERE quantity <= 0
   OR refills < 0;



