-- Get the user's health goal and associated exercises for a specific user (e.g., user with UserID = 1)
SELECT
    UHG.UserID,
    G.GoalName AS HealthGoal,
    E.ExerciseName
FROM
    UserHealthGoals UHG
JOIN
    Goals G ON UHG.GoalID = G.GoalID
JOIN
    GoalWorkoutMapping GWM ON G.GoalID = GWM.GoalID
JOIN
    WorkoutTypes WT ON GWM.WorkoutTypeID = WT.WorkoutTypeID
JOIN
    Exercises E ON WT.WorkoutTypeID = E.WorkoutTypeID
WHERE
    UHG.UserID = 10; -- Replace '1' with the user's actual ID
