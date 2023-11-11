-- Get exercises associated with each health goal, including the health goal name
SELECT 
    G.GoalName AS HealthGoal,   -- The name of the health goal
    E.ExerciseName             -- The name of the associated exercise
FROM 
    Goals G                    -- The Goals table
JOIN 
    GoalWorkoutMapping GWM     -- Joining GoalWorkoutMapping to map goals to workouts
    ON G.GoalID = GWM.GoalID
JOIN
    WorkoutTypes WT            -- Joining WorkoutTypes to get workout type names
    ON GWM.WorkoutTypeID = WT.WorkoutTypeID
JOIN
    Exercises E                -- Joining Exercises to get exercise names
    ON WT.WorkoutTypeID = E.WorkoutTypeID
ORDER BY 
    G.GoalName, E.ExerciseName; -- Optionally, you can order the results by goal name and exercise name
