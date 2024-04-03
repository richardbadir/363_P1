import json

# Load the JSON data
with open('tracks.json', 'r') as file:
    tracks_data = json.load(file)

# Collect all unique contentRating values
content_ratings = set(track["contentRating"] for track in tracks_data if track.get("contentRating"))

# Initialize SQL statement
sql_statement = "INSERT INTO ContentRating (contentRatingName) VALUES"

# Iterate over unique content ratings
for rating in content_ratings:
    # Ensure the rating is not empty or null; adjust logic as needed
    if rating:
        # Add each content rating to the SQL statement
        sql_statement += f" ('{rating}'),"

# Remove the trailing comma
sql_statement = sql_statement.rstrip(',') + ';'

# Write the SQL statement to a file
with open('content_rating_inserts.sql', 'w') as sql_file:
    sql_file.write(sql_statement)

print("SQL statement saved to content_rating_inserts.sql")
