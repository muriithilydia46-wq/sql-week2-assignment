-- ============================================
-- Section: SQL JOINS
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Database: city_hospital
-- ============================================

-- Q1: INNER JOIN - appointments with patient and doctor details
SELECT
a.appointment_id,
p.full_name AS patient_name,
d.full_name AS doctor_name,
a.appt_date,
a.diagnosis
FROM city_hospital.appointments a
INNER JOIN city_hospital.patients p ON a.patient_id = p.patient_id
INNER JOIN city_hospital.doctors d ON a.doctor_id = d.doctor_id;

-- Q2: LEFT JOIN - ALL patients with their appointments if any
SELECT
p.full_name AS patient_name,
a.appt_date,
a.diagnosis
FROM city_hospital.patients p
LEFT JOIN city_hospital.appointments a ON p.patient_id = a.patient_id;

-- Q3: RIGHT JOIN - ALL doctors with patients they have seen
SELECT
d.full_name AS doctor_name,
p.full_name AS patient_name
FROM city_hospital.appointments a
RIGHT JOIN city_hospital.doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN city_hospital.patients p ON a.patient_id = p.patient_id;

-- Q4: Find patients who have NEVER had an appointment
SELECT
p.full_name,
p.city
FROM city_hospital.patients p
LEFT JOIN city_hospital.appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- Q5: Three table INNER JOIN - appointments with patient, doctor and prescription
SELECT
a.appointment_id,
p.full_name AS patient_name,
d.full_name AS doctor_name,
pr.medicine_name
FROM city_hospital.appointments a
INNER JOIN city_hospital.patients p ON a.patient_id = p.patient_id
INNER JOIN city_hospital.doctors d ON a.doctor_id = d.doctor_id
INNER JOIN city_hospital.prescriptions pr ON a.appointment_id = pr.appointment_id;
