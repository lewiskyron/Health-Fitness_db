import sqlite3
import random
import string
import hashlib
from faker import Faker
from datetime import datetime, timedelta
import calendar

# Initialize Faker
fake = Faker()

# Define a list of meal names
meal_names = [
    "Meal 1",
    "Meal 2",
    "Meal 3",
    "Custom Dish 1",
    "Custom Dish 2",
    "Special Meal",
    "Homemade Recipe",
]


# Database connection setup
def get_db_connection():
    return sqlite3.connect("database.db")


# User generation and insertion
def generate_users(num_users=10):
    users = []
    for _ in range(num_users):
        first_name = fake.first_name()
        last_name = fake.last_name()
        dob = fake.date_of_birth().strftime("%Y-%m-%d")
        sex = random.choice(["Male", "Female"])
        height = round(random.uniform(1.5, 2.0), 2)
        weight = round(random.uniform(50, 100), 2)
        bmr = round(10 * weight + 6.25 * height * 100 - 5 * 30 + 5, 2)

        users.append((first_name, last_name, dob, sex, height, weight, bmr))

    return users


def insert_users_to_db(users_data):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.executemany(
        "INSERT INTO Users (FirstName, LastName, DateOfBirth, Sex, Height, Weight, BMR) VALUES (?, ?, ?, ?, ?, ?, ?)",  # noqa
        users_data,
    )

    conn.commit()

    user_ids = [i for i in range(1, len(users_data) + 1)]
    print(user_ids)

    conn.close()
    return user_ids


# Authentication data generation and insertion
def generate_auth_data(user_ids):
    auth_data = []
    for user_id in user_ids:
        username = fake.user_name()
        raw_password = "".join(
            random.choices(string.ascii_letters + string.digits, k=8)
        )
        hashed_password = hashlib.sha256(raw_password.encode()).hexdigest()
        email = fake.email()

        auth_data.append((user_id, username, hashed_password, email))

    return auth_data


def insert_auth_to_db(auth_data):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO Authentication (UserID, Username, HashedPassword, Email) VALUES (?, ?, ?, ?)",  # noqa
        auth_data,
    )

    conn.commit()
    conn.close()


# User dietary restrictions generation and insertion
def generate_user_dietary_restrictions(user_ids, num_restrictions=2):
    user_dietary_restrictions = []
    restriction_ids = list(
        range(1, 7)
    )  # Assuming restriction IDs 1-6 based on your list

    for user_id in user_ids:
        # Randomly decide whether to assign a dietary restriction
        if random.choice([True, False]):
            chosen_restrictions = random.sample(
                restriction_ids, num_restrictions
            )  # noqa
            for restriction_id in chosen_restrictions:
                user_dietary_restrictions.append((user_id, restriction_id))

    return user_dietary_restrictions


def insert_user_dietary_restrictions_to_db(user_dietary_restrictions):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO UserDietaryRestrictions (UserID, RestrictionID) VALUES (?, ?)",
        user_dietary_restrictions,
    )

    conn.commit()
    conn.close()


def generate_user_health_goals(user_ids):
    user_health_goals = []
    for user_id in user_ids:
        chosen_goal = random.choice([1, 2])
        user_health_goals.append((user_id, chosen_goal))

    return user_health_goals


def insert_user_health_goals_to_db(user_health_goals):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO UserHealthGoals (UserID, GoalID) VALUES (?, ?)",
        user_health_goals,
    )

    conn.commit()
    conn.close()


def generate_workout_sessions(user_ids, sessions_per_user=10):
    workout_sessions = []
    start_date = datetime(2023, 11, 1)  # October 1st
    end_date = datetime(2023, 11, 24)  # October 11th

    for user_id in user_ids:
        for _ in range(sessions_per_user):
            # Generate a random date and time between start_date and end_date
            session_date = start_date + timedelta(
                days=random.randint(0, (end_date - start_date).days),
                seconds=random.randint(0, 86400),  # Random seconds in a day
            )
            workout_sessions.append(
                (user_id, session_date.strftime("%Y-%m-%d %H:%M:%S"))
            )

    return workout_sessions


def insert_workout_sessions_to_db(workout_sessions):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO WorkoutSessions (UserID, SessionDate) VALUES (?, ?)",
        workout_sessions,
    )

    conn.commit()
    conn.close()


def generate_and_insert_exercise_details(user_ids):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    for user_id in user_ids:
        # Retrieve the user's health goal
        cursor.execute(
            "SELECT GoalID FROM UserHealthGoals WHERE UserID = ?", (user_id,)
        )
        goal_id = cursor.fetchone()[0]

        # Find workout types for this goal
        cursor.execute(
            "SELECT WorkoutTypeID FROM GoalWorkoutMapping WHERE GoalID = ?",
            (goal_id,),  # noqa
        )
        workout_types = [row[0] for row in cursor.fetchall()]

        # Retrieve session IDs for this user
        cursor.execute(
            "SELECT SessionID FROM WorkoutSessions WHERE UserID = ?", (user_id,)
        )
        session_ids = [row[0] for row in cursor.fetchall()]

        for session_id in session_ids:
            for workout_type in workout_types:
                # Select exercises for this workout type
                cursor.execute(
                    "SELECT ExerciseID FROM Exercises WHERE WorkoutTypeID = ?",
                    (workout_type,),
                )
                exercises = [row[0] for row in cursor.fetchall()]

                # Choose 5 unique exercises for the session
                chosen_exercises = random.sample(
                    exercises, min(5, len(exercises))
                )  # noqa

                # Randomly generate exercise details for each chosen exercise
                for exercise_id in chosen_exercises:
                    duration = random.randint(10, 60)  # Duration in minutes
                    cursor.execute(
                        "INSERT INTO ExerciseDetails (SessionID, ExerciseID, TotalTimeInMinutes) VALUES (?, ?, ?)",  # noqa
                        (session_id, exercise_id, duration),
                    )

    conn.commit()
    conn.close()


def generate_and_insert_progress_tracking(user_ids):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    for user_id in user_ids:
        # Retrieve all exercises done by the user
        cursor.execute(
            "SELECT ExerciseID FROM ExerciseDetails JOIN WorkoutSessions ON ExerciseDetails.SessionID = WorkoutSessions.SessionID WHERE UserID = ? GROUP BY ExerciseID",
            (user_id,),
        )
        exercises = cursor.fetchall()

        for exercise in exercises:
            exercise_id = exercise[0]

            # Find the session with the maximum duration for this exercise
            cursor.execute(
                "SELECT MAX(TotalTimeInMinutes), WorkoutSessions.SessionDate FROM ExerciseDetails JOIN WorkoutSessions ON ExerciseDetails.SessionID = WorkoutSessions.SessionID WHERE UserID = ? AND ExerciseID = ?",
                (user_id, exercise_id),
            )
            max_duration, session_date = cursor.fetchone()

            # Insert or update the ProgressTracking table
            cursor.execute(
                "INSERT OR REPLACE INTO ProgressTracking (UserID, ExerciseID, PersonalRecord, PRDate) VALUES (?, ?, ?, ?)",
                (user_id, exercise_id, max_duration, session_date),
            )

    conn.commit()
    conn.close()


def generate_daily_sleep_data(user_ids):
    daily_sleep_data = []
    for user_id in user_ids:
        # Generate sleep data for October and November
        for month in [10, 11]:  # October and November
            for day in range(1, 32):  # Assuming 31 days for simplicity
                try:
                    # Create a date object for the current day
                    date = datetime(year=2023, month=month, day=day)

                    # Random sleep start time between 8:00 PM (20:00) and 12:00 midnight (24:00)
                    sleep_start_hour = random.randint(20, 23)
                    sleep_start_minute = random.randint(0, 59)
                    sleep_start = datetime.combine(
                        date, datetime.min.time()
                    ) + timedelta(hours=sleep_start_hour, minutes=sleep_start_minute)

                    # Random wake-up time between 4:30 AM and 11:00 AM the next day
                    wake_up_hour = random.randint(4, 10)
                    wake_up_minute = 30 if wake_up_hour == 4 else random.randint(0, 59)
                    sleep_end = datetime.combine(date, datetime.min.time()) + timedelta(
                        days=1, hours=wake_up_hour, minutes=wake_up_minute
                    )

                    # Calculate sleep duration in hours
                    sleep_duration = round(
                        (sleep_end - sleep_start).total_seconds() / 3600, 2
                    )
                    daily_sleep_data.append(
                        (user_id, sleep_start, sleep_end, sleep_duration)
                    )
                except ValueError:
                    # Skip invalid dates (like October 31st)
                    continue

    return daily_sleep_data


def insert_daily_sleep_to_db(daily_sleep_data):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO DailySleep (UserID, SleepStart, SleepEnd, SleepDuration) VALUES (?, ?, ?, ?)",
        daily_sleep_data,
    )

    conn.commit()
    conn.close()


def generate_and_insert_monthly_sleep_average(user_ids):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    for user_id in user_ids:
        cursor.execute(
            "SELECT strftime('%Y-%m', SleepStart) AS YearMonth, AVG(SleepDuration) FROM DailySleep WHERE UserID = ? GROUP BY YearMonth",  # noqa
            (user_id,),
        )
        monthly_averages = cursor.fetchall()

        for year_month, avg_sleep in monthly_averages:
            # Round the average sleep duration to two decimal places
            avg_sleep_rounded = round(avg_sleep, 2)

            cursor.execute(
                "INSERT INTO MonthlySleepAverage (UserID, YearMonth, AverageSleepHours) VALUES (?, ?, ?)",  # noqa
                (user_id, year_month, avg_sleep_rounded),
            )

    conn.commit()
    conn.close()


def generate_user_meals(user_ids):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    fake = Faker()

    user_meals_data = []

    for user_id in user_ids:
        # Get the user's goal ID
        cursor.execute(
            "SELECT GoalID FROM UserHealthGoals WHERE UserID = ?", (user_id,)
        )
        goal_id = cursor.fetchone()[0]

        # Get the meal IDs that align with the user's goal
        cursor.execute("SELECT MealID FROM MealGoals WHERE GoalID = ?", (goal_id,))
        goal_meals = [row[0] for row in cursor.fetchall()]

        # Get the user's dietary restrictions
        cursor.execute(
            "SELECT RestrictionID FROM UserDietaryRestrictions WHERE UserID = ?",
            (user_id,),
        )
        user_restrictions = [row[0] for row in cursor.fetchall()]

        # Loop for 5 days
        for day in range(5):
            start_date = datetime.now() - timedelta(days=5)
            day_date = start_date + timedelta(days=day)

            for _ in range(3):  # Three meals per day
                selected_meal_id = random.choice(goal_meals)

                # Check for dietary restrictions
                cursor.execute(
                    "SELECT RestrictionID FROM MealRestrictions WHERE MealID = ?",
                    (selected_meal_id,),
                )
                meal_restrictions = [row[0] for row in cursor.fetchall()]

                while any(
                    restriction in meal_restrictions
                    for restriction in user_restrictions
                ):
                    selected_meal_id = random.choice(goal_meals)
                    cursor.execute(
                        "SELECT RestrictionID FROM MealRestrictions WHERE MealID = ?",
                        (selected_meal_id,),
                    )
                    meal_restrictions = [row[0] for row in cursor.fetchall()]

                # Generate a random date and time for the meal
                # Generate a random time on the same day
                meal_date_time = fake.date_time_between_dates(
                    datetime_start=day_date,
                    datetime_end=day_date + timedelta(days=1),
                )

                cursor.execute(
                    "SELECT TotalCalories FROM Meals WHERE MealID = ?",
                    (selected_meal_id,),
                )
                result = cursor.fetchone()
                if result:
                    total_calories = result[0]
                else:
                    total_calories = round(random.uniform(300, 800), 2)

                custom_meal_name = (
                    "recommendation" if selected_meal_id in goal_meals else fake.word()
                )

                user_meals_data.append(
                    (
                        user_id,
                        selected_meal_id,
                        custom_meal_name,
                        meal_date_time,
                        total_calories,
                    )
                )

    conn.close()
    return user_meals_data


def insert_user_meals_to_db(user_meals_data):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    cursor.executemany(
        "INSERT INTO UserMeals (UserID, MealID, CustomMealName, MealDateTime, TotalCalories) VALUES (?, ?, ?, ?, ?)",  # noqa
        user_meals_data,
    )

    conn.commit()
    conn.close()


def main():
    # Insert users
    users_data = generate_users(10)
    user_ids = insert_users_to_db(users_data)

    # Insert authentication data
    auth_data = generate_auth_data(user_ids)
    insert_auth_to_db(auth_data)

    # Insert dietary restrictions and user dietary restrictions
    user_dietary_restrictions = generate_user_dietary_restrictions(user_ids)
    insert_user_dietary_restrictions_to_db(user_dietary_restrictions)

    # Insert user health goals
    user_health_goals = generate_user_health_goals(user_ids)
    insert_user_health_goals_to_db(user_health_goals)

    workout_sessions = generate_workout_sessions(user_ids)
    insert_workout_sessions_to_db(workout_sessions)
    generate_and_insert_exercise_details(user_ids)

    generate_and_insert_progress_tracking(user_ids)

    daily_sleep_data = generate_daily_sleep_data(user_ids)
    insert_daily_sleep_to_db(daily_sleep_data)

    generate_and_insert_monthly_sleep_average(user_ids)

    user_meals_data = generate_user_meals(user_ids)
    insert_user_meals_to_db(user_meals_data)


if __name__ == "__main__":
    main()
