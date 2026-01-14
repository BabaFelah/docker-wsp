-- #3 - Number of trips in November 2025
SELECT COUNT(1) AS Trips
FROM green_taxi_data 
WHERE trip_distance <= 1
 AND lpep_pickup_datetime >= '2025-11-01' 
 AND lpep_pickup_datetime < '2025-12-01' ;

-- #4 - Pickup day with the longest trip distance
SELECT 
  D.lpep_pickup_datetime::DATE, 
  MAX(D.trip_distance) LongestDistance  
FROM  taxi_zone L
JOIN  green_taxi_data D
  ON L."LocationID" = D."PULocationID"
WHERE d.trip_distance < 100
  -- AND lpep_pickup_datetime >= '2025-11-01' 
  -- AND lpep_pickup_datetime < '2025-12-01' 
GROUP BY D.lpep_pickup_datetime::DATE
ORDER BY 2 DESC
LIMIT 1;
     

-- #5 - Pickup zone with the largest total amount
SELECT 
  L."Zone", 
  SUM(D.total_amount) AS total_amount
FROM  taxi_zone L
JOIN  green_taxi_data D
  ON L."LocationID" = D."PULocationID"
WHERE d.lpep_pickup_datetime >= '2025-11-18'
     AND d.lpep_pickup_datetime < '2025-11-19'
GROUP BY L."Zone"
ORDER BY 2 DESC
LIMIT 1;

---- #6 Dropoff zone with the highest tip
SELECT  
  P."Zone" AS PickUp,
  D."Zone" AS DropOff,
  MAX(t.tip_amount) AS total_tip
FROM  green_taxi_data T
JOIN taxi_zone P
  ON P."LocationID" = t."PULocationID"
LEFT JOIN taxi_zone D
  ON D."LocationID" = t."DOLocationID"
WHERE P."Zone" = 'East Harlem North'
  AND t.lpep_pickup_datetime >= '2025-11-01'
  AND t.lpep_pickup_datetime < '2025-12-01'
GROUP BY P."Zone", D."Zone"
ORDER BY 3 DESC
LIMIT 1;

