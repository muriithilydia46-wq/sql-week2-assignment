-- ============================================
-- Section: Number Functions
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Database: nairobi_academy
-- ============================================

-- Q1: Show each exam result with mark rounded to 1 decimal place,
-- rounded UP using CEIL and rounded DOWN using FLOOR
SELECT
result_id,
marks,
ROUND(marks, 1) AS rounded_mark,
CEIL(marks / 10.0) * 10 AS rounded_up,
FLOOR(marks / 10.0) * 10 AS rounded_down
FROM nairobi_academy.exam_results;

-- Q2: Summary statistics for exam_results in one query
SELECT
COUNT(result_id) AS total_results,
ROUND(AVG(marks), 2) AS average_mark,
MAX(marks) AS highest_mark,
MIN(marks) AS lowest_mark,
SUM(marks) AS total_marks
FROM nairobi_academy.exam_results;

-- Q3: Apply 10% bonus to all marks
SELECT
result_id,
marks AS original_marks,
ROUND(marks * 1.10) AS boosted_mark
FROM nairobi_academy.exam_results;
