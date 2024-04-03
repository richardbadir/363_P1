import json

with open('tracks.json', 'r') as file:
    track_data = json.load(file)

creditors ={}
track_id = 1
creditor_id =1

sql_statement = "INSERT IGNORE INTO TrackCreditors (TrackID, CreditorID) VALUES\n"
for track in track_data:

    # Insert creditors into Creditors table and TrackCreditors table
    for creditor in track.get('creditors', []):
        # Check if creditor already exists
        
        if creditor["name"] in creditors.keys():
            temp_creditor_id = creditors[creditor["name"]]
        else:
            temp_creditor_id=creditor_id
            creditors[creditor["name"]]=creditor_id
            creditor_id+=1
        sql_statement += f"({track_id}, {creditor_id}),\n"
        
    track_id+=1
# Remove the trailing comma and newline
sql_statement = sql_statement.rstrip(',\n') + ';'

# Write the SQL statement to a new file
with open('tracks_creditors_inserts.sql', 'w', encoding='utf-8') as sql_file:
    sql_file.write(sql_statement)

print("SQL statement saved to tracks_creditors_inserts.sql")

