
-- we first recommend the exercises to John
SELECT E.ExerciseID, E.ExerciseName
FROM GoalWorkoutMapping GWM
JOIN WorkoutTypes WT ON GWM.WorkoutTypeID = WT.WorkoutTypeID
JOIN Exercises E ON WT.WorkoutTypeID = E.WorkoutTypeID
WHERE GWM.GoalID = 1;


INSERT or IGNORE INTO WorkoutSessions (UserID, SessionDate) VALUES
(1, '2023-12-10');


INSERT or IGNORE INTO WorkoutSessions(UserID, SessionDate) VALUES
(1, '2023-11-11'),  -- SessionID 2, replace with the desired date
(1, '2023-11-12');  -- SessionID 3, replace with the desired date

-- Inserting exercise details for Jon's workout session with SessionID = 1
INSERT or IGNORE INTO ExerciseDetails (SessionID, ExerciseID, Sets, Reps, Weight, Duration, Distance) VALUES
(1, 1, NULL, NULL, NULL, 30, 5),   -- 30 minutes of Treadmill Running, 5 miles
(1, 32, NULL, NULL, NULL, 45, 10),  -- 45 minutes of Cycling, 10 miles
(1, 10, 3, 15, NULL, NULL, NULL);   -- 3 sets of 15 reps of Jump Squats



INSERT or IGNORE INTO ExerciseDetails (SessionID, ExerciseID, Sets, Reps, Weight, Duration, Distance) VALUES
(2, 1, NULL, NULL, NULL, 30, 6),   -- 30 minutes of Treadmill Running, 6 miles
(2, 32, NULL, NULL, NULL, 45, 11),  -- 45 minutes of Cycling, 11 miles
(2, 10, 4, 15, NULL, NULL, NULL);   -- 3 sets of 15 reps of Jump Squats

-- Inserting exercise details for Jon's workout session with SessionID = 3
INSERT or IGNORE INTO ExerciseDetails (SessionID, ExerciseID, Sets, Reps, Weight, Duration, Distance) VALUES
(3, 1, NULL, NULL, NULL, 30, 7),   -- 30 minutes of Treadmill Running, 7 miles
(3, 32, NULL, NULL, NULL, 45, 12),  -- 45 minutes of Cycling, 12 miles
(3, 10, 3, 20, NULL, NULL, NULL); 





---- Get all the exercises for a specific date ----
SELECT
    WS.SessionID,
    WS.SessionDate,
    E.ExerciseName,
    ED.Sets,
    ED.Reps,
    ED.Weight,
    ED.Duration,
    ED.Distance
FROM
    WorkoutSessions WS
JOIN
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
JOIN
    Exercises E ON ED.ExerciseID = E.ExerciseID
WHERE
    WS.SessionDate = '2023-12-10'  -- Replace with the specific date you want to query
    AND WS.UserID = 1;  -- Replace 1 with Jon's actual UserID




--- Adding to the PR table 
-- Insert or ignore personal records (PR) for Treadmill Running (ExerciseID = 1)
INSERT OR IGNORE INTO ProgressTracking (UserID, ExerciseID, PersonalRecord, PRDate)
SELECT
    WS.UserID,
    1 AS ExerciseID,  -- ExerciseID for Treadmill Running
    MAX(ED.Distance) AS PersonalRecord,
    WS.SessionDate AS PRDate
FROM
    WorkoutSessions WS
JOIN
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
WHERE
    WS.UserID = 1
    AND ED.ExerciseID = 1  -- ExerciseID for Treadmill Running
GROUP BY
    WS.UserID,
    WS.SessionDate;

-- Insert or ignore personal records (PR) for Cycling (ExerciseID = 32)
INSERT OR IGNORE INTO ProgressTracking (UserID, ExerciseID, PersonalRecord, PRDate)
SELECT
    WS.UserID,
    32 AS ExerciseID,  -- ExerciseID for Cycling
    MAX(ED.Distance) AS PersonalRecord,
    WS.SessionDate AS PRDate
FROM
    WorkoutSessions WS
JOIN
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
WHERE
    WS.UserID = 1
    AND ED.ExerciseID = 32  -- ExerciseID for Cycling
GROUP BY
    WS.UserID,
    WS.SessionDate;

-- Insert or ignore personal records (PR) for Jump Squats (ExerciseID = 10)
INSERT OR IGNORE INTO ProgressTracking (UserID, ExerciseID, PersonalRecord, PRDate)
SELECT
    WS.UserID,
    10 AS ExerciseID,  -- ExerciseID for Jump Squats
    MAX(ED.Sets * ED.Reps) AS PersonalRecord,  -- Assuming PR is calculated based on Sets x Reps
    WS.SessionDate AS PRDate
FROM
    WorkoutSessions WS
JOIN
    ExerciseDetails ED ON WS.SessionID = ED.SessionID
WHERE
    WS.UserID = 1
    AND ED.ExerciseID = 10  -- ExerciseID for Jump Squats
GROUP BY
    WS.UserID,
    WS.SessionDate;


-- Query personal records (PR) for Treadmill Running (ExerciseID = 1) for Jon (UserID = 1)
SELECT
    PersonalRecord,
    PRDate
FROM
    ProgressTracking
WHERE
    UserID = 1
    AND ExerciseID = 1  -- ExerciseID for Treadmill Running
ORDER BY
    PRDate DESC
LIMIT 1;


DELETE FROM DailySleep;


INSERT INTO DailySleep (UserID, SleepStart, SleepEnd, SleepDuration) VALUES
(1, '2023-10-01 22:00:00', '2023-10-02 04:30:00', ROUND((JULIANDAY('2023-10-02 04:30:00') - JULIANDAY('2023-10-01 22:00:00')) * 24, 2)),
(1, '2023-10-02 22:00:00', '2023-10-03 05:00:00', ROUND((JULIANDAY('2023-10-03 05:00:00') - JULIANDAY('2023-10-02 22:00:00')) * 24, 2)),
(1, '2023-10-03 22:00:00', '2023-10-04 05:30:00', ROUND((JULIANDAY('2023-10-04 05:30:00') - JULIANDAY('2023-10-03 22:00:00')) * 24, 2)),
(1, '2023-10-30 22:00:00', '2023-10-31 06:00:00', ROUND((JULIANDAY('2023-10-31 06:00:00') - JULIANDAY('2023-10-30 22:00:00')) * 24, 2)),
(1, '2023-10-31 22:00:00', '2023-11-01 04:00:00', ROUND((JULIANDAY('2023-11-01 04:00:00') - JULIANDAY('2023-10-31 22:00:00')) * 24, 2));





--- Get the average sleep duration for a specific month
INSERT or IGNORE INTO MonthlySleepAverage (UserID, YearMonth, AverageSleepHours)
SELECT 
    1, 
    '2023-10', 
    AVG(SleepDuration)
FROM 
    DailySleep
WHERE 
    UserID = 1 AND 
    strftime('%Y-%m', SleepStart) = '2023-10';


INSERT or IGNORE INTO Ingredients (IngredientID, IngredientName, CaloricDensity) VALUES
(1, 'Chicken Breast', 165),
(2, 'Brown Rice', 111),
(3, 'Broccoli', 34),
(4, 'Whole Wheat Pasta', 124),
(5, 'Salmon', 208),
(6, 'Sweet Potato', 86),
(7, 'Quinoa', 120),
(8, 'Spinach', 23),
(9, 'Eggs', 155),
(10, 'Avocado', 160);

-- Inserting the meal
INSERT or IGNORE  INTO Meals (MealID, MealName, MealType, TotalCalories) VALUES
(1, 'Grilled Chicken with Brown Rice and Broccoli', 'Dinner', 503.5);

-- Inserting the ingredients for this meal
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity) VALUES
(1, 1, 150), -- Chicken Breast 150g
(1, 2, 200), -- Brown Rice 200g
(1, 3, 100); -- Broccoli 100g


-- Linking the first meal to 'Weight Loss'
INSERT or IGNORE  INTO MealGoals (MealID, GoalID) VALUES
(1, 1);


SELECT 
    m.MealID, 
    m.MealName, 
    m.MealType, 
    m.TotalCalories,
    i.IngredientName,
    mi.Quantity AS QuantityInGrams,
    i.CaloricDensity,
    (mi.Quantity * i.CaloricDensity / 100) AS IngredientCalories  -- Calorie calculation
FROM 
    Meals m
JOIN 
    MealIngredients mi ON m.MealID = mi.MealID
JOIN 
    Ingredients i ON mi.IngredientID = i.IngredientID
WHERE 
    m.MealID = 1;  -- Replace 1 with the actual MealID obtained from the first query

