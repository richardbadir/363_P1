import json

# Load the JSON data
with open('tracks.json', 'r') as file:
    tracks_data = json.load(file)

# Initialize SQL statement
sql_statement = "INSERT INTO Tracks (TrackName, TrackUri, Labels, ReleaseDate, Duration, PlayCount) VALUES\n"

# Iterate over tracks data and add attributes to the SQL statement
for track in tracks_data:
    # Replace single quotes within string fields with double quotes
    track_name = track['trackName'].replace("'", '"')
    track_uri = track['trackUri'].replace("'", '"')
    labels = ", ".join(track["labels"]).replace("'", '"')
    release_date = track['releaseDate'].replace("'", '"')
    if release_date == '':
        sql_statement += f"('{track_name}', '{track_uri}', '{labels}', NULL, {track['duration']}, {track['playcount']}),\n"
    else:
        sql_statement += f"('{track_name}', '{track_uri}', '{labels}', '{release_date}', {track['duration']}, {track['playcount']}),\n"

# Remove the trailing comma and newline
sql_statement = sql_statement.rstrip(',\n') + ';'

# Write the SQL statement to a new file
with open('tracks_inserts.sql', 'w', encoding='utf-8') as sql_file:
    sql_file.write(sql_statement)

print("SQL statement saved to tracks_inserts.sql")
