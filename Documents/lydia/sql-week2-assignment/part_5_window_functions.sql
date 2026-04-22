-- ============================================
-- Section: Window Functions
-- Name: Lydia Wangari
-- Date: 21st April 2026
-- Database: nairobi_academy
-- ============================================

-- Q1: ROW_NUMBER() - assign unique rank from highest to lowest marks
SELECT
result_id,student_id,marks,
ROW_NUMBER() OVER(ORDER BY marks DESC) AS row_num
FROM nairobi_academy.exam_results;

-- Q2: RANK() vs DENSE_RANK() side by side
SELECT
result_id,marks,
RANK() OVER(ORDER BY marks DESC) AS rank,
DENSE_RANK() OVER(ORDER BY marks DESC) AS dense_rank
FROM nairobi_academy.exam_results;

-- Q3: NTILE(3) - divide results into 3 performance bands with labels
SELECT
result_id,marks,band,
CASE
    WHEN band = 1 THEN 'Top'
    WHEN band = 2 THEN 'Middle'
    WHEN band = 3 THEN 'Bottom'
END AS band_label
FROM (
    SELECT
    result_id,
    marks,
    NTILE(3) OVER(ORDER BY marks DESC) AS band
    FROM nairobi_academy.exam_results
) AS band_results;

-- Q4: AVG() OVER PARTITION BY student - each result with student's personal average
SELECT
student_id,marks,
ROUND(AVG(marks) OVER(PARTITION BY student_id), 2) AS student_avg
FROM nairobi_academy.exam_results;

-- Q5: LAG() - show previous marks and improvement per student
SELECT
student_id,marks,
LAG(marks) OVER(PARTITION BY student_id ORDER BY result_id) AS previous_marks,
marks - LAG(marks) OVER(PARTITION BY student_id ORDER BY result_id) AS improvement
FROM nairobi_academy.exam_results;
