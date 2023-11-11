-- Meals for Weight Loss
SELECT DISTINCT
    M.MealID, 
    M.MealName, 
    M.MealType, 
    M.TotalCalories,
    'Weight Loss' AS HealthGoal
FROM 
    Meals M
JOIN 
    MealGoals MG ON M.MealID = MG.MealID
JOIN 
    UserHealthGoals UHG ON MG.GoalID = UHG.GoalID
LEFT JOIN 
    MealRestrictions MR ON M.MealID = MR.MealID
LEFT JOIN 
    UserDietaryRestrictions UDR ON MR.RestrictionID = UDR.RestrictionID
WHERE 
    UHG.UserID = 1 
    AND (UDR.UserID IS NULL OR UDR.UserID != 1)
    AND MG.GoalID IN (SELECT GoalID FROM Goals WHERE GoalName = 'Weight Loss')



