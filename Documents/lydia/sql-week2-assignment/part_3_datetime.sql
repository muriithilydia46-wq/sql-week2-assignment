-- ============================================
-- Section: Date & Time Functions
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Database: nairobi_academy
-- ============================================

-- Q1: Extract birth year, birth month and birth day from date_of_birth
SELECT
first_name,
EXTRACT(YEAR FROM date_of_birth) AS birth_year,
EXTRACT(MONTH FROM date_of_birth) AS birth_month,
EXTRACT(DAY FROM date_of_birth) AS birth_day
FROM nairobi_academy.students;

-- Q2: Show full name, date_of_birth and age in complete years
-- ordered from oldest to youngest
SELECT
first_name || ' ' || last_name AS full_name,
date_of_birth,
EXTRACT(YEAR FROM AGE(date_of_birth)) AS age
FROM nairobi_academy.students
ORDER BY date_of_birth ASC;

-- Q3: Display each exam date in format: 'Friday, 15th March 2024'
SELECT
exam_date,
TO_CHAR(exam_date, 'FMDay, DDth FMMonth YYYY') AS formatted_date
FROM nairobi_academy.exam_results;
