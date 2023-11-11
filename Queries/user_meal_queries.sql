
-- A user wanting to know meals they can eat based on health goal and dietary restrictions 
-- Selecting distinct meal details to avoid duplicate entries
SELECT DISTINCT
    M.MealID, 
    M.MealName, 
    M.MealType, 
    M.TotalCalories
FROM 
    Meals M

-- Joining Meals with MealGoals to associate meals with specific health goals
JOIN 
    MealGoals MG ON M.MealID = MG.MealID

-- Joining MealGoals with UserHealthGoals to filter meals that match the user's health goals
JOIN 
    UserHealthGoals UHG ON MG.GoalID = UHG.GoalID

-- Left joining Meals with MealRestrictions to consider any dietary restrictions associated with meals
LEFT JOIN 
    MealRestrictions MR ON M.MealID = MR.MealID

-- Left joining MealRestrictions with UserDietaryRestrictions to filter out meals that don't match the user's dietary restrictions
LEFT JOIN 
    UserDietaryRestrictions UDR ON MR.RestrictionID = UDR.RestrictionID

-- Filtering for user ID 1 and ensuring meals are included only if they have no conflicting dietary restrictions
WHERE 
    UHG.UserID = 1 
    AND (UDR.UserID IS NULL OR UDR.UserID != 1)

-- Ordering results by meal name for better readability
ORDER BY 
    M.MealName;







