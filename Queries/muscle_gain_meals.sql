-- Meals for Muscle Gain
-- Retrieve distinct meal details associated with the "Muscle Gain" goal for all users
-- Meals for Muscle Gain
-- Retrieve distinct meal details associated with the "Muscle Gain" goal for all users
SELECT DISTINCT
    M.MealID,           -- Unique identifier for the meal
    M.MealName,         -- Name of the meal
    M.MealType,         -- Type of the meal (e.g., Breakfast, Lunch, Dinner)
    M.TotalCalories,    -- Total calories in the meal
    'Muscle Gain' AS HealthGoal -- Custom column indicating the health goal
FROM 
    Meals M              -- Selecting from the Meals table
JOIN 
    MealGoals MG         -- Joining Meals with MealGoals to associate meals with specific health goals
    ON M.MealID = MG.MealID
JOIN 
    UserHealthGoals UHG -- Joining MealGoals with UserHealthGoals to filter meals that match the user's health goals
    ON MG.GoalID = UHG.GoalID
WHERE 
    MG.GoalID IN (  -- Filtering for meals linked to the "Muscle Gain" goal
        SELECT GoalID 
        FROM Goals 
        WHERE GoalName = 'Muscle Gain'
    )
-- Ordering results by meal name for better readability
ORDER BY 
    M.MealName;         -- Sorting the results by meal name
