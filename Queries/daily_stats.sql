--- From this we can calculate if the user is on a calorie surplus or deficit for a given day. 
--- For users who want to lose weight we want them to have a calorie deficit. 
-- Whereas for users who want to gain weight we want them to have a calorie surplus.

SELECT
    U.UserID,
    U.FirstName,
    U.LastName,
    U.BMR,
    -- Calculate daily calories consumed
    COALESCE(SUM(M.TotalCalories), 0) AS CaloriesConsumed,
    -- Calculate daily calories burned from exercises
    COALESCE(SUM(E.AvgCaloriesBurnedPerMin * ED.TotalTimeInMinutes), 0) AS CaloriesBurned,
    -- Calculate the daily calorie balance
    COALESCE(SUM(M.TotalCalories), 0) - COALESCE(SUM(E.AvgCaloriesBurnedPerMin * ED.TotalTimeInMinutes), 0) - U.BMR AS CalorieBalance
FROM
    Users U
LEFT JOIN
    UserMeals UM ON U.UserID = UM.UserID
    AND DATE(UM.MealDateTime) = '2023-11-10'  -- Replace with the desired date
LEFT JOIN
    Meals M ON UM.MealID = M.MealID
LEFT JOIN
    WorkoutSessions WS ON U.UserID = WS.UserID
    AND DATE(WS.SessionDate) = '2023-11-10'  -- Replace with the desired date
LEFT JOIN
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
LEFT JOIN
    Exercises E ON ED.ExerciseID = E.ExerciseID
WHERE
    U.UserID = 1  -- Replace '1' with the specific user's ID
GROUP BY
    U.UserID, U.FirstName, U.LastName, U.BMR



