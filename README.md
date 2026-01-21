
# Healthcare System Data Analysis Project

## Project Overview

This project analyzes a **randomly generated healthcare system dataset** to answer key business questions related to **charges, diagnoses, encounters, facilities, insurance claims, medications, patients, contacts, pharmacies, prescriptions, procedures, providers, and vital signs**.

The goal is to deliver **actionable insights** for hospital administrators, clinicians, and data analysts by examining **patient demographics, encounter patterns, provider performance, facility utilization, prescription trends, diagnoses, and insurance and billing metrics**.

All analyses are performed using **SQL**, with implementations for both **SQLite** and **MySQL**. Queries are organized by topic to enhance clarity and reporting.

Results and dashboards are presented using **Power BI** and **Microsoft Excel**.

## Power BI Preview

Click [here](https://app.powerbi.com/view?r=eyJrIjoiMjE2NmQ4NGUtNThmYS00YTZkLTlmY2UtN2U1NzVhYTY3YWUwIiwidCI6ImFkYWMzNzYyLWYzMWQtNDliNS1iYWI1LWY3NjcxNzZmZjQyNSJ9) to access the **Power BI** report and interact with it.

![Embedded GIF](assets/power_bi.gif)


## Project Structure
The project includes **44 SQL query-answers to business questions** and is structured around **seven topics** of the chosen healthcare system.

 1. **Patient Demographics & Contact Info**
 2. **Patient Encounter Frequency & Patterns**
 3. **Facility & Encounter Analysis**
 4. **Provider & Specialty Analysis**
5. **Prescriptions & Pharmacies**
 6. **Diagnoses & Procedures**
 7. **Insurance & Billing**

## Data
- Source: https://excelx.com
- Raw CSV files: `data/raw`
- Or already as .db:  `data/db` (SQLite path)
- Or already as .db:  `data/db` (MySQL path)
- Tables created in `schema/`
- Cleaning/Standardizing functions in `schema/`

## Business Questions
- Business questions organized by analytical group are available in::  `business questions/`


## Entity Relationship Diagram (ER Diagram)
-   Located in: `schema/`

![Average Blood Pressure Chart](https://i.imgur.com/igUcoIq.png)

## SQL Queries (SQLite)
-    `queries/Group_1-7_Complete.sql`
    
-   `queries/Group1_Patient_Demographic_Analysis.sql`
    
-   `queries/Group2_Patient_Encounter_Analysis.sql`
    
-   `queries/Group3_Facility_&_Encounter_Analysis.sql`
    
-   `queries/Group4_Provider_&_Specialty_Analysis.sql`
    
-   `queries/Group5_Prescription_&_Pharmacy_Analysis.sql`
    
-   `queries/Group6_Diagnoses_&_Procedures_Analysis.sql`
    
-   `queries/Group7_Insurance_&_Billing_Analysis.sql`

## SQL Queries (MySQL)
-    `queries/Group_1-7_Complet_MySQL.sql`

## Insights / Results
-   Key findings and analytical conclusions are documented in:  
    `insights/`
    

Examples of insights include:

-   Patient encounter frequency by age group and facility
    
-   Provider workload distribution by specialty
    
-   Most common diagnoses and procedures
    
-   Prescription trends by pharmacy and medication
    
-   Insurance coverage impact on total charges

## Tech Stack

-   **SQL (SQLite)**

-   **SQL (MySQL)**

-  **ODBC Data Connectivity**

- **Power BI Analytics & Visualization**

-   **Relational Data Modeling**
    
-   **CSV Data Processing**
    
-   **Entity-Relationship (ER) Design**
    
-   **Healthcare Analytics Concepts**

## How to Run (SQLite)
1.  Import all raw CSV files from `data/raw/` into SQLite  
    **or** load the prebuilt database .db from `data/db/` 
2.   Run `schema/alter_tables.sql` to standardize column names
3.   Run `schema/create_tables.sql` to recreate tables with correct data types, primary keys, and foreign keys
4. Execute all cleaning and standardization scripts located in `schema/`
5. Run SQL queries from `queries/` by group, or execute  
    `queries/Group_1-7_Complete.sql` to run all analyses at once

## How to Run (MySQL)
1.  Import the database `db_mysql.sql` already set up and clean from `data/db/` with views of the queries included (recommended) or follow the instruction below
2. Import all raw CSV files from `data/raw/` into MySQL Workbench
3.   Run `schema/alter_tables_mysql.sql` to standardize column names
4.   Run `schema/create_tables_mysql.sql` to recreate tables with correct data types, primary keys, and foreign keys
5. Execute all cleaning and standardization scripts located in `schema/`
6. Run SQL  `queries/Group_1-7_Complet_MySQL.sql` to run all analyses at once
