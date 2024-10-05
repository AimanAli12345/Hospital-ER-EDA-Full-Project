## In this project, I performed exploratory data analysis on hospital patients data.
## Goal is to identify, understand, unveil and analyse the data in detail so it can later be visualized using Tableau.

-- First, let's see the overview of our dataset

SELECT *
FROM hospitaler
LIMIT 10;


-- Exploratory Data Analysis:

-- How many rows do we have in our dataset?

SELECT COUNT(*) as row_num
FROM hospitaler;

-- it has 5136 rows

-- How many colums do we have in our dataset?

SELECT COUNT(*) as col_num
FROM information_schema.columns
;

-- 3609 colums

-- How many years of data do we have?

SELECT YEAR(`date`) as years
FROM hospitaler
GROUP BY years ;

-- From 2019 to 2020

--  How much data each year

SELECT YEAR(`date`) as years, COUNT(*) as counts
FROM hospitaler
GROUP BY years ;

-- 2019= 2410, 2020= 2726.


-- How many years of data do we have and what is the %age / year?
SELECT YEAR('date') AS years, COUNT(*) AS counts,
ROUND((COUNT(*)/
(SELECT COUNT(*) FROM hospitaler)) * 100 ) AS pct
FROM hospitaler
GROUP BY YEAR('date');


-- What date has the highest number of patients

SELECT 'date', COUNT(*)
FROM hospitaler;

-- Covert date column from "text" to "date"

SELECT `date`,
str_to_date(`date`, '%Y-%m-%d')
FROM hospitaler;

UPDATE hospitaler
SET `date` = str_to_date(`date`, '%Y-%m-%d');

ALTER TABLE hospitaler
MODIFY COLUMN `date` DATE;


-- What date to what date is the data from?

SELECT MIN(`date`), MAX(`date`)
FROM hospitaler;

-- 1st of march 2019 to 30th of october 2020


-- What date had the highest number of patients?

SELECT *
FROM hospitaler;

SELECT `date` as visit_day , Count(*) as number_of_visits
FROM hospitaler
GROUP BY visit_day
ORDER BY number_of_visits DESC
;

-- so highest number of visits in a day are 18 on 22nd June 2019 and 17th August 2020. 
-- and lowest number of visits i.e, 1 was on 7 August 2019

-- What are the unique values in patient gender 

SELECT patient_gender
FROM hospitaler
GROUP BY patient_gender;

-- its "NC"


-- Number of patients of distinct genders
 
SELECT patient_gender, COUNT(*)
FROM hospitaler
GROUP BY patient_gender;

-- So, male=2580 , F=2544, NC=12

 
-- Percentage of patients of distinct genders

SELECT patient_gender, COUNT(*) AS counts,
ROUND((COUNT(*) /
(SELECT COUNT(*) FROM hospitaler)) * 100, 1) as pct
FROM hospitaler
GROUP BY patient_gender;

-- so, M= 50.2%, F=49.5%, NC=0.2%



-- What is the average age of patients in our data set

SELECT *
FROM hospitaler;

SELECT ROUND(AVG(patient_age))
FROM hospitaler;

-- so, avg age = 40

-- avg age for distinct genders

SELECT patient_gender, ROUND(AVG(patient_age))
FROM hospitaler
GROUP BY patient_gender;

-- So, male=39, F= 40, NC= 46

-- How many races do we have in our data set

SELECT patient_race 
FROM hospitaler
GROUP BY patient_race ;

-- so, 7 distinct races


-- Which race has the most and least number of patients from?

SELECT patient_race, COUNT(*) as counts
FROM hospitaler
GROUP BY patient_race 
ORDER BY counts DESC ;

-- So, white race= 1440 are the most number of patients.
-- And, native american/Alaska Native= 254 i.e, least no. of patients from one race



-- WHat is the distribution of races in our data set?

SELECT patient_race, COUNT(*) as counts ,
ROUND((COUNT(*) /
(SELECT COUNT(*) FROM hospitaler))* 100, 1) AS PCT 
FROM hospitaler
GROUP BY patient_race
ORDER BY PCT DESC;

-- SO, white = 28% highest, nativeamerican/alaskanative= 4.9% lowest


-- What is the average waiting time of the patients in this data set?

SELECT  AVG(patient_waittime) as average_waiting_time
FROM hospitaler;

-- so, avg waiting time os 35.2 hours


-- what is the maximum and min waiting time?

SELECT  MAX(patient_waittime), MIN(patient_waittime)
FROM hospitaler;
-- so, max= 60 hours and min=10 hours

-- Patient distribution accross departmental referral

SELECT *
FROM hospitaler;

SELECT department_referral, COUNT(*) as counts
FROM hospitaler
GROUP BY department_referral;

-- %age of patient distribution accross departmental referral

SELECT department_referral
FROM hospitaler
WHERE NOT department_referral = 'none'
GROUP BY department_referral;

SELECT department_referral, COUNT(*) as counts,
ROUND((COUNT(*)/
(SELECT COUNT(*) FROM hospitaler))* 100, 1)
FROM hospitaler
WHERE NOT department_referral = 'none'
GROUP BY department_referral
;

-- So, General practice= 1051 patients i.e, 20.5% of total patients
-- and Renal department has 50 patients i.e, only 1% of the total patients.


-- Which department has highest waiting time


SELECT department_referral as department , SUM(patient_waittime) as total_hours
FROM hospitaler 
WHERE NOT department_referral = 'none'
GROUP BY department_referral;

-- so highest total waiting hours=36702 is by GP department
-- and lowest waiting time=1760 is by renal dep.
-- this is in line with the highest and lowest # of patients.


-- THE END 