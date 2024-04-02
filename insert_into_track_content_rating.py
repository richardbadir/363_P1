import json

with open('tracks.json', 'r') as file:
    track_data = json.load(file)

creditors ={}
track_id = 1

sql_statement = "INSERT IGNORE INTO TrackContentRating (TrackID, contentRatingName) VALUES\n"
for track in track_data:

    sql_statement += f"({track_id}, '{track['contentRating']}'),\n"
        
    track_id+=1
# Remove the trailing comma and newline
sql_statement = sql_statement.rstrip(',\n') + ';'

# Write the SQL statement to a new file
with open('tracks_contentRating_inserts.sql', 'w', encoding='utf-8') as sql_file:
    sql_file.write(sql_statement)

print("SQL statement saved to tracks_contentRating_inserts.sql")

