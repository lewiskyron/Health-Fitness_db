import os
import sqlite3

# Database file path
db_file = "database.db"

print("Creating the database...")
# Check if the database file exists and delete it
if os.path.exists(db_file):
    os.remove(db_file)


# Connect to the database
conn = sqlite3.connect(db_file)
cursor = conn.cursor()
print("Database created successfully")


print("Creating the tables...")
# Read and execute the schema SQL script
with open("schema_lite.sql", "r") as schema_file:
    schema_script = schema_file.read()
    cursor.executescript(schema_script)
print("Tables created successfully")


print("Inserting the base data...")
# Read and execute the base_data.sql SQL script
with open("base.sql", "r") as base_data_file:
    base_data_script = base_data_file.read()
    cursor.executescript(base_data_script)
print("Base data inserted successfully")

# Commit the changes and close the connection
conn.commit()
conn.close()


# run the fake_data script
print("Inserting the fake data...")
os.system("python fake_data.py")
print("Fake data inserted successfully")