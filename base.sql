
INSERT OR IGNORE INTO Goals (GoalName) VALUES 
('Weight Loss'),
('Muscle Gain');



INSERT OR IGNORE INTO WorkoutTypes (TypeName) VALUES
('Cardiovascular'),
('High Intensity Interval Training'),
('Cycling'),
('Running'),
('Walking'),
('Strength Training'),
('Circuit Training');


INSERT OR IGNORE  INTO DietaryRestrictions (RestrictionName) VALUES 
('Vegetarian'),
('Vegan'),
('Lactose Intolerant'),
('Gluten Intolerant'),
('Peanut Allergy'),
('Halal');



-- CREATE INDEX idx_authentication_userid ON Authentication(UserID);

-- Weight Loss
INSERT or IGNORE INTO GoalWorkoutMapping (GoalID, WorkoutTypeID) VALUES
(1, 1),  -- cardio
(1, 2),  -- HIIT
(1, 3),  -- cycling 
(1, 4),  -- runninng
(1, 5);  -- walking

-- Muscle Gain
INSERT or IGNORE INTO GoalWorkoutMapping (GoalID, WorkoutTypeID) VALUES
(2, 6), -- Strength Training
(2, 7), -- Circuit Training
(2, 2);  -- HIIT (for high-intensity strength circuits)


-- Cardiovascular Exercises
INSERT OR IGNORE INTO Exercises (WorkoutTypeID, ExerciseName, AvgCaloriesBurnedPerMin) VALUES
(1, 'Treadmill Running', 10),
(1, 'Stationary Bike', 7),
(1, 'Elliptical Training', 8),
(1, 'Rowing Machine', 7);

-- Strength Training Exercises
INSERT OR IGNORE INTO Exercises (WorkoutTypeID, ExerciseName, AvgCaloriesBurnedPerMin) VALUES
(6, 'Bench Press', 75),
(6, 'Deadlift', 75),
(6, 'Squats', 60),
(6, 'Bicep Curls', 45);

-- HIIT Exercises
INSERT OR IGNORE INTO Exercises (WorkoutTypeID, ExerciseName, AvgCaloriesBurnedPerMin) VALUES
(2, 'Burpees', 10),
(2, 'Jump Squats', 8),
(2, 'High Knees', 9),
(2, 'Mountain Climbers', 8);

-- Circuit Training Exercises
INSERT OR IGNORE INTO Exercises (WorkoutTypeID, ExerciseName, AvgCaloriesBurnedPerMin) VALUES
(7, 'Circuit Station - Pushups', 4),
(7, 'Circuit Station - Lunges', 5),
(7, 'Circuit Station - Plank', 3),
(7, 'Circuit Station - Jump Rope', 12);

-- Cycling, Running, and Walking Exercises
INSERT OR IGNORE INTO Exercises (WorkoutTypeID, ExerciseName, AvgCaloriesBurnedPerMin) VALUES
(3, 'Outdoor Cycling', 5),
(3, 'Uphill Cycling', 10),
(3, 'Speed Cycling', 10),
(4, 'Long-Distance Running', 12),
(4, 'Trail Running', 6.84),
(5, 'Brisk Walking', 7.46),
(5, 'Power Walking', 8.70),
(5, 'Hiking', 9.94);


INSERT or IGNORE INTO Meals (MealName, MealType, TotalCalories) VALUES
('Chicken Salad', 'Lunch', 300),
('Grilled Salmon', 'Dinner', 500),
('Vegan Stir Fry', 'Dinner', 350),
('Beef Steak with Veggies', 'Dinner', 450),
('Quinoa and Black Bean Salad', 'Lunch', 350),
('Tofu and Vegetable Curry', 'Dinner', 400),
('Turkey and Quinoa Stuffed Bell Peppers', 'Dinner', 400),
('Lentil Soup', 'Lunch', 300),
('Grilled Chicken Breast', 'Dinner', 450),
('Egg and Avocado Toast', 'Breakfast', 350),
('Chickpea Salad', 'Lunch', 320),
('Baked Cod with Sweet Potato', 'Dinner', 420),
('Vegetable Stir Fry with Brown Rice', 'Dinner', 380),
('Greek Yogurt with Berries and Nuts', 'Breakfast', 300),
('Protein Smoothie', 'Breakfast', 350);


INSERT or IGNORE INTO Ingredients (IngredientName, CaloricDensity) VALUES
('Chicken', 2.5),
('Lettuce', 0.1),
('Tomato', 0.2),
('Salmon', 3.0),
('Broccoli', 0.3),
('Quinoa', 2.0),
('Tofu', 1.5),
('Bell Pepper', 0.2),
('Spinach', 0.2),
('Beef', 2.8),
('Carrots', 0.4),
('Green Beans', 0.2),
('Black Beans', 2.0),
('Corn', 1.5),
('Cauliflower', 0.3),
('Peas', 0.4),
('Turkey', 2.7),
('Lentils', 2.0),
('Onions', 0.2),
('Asparagus', 0.2),
('Brown Rice', 1.5),
('Eggs', 1.0),
('Avocado', 2.5),
('Whole Grain Bread', 1.0),
('Chickpeas', 2.0),
('Cucumber', 0.2),
('Cod', 2.5),
('Sweet Potato', 1.8),
('Broccoli', 0.3),
('Bell Pepper', 0.2),
('Brown Rice', 1.5),
('Greek Yogurt', 1.0),
('Mixed Berries', 0.5),
('Almonds', 6.0),
('Whey Protein', 4.0),
('Banana', 1.5),
('Almond Milk', 0.5);

-- Chicken Salad Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(1, 1, 150, 'g'),  -- Chicken for Chicken Salad
(1, 2, 100, 'g'),  -- Lettuce for Chicken Salad
(1, 3, 50, 'g');   -- Tomato for Chicken Salad

-- Grilled Salmon Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(2, 4, 200, 'g'),  -- Salmon for Grilled Salmon
(2, 5, 100, 'g'),  -- Broccoli for Grilled Salmon
(2, 6, 150, 'g');  -- Quinoa for Grilled Salmon

-- Vegan Stir Fry Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(3, 7, 150, 'g'),  -- Tofu for Vegan Stir Fry
(3, 8, 100, 'g'),  -- Bell Pepper for Vegan Stir Fry
(3, 9, 50, 'g');   -- Spinach for Vegan Stir Fry

-- Beef Steak with Veggies Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(4, 10, 200, 'g'),  -- Beef for Beef Steak with Veggies
(4, 11, 100, 'g'),  -- Carrots for Beef Steak with Veggies
(4, 12, 100, 'g');  -- Green Beans for Beef Steak with Veggies

-- Quinoa and Black Bean Salad Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(5, 6, 150, 'g'),  -- Quinoa for Quinoa and Black Bean Salad
(5, 13, 100, 'g'), -- Black Beans for Quinoa and Black Bean Salad
(5, 14, 100, 'g'); -- Corn for Quinoa and Black Bean Salad

-- Tofu and Vegetable Curry Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(6, 7, 150, 'g'),  -- Tofu for Tofu and Vegetable Curry
(6, 15, 100, 'g'), -- Cauliflower for Tofu and Vegetable Curry
(6, 16, 100, 'g'); -- Peas for Tofu and Vegetable Curry

-- Turkey and Quinoa Stuffed Bell Peppers Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(7, 17, 150, 'g'),  -- Turkey for Turkey and Quinoa Stuffed Bell Peppers
(7, 6, 100, 'g'),   -- Quinoa for Turkey and Quinoa Stuffed Bell Peppers
(7, 18, 100, 'g');  -- Bell Peppers for Turkey and Quinoa Stuffed Bell Peppers

-- Lentil Soup Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(8, 19, 200, 'g'),  -- Lentils for Lentil Soup
(8, 11, 100, 'g'),  -- Carrots for Lentil Soup
(8, 20, 50, 'g');   -- Onions for Lentil Soup

-- Grilled Chicken Breast Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(9, 1, 150, 'g'),   -- Chicken for Grilled Chicken Breast
(9, 21, 100, 'g'),  -- Asparagus for Grilled Chicken Breast
(9, 22, 150, 'g');  -- Brown Rice for Grilled Chicken Breast

-- Egg and Avocado Toast Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(10, 23, 2, 'pcs'),  -- Eggs for Egg and Avocado Toast
(10, 24, 1, 'pcs'),  -- Avocado for Egg and Avocado Toast
(10, 25, 1, 'pcs');  -- Whole Grain Bread for Egg and Avocado Toast

-- Chickpea Salad Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(11, 26, 150, 'g'),  -- Chickpeas for Chickpea Salad
(11, 27, 100, 'g'),  -- Cucumber for Chickpea Salad
(11, 3, 50, 'g');    -- Tomatoes for Chickpea Salad

-- Baked Cod with Sweet Potato Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(12, 28, 200, 'g'),  -- Cod for Baked Cod with Sweet Potato
(12, 29, 150, 'g'),  -- Sweet Potato for Baked Cod with Sweet Potato
(12, 9, 50, 'g');    -- Spinach for Baked Cod with Sweet Potato

-- Vegetable Stir Fry with Brown Rice Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(13, 5, 150, 'g'),  -- Broccoli for Vegetable Stir Fry with Brown Rice
(13, 8, 100, 'g'),  -- Bell Pepper for Vegetable Stir Fry with Brown Rice
(13, 22, 150, 'g'); -- Brown Rice for Vegetable Stir Fry with Brown Rice

-- Greek Yogurt with Berries and Nuts Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(14, 30, 150, 'g'),  -- Greek Yogurt for Greek Yogurt with Berries and Nuts
(14, 31, 100, 'g'),  -- Mixed Berries for Greek Yogurt with Berries and Nuts
(14, 32, 10, 'g');   -- Almonds for Greek Yogurt with Berries and Nuts

-- Protein Smoothie Ingredients
INSERT or IGNORE INTO MealIngredients (MealID, IngredientID, Quantity, Unit) VALUES
(15, 33, 1, 'scoop'), -- Whey Protein for Protein Smoothie
(15, 34, 1, 'pcs'),   -- Banana for Protein Smoothie
(15, 35, 200, 'ml');  -- Almond Milk for Protein Smoothie







---- Dietaryr restrictions. 
-- Chicken Salad Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(1, 3),  -- Chicken Salad is Gluten Intolerant friendly
(1, 4);  -- Chicken Salad is Lactose Intolerant friendly

-- Grilled Salmon Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(2, 4);  -- Grilled Salmon is Gluten Intolerant friendly

-- Vegan Stir Fry Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(3, 1),  -- Vegan Stir Fry is Vegan
(3, 2);  -- Vegan Stir Fry is Vegetarian

-- Beef Steak with Veggies Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(4, 6);  -- Beef Steak with Veggies is Halal

-- Quinoa and Black Bean Salad Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(5, 1),  -- Quinoa and Black Bean Salad is Vegan
(5, 2);  -- Quinoa and Black Bean Salad is Vegetarian

-- Tofu and Vegetable Curry Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(6, 1),  -- Tofu and Vegetable Curry is Vegan
(6, 2);  -- Tofu and Vegetable Curry is Vegetarian

-- Turkey and Quinoa Stuffed Bell Peppers Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(7, 6);  -- Turkey and Quinoa Stuffed Bell Peppers is Halal

-- Lentil Soup Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(8, 1),  -- Lentil Soup is Vegan
(8, 2);  -- Lentil Soup is Vegetarian

-- Grilled Chicken Breast Restrictions
INSERT or IGNORE INTO  MealRestrictions (MealID, RestrictionID) VALUES
(9, 4);  -- Grilled Chicken Breast is Gluten Intolerant friendly

-- Egg and Avocado Toast Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(10, 3);  -- Egg and Avocado Toast is Lactose Intolerant friendly

-- Chickpea Salad Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(11, 1),  -- Chickpea Salad is Vegan
(11, 2);  -- Chickpea Salad is Vegetarian

-- Baked Cod with Sweet Potato Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(12, 4);  -- Baked Cod with Sweet Potato is Gluten Intolerant friendly

-- Vegetable Stir Fry with Brown Rice Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(13, 1),  -- Vegetable Stir Fry with Brown Rice is Vegan
(13, 2);  -- Vegetable Stir Fry with Brown Rice is Vegetarian

-- Greek Yogurt with Berries and Nuts Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(14, 3);  -- Greek Yogurt with Berries and Nuts is Vegetarian

-- Protein Smoothie Restrictions
INSERT or IGNORE INTO MealRestrictions (MealID, RestrictionID) VALUES
(15, 4);  -- Protein Smoothie is Gluten Intolerant friendly


-- Chicken Salad is for both Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(1, 1),
(1, 2);

-- Grilled Salmon is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(2, 2);

-- Vegan Stir Fry is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(3, 1),
(3, 2);

-- Beef Steak with Veggies is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(4, 2);

-- Quinoa and Black Bean Salad is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(5, 1),
(5, 2);

-- Tofu and Vegetable Curry is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(6, 1),
(6, 2);

-- Turkey and Quinoa Stuffed Bell Peppers is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(7, 2);

-- Lentil Soup is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(8, 1),
(8, 2);

-- Grilled Chicken Breast is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(9, 2);

-- Egg and Avocado Toast is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(10, 1),
(10, 2);

-- Chickpea Salad is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(11, 1),
(11, 2);

-- Baked Cod with Sweet Potato is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(12, 2);

-- Vegetable Stir Fry with Brown Rice is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(13, 1),
(13, 2);

-- Greek Yogurt with Berries and Nuts is for Weight Loss and Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(14, 1),
(14, 2);

-- Protein Smoothie is for Muscle Gain
INSERT or IGNORE INTO MealGoals (MealID, GoalID) VALUES
(15, 2);


DELETE FROM Users;
DELETE FROm UserDietaryRestrictions;
DELETE FROM Authentication;
DELETE FROM WorkoutSessions;
DELETE FROM UserHealthGoals;
Delete FROM WorkoutSessions;
DELETE FROM ExerciseDetails;

