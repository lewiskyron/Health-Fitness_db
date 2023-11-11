
--- We want to know the total calories burnt on a particular day from a workout session 
SELECT 
    WS.SessionDate, 
    SUM(ED.TotalTimeInMinutes * E.AvgCaloriesBurnedPerMin) AS TotalCaloriesBurned
FROM 
    WorkoutSessions WS
JOIN 
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
JOIN 
    Exercises E ON ED.ExerciseID = E.ExerciseID
WHERE 
    WS.UserID = 1
    AND DATE(WS.SessionDate) = DATE("2023-11-10")
GROUP BY 
    WS.SessionDate
ORDER BY 
    WS.SessionDate;


-- Knowing this our user might want to know the breakdown of calories burnt per exercise
SELECT 
    WS.SessionID, 
    WS.SessionDate, 
    E.ExerciseName, 
    ED.TotalTimeInMinutes, 
    E.AvgCaloriesBurnedPerMin, 
    (ED.TotalTimeInMinutes * E.AvgCaloriesBurnedPerMin) AS CaloriesBurned
FROM 
    WorkoutSessions WS
JOIN 
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
JOIN 
    Exercises E ON ED.ExerciseID = E.ExerciseID
WHERE 
    WS.UserID = 1
    AND DATE(WS.SessionDate) = DATE("2023-11-10")
ORDER BY 
    WS.SessionDate, E.ExerciseName;






