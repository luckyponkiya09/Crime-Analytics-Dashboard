-- Total Crimes
SELECT COUNT(*) AS Total_Crimes
FROM Crimes;

-- Total Victims
SELECT COUNT(*) AS Total_Victims
FROM Victims;

-- Total Police Stations
SELECT COUNT(*) AS Total_Police_Stations
FROM Police_Stations;

-- Total Locations
SELECT COUNT(*) AS Total_Locations
FROM Locations;

-- Total Cases
SELECT COUNT(*) AS Total_Cases
FROM Cases;

-- Show All High Severity Crimes
SELECT *
FROM Crimes
WHERE severity='High';

-- Crimes Where Arrest Was Made
SELECT *
FROM Crimes
WHERE arrest_made='Yes';

-- Top 10 Highest Loss Crimes
SELECT *
FROM Crimes
ORDER BY loss_amount DESC
LIMIT 10;

-- Crimes Using Gun
SELECT *
FROM Crimes
WHERE weapon_used='Gun';

-- Crimes After 2024
SELECT *
FROM Crimes
WHERE crime_date >= '2024-01-01';
SECTION 2: AGGREGATE + GROUP BY (11–20)

-- Crime Count By Type
SELECT crime_type,
       COUNT(*) AS Total_Crimes
FROM Crimes
GROUP BY crime_type
ORDER BY Total_Crimes DESC;

-- Crime Count By Severity
SELECT severity,
       COUNT(*) AS Total_Crimes
FROM Crimes
GROUP BY severity;

-- Arrest Rate Analysis
SELECT arrest_made,
       COUNT(*) AS Total
FROM Crimes
GROUP BY arrest_made;

-- Case Status Distribution
SELECT case_status,
       COUNT(*) AS Total_Cases
FROM Cases
GROUP BY case_status;

-- Average Investigation Days By Case Status
SELECT case_status,
       AVG(investigation_days) AS Avg_Days
FROM Cases
GROUP BY case_status;

-- Total Fine Amount By Case Status
SELECT case_status,
       SUM(fine_amount) AS Total_Fine
FROM Cases
GROUP BY case_status;

-- Crime Count By City
SELECT city,
       COUNT(*) AS Total_Locations
FROM Locations
GROUP BY city
ORDER BY Total_Locations DESC;

-- Average Victim Age By Gender
SELECT gender,
       AVG(age) AS Avg_Age
FROM Victims
GROUP BY gender;

-- Victim Count By Occupation
SELECT occupation,
       COUNT(*) AS Total_Victims
FROM Victims
GROUP BY occupation
ORDER BY Total_Victims DESC;

-- Crimes By Weapon Used
SELECT weapon_used,
       COUNT(*) AS Total
FROM Crimes
GROUP BY weapon_used
ORDER BY Total DESC;

-- Crime Type With Victim Information
SELECT c.crime_id,
       c.crime_type,
       v.victim_name,
       v.age,
       v.gender
FROM Crimes c
JOIN Victims v
ON c.victim_id=v.victim_id;

-- Crime Location Analysis
SELECT c.crime_type,
       l.city,
       l.area
FROM Crimes c
JOIN Locations l
ON c.location_id=l.location_id;

-- Police Station Handling Crimes
SELECT c.crime_id,
       c.crime_type,
       p.station_name
FROM Crimes c
JOIN Police_Stations p
ON c.station_id=p.station_id;

-- Case Resolution Details
SELECT c.crime_type,
       cs.case_status,
       cs.investigation_days
FROM Crimes c
JOIN Cases cs
ON c.crime_id=cs.crime_id;

-- City Wise Crime Count
SELECT l.city,
       COUNT(*) AS Total_Crimes
FROM Crimes c
JOIN Locations l
ON c.location_id=l.location_id
GROUP BY l.city
ORDER BY Total_Crimes DESC;

-- Cities Having More Than 500 Crimes
SELECT l.city,
       COUNT(*) AS Total_Crimes
FROM Crimes c
JOIN Locations l
ON c.location_id=l.location_id
GROUP BY l.city
HAVING COUNT(*) > 500;

-- Crime Severity Category Using CASE
SELECT crime_id,
       crime_type,
       CASE
           WHEN severity='High' THEN 'Critical'
           WHEN severity='Medium' THEN 'Moderate'
           ELSE 'Low Risk'
       END AS Risk_Level
FROM Crimes;

-- Crime With Maximum Financial Loss
SELECT *
FROM Crimes
WHERE loss_amount =
(
SELECT MAX(loss_amount)
FROM Crimes
);

-- Top 5 Cities With Most Crimes
SELECT l.city,
       COUNT(*) AS Total_Crimes
FROM Crimes c
JOIN Locations l
ON c.location_id=l.location_id
GROUP BY l.city
ORDER BY Total_Crimes DESC
LIMIT 5;

-- Create View For Crime Summary
CREATE VIEW Crime_Summary AS
SELECT crime_type,
       COUNT(*) AS Total_Crimes
FROM Crimes
GROUP BY crime_type;

SELECT *
FROM Crime_Summary;