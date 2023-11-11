-- primary User information
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Sex VARCHAR(10),
    Height REAL,
    Weight REAL,
    BMR REAL
);

-- Authentication Table
CREATE TABLE Authentication (
    UserID INTEGER,
    Username VARCHAR(50) UNIQUE NOT NULL,
    HashedPassword TEXT NOT NULL, -- Changed to TEXT
    Email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- DietaryRestrictions Table
CREATE TABLE DietaryRestrictions (
    RestrictionID INTEGER PRIMARY KEY,
    RestrictionName VARCHAR(255) NOT NULL UNIQUE
);


-- UserDietaryRestrictions Table
CREATE TABLE UserDietaryRestrictions (
    UserID INTEGER,
    RestrictionID INTEGER,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RestrictionID) REFERENCES DietaryRestrictions(RestrictionID),
    UNIQUE (UserID, RestrictionID)
);



-- Goals Table
CREATE TABLE Goals (
    GoalID INTEGER PRIMARY KEY,
    GoalName VARCHAR(255) NOT NULL UNIQUE
);


-- UserHealthGoals Table
CREATE TABLE UserHealthGoals (
    UserID INTEGER,
    GoalID INTEGER,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (GoalID) REFERENCES Goals(GoalID),
    UNIQUE (UserID, GoalID)
);

-- WorkoutTypes Table
CREATE TABLE WorkoutTypes (
    WorkoutTypeID INTEGER PRIMARY KEY,
    TypeName VARCHAR(255) NOT NULL UNIQUE
);


-- GoalWorkoutMapping Table
CREATE TABLE GoalWorkoutMapping (
    MappingID INTEGER PRIMARY KEY,
    GoalID INTEGER,
    WorkoutTypeID INTEGER,
    FOREIGN KEY (GoalID) REFERENCES Goals(GoalID),
    FOREIGN KEY (WorkoutTypeID) REFERENCES WorkoutTypes(WorkoutTypeID),
    UNIQUE (GoalID, WorkoutTypeID)
);


-- Exercises Table
CREATE TABLE Exercises (
    ExerciseID INTEGER PRIMARY KEY,
    WorkoutTypeID INTEGER,
    ExerciseName VARCHAR(255) NOT NULL UNIQUE,
    AvgCaloriesBurnedPerMin REAL,
    FOREIGN KEY (WorkoutTypeID) REFERENCES WorkoutTypes(WorkoutTypeID)
);


-- WorkoutSessions Table
CREATE TABLE WorkoutSessions (
    SessionID INTEGER PRIMARY KEY,
    UserID INTEGER,
    SessionDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- ExerciseDetails Table
CREATE TABLE ExerciseDetails (
    SessionID INTEGER,
    ExerciseID INTEGER,
    TotalTimeInMinutes INTEGER, -- Total time spent on the exercise
    FOREIGN KEY (SessionID) REFERENCES WorkoutSessions(SessionID),
    FOREIGN KEY (ExerciseID) REFERENCES Exercises(ExerciseID),
    PRIMARY KEY (SessionID, ExerciseID)
);

-- ProgressTracking Table (optional if you want to track personal records separately)
CREATE TABLE ProgressTracking (
    UserID INTEGER,
    ExerciseID INTEGER,
    PersonalRecord REAL,
    PRDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ExerciseID) REFERENCES Exercises(ExerciseID),
    UNIQUE (UserID, ExerciseID)
);

---Sleep tables 
-- Sleep table with complete date and time for SleepStart and SleepEnd
CREATE TABLE DailySleep (
    SleepID INTEGER PRIMARY KEY,
    UserID INTEGER,
    SleepStart DATETIME NOT NULL,
    SleepEnd DATETIME NOT NULL,
    SleepDuration REAL NOT NULL,  -- Sleep duration in hours
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE MonthlySleepAverage (
    MonthlyAverageID INTEGER PRIMARY KEY,
    UserID INTEGER,
    YearMonth CHAR(7),
    AverageSleepHours REAL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Meals --- users can directly input the calories for meals directly or we can calculate it based on the ingredients
CREATE TABLE Meals (
    MealID INTEGER PRIMARY KEY,
    MealName VARCHAR(255) NOT NULL,
    MealType VARCHAR(50), -- 'Breakfast', 'Lunch', 'Dinner'
    TotalCalories REAL
);


CREATE TABLE MealIngredients (
    MealID INTEGER,
    IngredientID INTEGER,
    Quantity REAL,
    Unit VARCHAR(50),
    FOREIGN KEY (MealID) REFERENCES Meals(MealID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    PRIMARY KEY (MealID, IngredientID)
);


CREATE TABLE MealGoals (
    MealID INTEGER,
    GoalID INTEGER,
    PRIMARY KEY (MealID, GoalID),
    FOREIGN KEY (MealID) REFERENCES Meals(MealID),
    FOREIGN KEY (GoalID) REFERENCES Goals(GoalID)
);

CREATE TABLE MealRestrictions (
    MealID INTEGER,
    RestrictionID INTEGER,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID),
    FOREIGN KEY (RestrictionID) REFERENCES DietaryRestrictions(RestrictionID),
    PRIMARY KEY (MealID, RestrictionID)
);


CREATE TABLE Ingredients (
    IngredientID INTEGER PRIMARY KEY,
    IngredientName VARCHAR(255) NOT NULL UNIQUE,
    CaloricDensity REAL
);

CREATE TABLE UserMeals (
    UserMealID INTEGER PRIMARY KEY,
    UserID INTEGER,
    MealID INTEGER,
    CustomMealName VARCHAR(255), -- Allow users to input their own meal name
    MealDateTime DATETIME,
    TotalCalories REAL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MealID) REFERENCES Meals(MealID)
);

