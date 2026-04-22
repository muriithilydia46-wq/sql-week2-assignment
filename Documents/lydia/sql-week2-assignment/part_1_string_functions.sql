-- ============================================
-- Section: String Functions
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Database: nairobi_academy
-- ============================================

-- Q1: Display each student's full name in UPPERCASE and city in lowercase
SELECT
UPPER(first_name || ' ' || last_name) AS upper_name,
LOWER(city) AS lower_city
FROM nairobi_academy.students;

-- Q2: Show each student's first name and the LENGTH of their first name
-- ordered from longest to shortest
SELECT
first_name,
LENGTH(first_name) AS name_length
FROM nairobi_academy.students
ORDER BY name_length DESC;

-- Q3: Show each subject's name, first 4 characters as short_name
-- and full subject name length
SELECT
subject_name,
LEFT(subject_name, 4) AS short_name,
LENGTH(subject_name) AS name_length
FROM nairobi_academy.subjects;

-- Q4: Using CONCAT to produce a sentence for each student
SELECT
CONCAT(first_name, ' ', last_name, ' is in ', class, ' and comes from ', city) AS student_summary
FROM nairobi_academy.students;
