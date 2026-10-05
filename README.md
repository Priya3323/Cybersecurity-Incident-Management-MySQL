# Cybersecurity Incident Management and Risk Analysis Using MySQL

## Project Overview

This is a beginner-level SQL project based on cybersecurity data.

The project uses **MySQL** to analyze security incidents, login activity, network events, systems, users, and organizations. The main purpose is to find useful patterns in the data and identify areas that may need further investigation.

## Objectives

The main objectives of this project are:

* Analyze cybersecurity incidents based on severity.
* Find the most common types of security incidents.
* Analyze successful and failed login attempts.
* Analyze network activity across systems and organizations.
* Find organizations with higher numbers of incidents or failed login attempts.
* Analyze the operating systems used by different systems.
* Practice SQL concepts and apply them to a real-world type of dataset.

## Database Tables

The project contains 7 tables:

1. **organizations** – Contains organization and industry information.
2. **users** – Contains user information and their organization.
3. **systems** – Contains system details such as operating system and organization.
4. **login_logs** – Contains login attempts and their status.
5. **network_events** – Contains network activity recorded for different systems.
6. **security_incidents** – Contains information about cybersecurity incidents.
7. **incident_systems** – Connects security incidents with the systems involved.

## Tools Used

* MySQL
* MySQL Workbench
* SQL
* Git
* GitHub

## SQL Concepts Used

During this project, I practiced the following SQL concepts:

* SELECT
* WHERE
* GROUP BY
* HAVING
* ORDER BY
* Aggregate Functions
* Joins
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* CASE statements
* Primary Keys
* Foreign Keys

## Data Preparation

Before starting the analysis, the database was checked and prepared.

Some of the preparation work included:

* Checking table structures and records.
* Checking for duplicate records.
* Checking for orphan records.
* Converting date fields into proper MySQL DATE format.
* Creating primary keys.
* Creating foreign key relationships between related tables.
* Checking relationships between the tables.

## Analysis Performed

The project includes analysis of:

* Incidents by severity
* Incidents by year
* Login attempts by status
* Most common security incident type
* Most common incident type among Critical incidents
* Organizations with the highest High-severity incidents
* Organizations with the highest Critical incidents
* Organizations with the highest total incidents
* Organizations with the highest network activity
* Systems with the highest network activity
* Operating systems with the highest number of systems
* Systems with the highest number of associated incidents
* Organizations with the highest failed login attempts

## Key Findings

Some important findings from the analysis are:

* **Critical** incidents were the highest severity category with **140 incidents**.
* **Malware** was the most common security incident type with **185 incidents**.
* Among Critical incidents, **Data Breach** was the most common type with **49 incidents**.
* There were **6,000 login attempts**, including **3,040 successful** and **2,960 failed** attempts.
* **ORG079 (Finance)** had the highest total number of incidents with **12 incidents**.
* **ORG058 (Healthcare)** had the highest number of Critical incidents with **5 incidents**.
* **ORG018 (Tech)** had the highest number of failed login attempts with **49 attempts**.
* **ORG057 (Finance)** had the highest number of network events with **96 events**.
* **Windows** was the most commonly used operating system with **213 systems**.
* **S0031** had the highest number of associated incidents with **4 incidents**.
* **S0005** had the highest number of network events with **17 events**.
* The number of incidents decreased from **374 in 2023 to 126 in 2024**.

These findings help identify areas that can be considered for further investigation and monitoring.

## Project Structure

```text
Cybersecuritysqlproject/
│
├── 01Database/
├── 02SQLQueries/
├── 03Screenshots/
├── 04ProjectReport/
├── 05Presentation/
└── 06ERDiagram/
```

## Skills Practiced

Through this project, I practiced:

* SQL
* MySQL
* Data analysis
* Data preparation
* Database relationships
* Writing SQL queries
* Using joins and subqueries
* Using CTEs and window functions
* Finding patterns in cybersecurity data
* Git and GitHub

## Conclusion

This project helped me understand how SQL can be used to analyze cybersecurity data and find useful patterns from different tables.

It also helped me practice database relationships, SQL queries, data preparation, and basic data analysis.

The results from this project can be used to identify areas for further investigation and support data-driven cybersecurity analysis.
