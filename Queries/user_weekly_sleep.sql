-- Calculate sleep duration for a specific user (UserID) for a particular week (StartOfWeek)
-- Replace '1' with the user's actual ID and 'YYYY-MM-DD' with the start date of the desired week
SELECT
    UserID,
    ROUND(SUM(WeeklySleepHours) / 7, 2) AS AverageDailySleepHours
FROM (
    SELECT
        UserID,
        SUM(SleepDuration) AS WeeklySleepHours
    FROM
        DailySleep
    WHERE
        UserID = 1 -- Replace '1' with the user's actual ID
        AND SleepStart >= '2023-11-07' -- Replace 'YYYY-MM-DD' with the start date of the desired week
        AND SleepStart < '2023-11-13' -- Replace 'YYYY-MM-DD' with the end date of the desired week
    GROUP BY
        UserID, strftime('%Y-%m-%d', SleepStart) -- Group by user and date
) AS WeeklySleep
GROUP BY
    UserID;


 