-- we want to know the weekly sleep for a particular user. 
-- Calculate monthly sleep duration for a specific user (e.g., user with UserID = 1)

SELECT
    UserID,
    strftime('%Y-%m', SleepStart) AS YearMonth,
    ROUND(AVG(SleepDuration), 2) AS AverageMonthlySleepHours
FROM
    DailySleep
WHERE
    UserID = 9 -- Replace '9' with the user's actual ID
GROUP BY
    UserID,
    YearMonth
ORDER BY
    YearMonth;
