-- ============================================
-- Section: SET Operators
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Databases: nairobi_academy & city_hospital
-- ============================================

-- Q1: UNION - unique cities from students and patients
SELECT city FROM nairobi_academy.students
UNION
SELECT city FROM city_hospital.patients
ORDER BY city ASC;

-- Q2: UNION ALL - student first names and patient full names with source label
SELECT first_name AS name, 'Student' AS source
FROM nairobi_academy.students
UNION ALL
SELECT full_name AS name, 'Patient' AS source
FROM city_hospital.patients;

-- Q3: INTERSECT - cities that appear in BOTH students and patients tables
SELECT city FROM nairobi_academy.students
INTERSECT
SELECT city FROM city_hospital.patients;

-- Q4: UNION ALL - students, patients and doctors combined with source label
SELECT first_name || ' ' || last_name AS name, 'Student' AS source
FROM nairobi_academy.students
UNION ALL
SELECT full_name AS name, 'Patient' AS source
FROM city_hospital.patients
UNION ALL
SELECT full_name AS name, 'Doctor' AS source
FROM city_hospital.doctors
ORDER BY source, name;
