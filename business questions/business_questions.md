
# Business Questions by Group

**Introduction:**  
The following business questions have been defined to guide the creation of 48 SQL queries for analyzing the healthcare system. These questions cover patient demographics, encounters, facilities, providers, prescriptions, diagnoses, procedures, and insurance/billing. The insights gained from these queries will help evaluate utilization, clinical trends, resource allocation, and financial performance within the healthcare system.

## Group 1: Patient Demographics & Contact Info
1. What is the age distribution of patients by gender and blood type?  
2. Which patients have missing contact information (phone or email)?  
3. What is the average systolic and diastolic blood pressure by age group and blood type?  
4. Listing all patients with their date of birth and blood type, ordered by date of birth (oldest first).  
5. Listing all vitals recorded, including patient name and encounter date.  

## Group 2: Patient Encounter Frequency & Patterns
1. Which patients have had the highest number of encounters in the last 12 months?  
2. Which patients have more than 1 encounter, all in the same facility?  
3. Which patients were treated by more than one medical specialty?  
4. Which providers have the highest rate of repeat patients?  
5. How many encounters has each patient had?  
6. Which patients have had more than 3 encounters?  
7. For each patient, ranking their encounters from most recent to oldest.  
8. Showing the most recent encounter per patient.  
9. For each patient, comparing the current encounter date with their previous encounter date.  
10. Find patients with multiple encounters and then list their names and total number of encounters.  
11. Finding patients who have had at least one encounter at a hospital-type facility.  

## Group 3: Facility & Encounter Analysis
1. What is the monthly 2024 encounter volume by facility and encounter type?  
2. What is the average number of encounters per patient by facility type?  
3. Which facilities have the highest patient revisit rate?  
4. What is the rate of emergency cases per facility?  
5. What is the average heart rate per facility?  
6. Finding all encounters that occurred in a specific year (e.g., 2024).  
7. Each encounter with the patient’s full name and encounter date.  
8. Listing all encounters along with the provider name and facility name.  
9. Listing all encounters where the total billed amount is higher than the average billed amount across all encounters.  
10. Calculate the total billed amount per encounter, then show only encounters where the total exceeds 200.  

## Group 4: Provider & Specialty Analysis
1. What is the average number of encounters per provider per month, segmented by specialty?  
2. Which specialties generate the highest total billing amount?  
3. Showing all providers whose specialty is “Cardiology”.  
4. Listing all providers and the encounters they handled, including providers with zero encounters.  
5. Ranking providers based on the number of encounters they handled.  

## Group 5: Prescriptions & Pharmacies
1. Which pharmacies have filled more than 10 prescriptions?  
2. What are the most prescribed medications by month and facility?  
3. Retrieving all prescriptions with a quantity greater than 30.  
4. Showing all prescriptions with the medication name and pharmacy name.  
5. Listing all pharmacies and the prescriptions filled there, including pharmacies with no prescriptions.  

## Group 6: Diagnoses & Procedures
1. Which diagnoses are most commonly associated with pre-hypertension (systolic_bp > 121)?  
2. Which CPT code generates the highest average revenue?  
3. Listing all procedures performed, including the patient name and encounter date.  

## Group 7: Insurance & Billing
1. What are the total charges vs. total paid amounts by insurance provider?  
2. For each facility and provider, what is the percentage of claims paid less than 80% of the billed amount?  
3. What is the average charge amount per encounter by encounter type?  
4. What is the total amount billed and total amount paid per insurance provider?  
5. Showing all encounters and any associated insurance claims, including encounters without claims.  

