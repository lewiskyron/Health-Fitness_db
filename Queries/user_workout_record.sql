-- we want to know the current progress record(highes record) of a user for a specific exercise and the date and session that that record was achieved.
-- Get the highest progress record for a specific exercise and the date and session when it was achieved
-- Get the highest progress record for a specific exercise and the date when it was achieved
-- Get the highest progress record for all exercises and their records for a particular user
SELECT 
    E.ExerciseName,                        -- The name of the exercise
    PT.ExerciseID,                          -- The specific exercise's ID
    MAX(PT.PersonalRecord) AS HighestRecord, -- The highest personal record for the exercise
    MAX(PT.PRDate) AS DateAchieved           -- The date when the highest record was achieved
FROM 
    ProgressTracking PT                     -- The ProgressTracking table
JOIN
    Exercises E                             -- Joining with the Exercises table to get exercise names
    ON PT.ExerciseID = E.ExerciseID
WHERE 
    PT.UserID = 4                          -- Replace '1' with the user's ID for whom you want to find the records
GROUP BY 
    E.ExerciseName, PT.ExerciseID            -- Group by exercise name and ID to find the highest records
ORDER BY 
    PT.ExerciseID;                          -- Optionally, you can order the results by exercise ID

