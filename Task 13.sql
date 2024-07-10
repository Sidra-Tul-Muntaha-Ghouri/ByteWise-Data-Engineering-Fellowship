-- All data 
SELECT
  *
FROM
  tutorial.flights
LIMIT
  100;

-- flight with maximum arrival delay
SELECT
  airline_name,
  airline_code,
  air_time,
  distance,
  flight_number,
  arrival_delay
FROM
  tutorial.flights
WHERE
  arrival_delay = (
    SELECT
      max(arrival_delay)
    FROM
      tutorial.flights
  ) -- Airlines with departure delays wheren each airline's departure delay is Above Average Departure Delay:
SELECT
  airline_name,
  departure_delay
FROM
  tutorial.flights
WHERE
  departure_delay > (
    SELECT
      AVG(departure_delay)
    FROM
      tutorial.flights
  )
ORDER BY
  departure_delay DESC
LIMIT
  5;

-- Airlines with above average departure delay 
SELECT
  airline_name
FROM
  tutorial.flights
GROUP BY
  airline_name
HAVING
  AVG(departure_delay) > (
    SELECT
      AVG(departure_delay)
    FROM
      tutorial.flights
  );

-- How many flights to Atlanta were cancelled on Friday 
SELECT
  airline_name,
  COUNT(*) AS cancelled_flights
FROM
  (SELECT
      *
    FROM
      tutorial.flights
    WHERE
      destination_city = 'Atlanta'
      AND day_of_week = 'Friday'
  ) AS friday_flights_to_atlanta
WHERE
  was_cancelled = TRUE
GROUP BY
  airline_name
ORDER BY
  cancelled_flights DESC;