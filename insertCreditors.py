import json

# Load tracks data from the file
with open('tracks.json', 'r') as file:
    tracks_data = json.load(file)

creditor_id_counter = 1
creditors = {}

# Lists to accumulate insert values for each table
creditors_values = []
performers_values = []
producers_values = []
writers_values = []

for track in tracks_data:
    for creditor in track.get('creditors', []):
        name = creditor.get('name')
        role = creditor.get('role')
        creditor_uri = creditor.get('creditorUri', '')

        if name not in creditors:
            creditors[name] = creditor_id_counter
            # Appending values with a new line at the end
            creditors_values.append(f"({creditor_id_counter}, '{name.replace("'", "''")}', '{role}')")
            creditor_id_counter += 1

        # Prepare values for child tables based on role
        if role == 'Performers':
            performers_values.append(f"({creditors[name]}, '{creditor_uri}')")
        elif role == 'Producers':
            producers_values.append(f"({creditors[name]}, '{creditor_uri}')")
        elif role == 'Writers':
            writers_values.append(f"({creditors[name]}, '{creditor_uri}')")

# Construct the final INSERT statements with values on new lines
sql_statements = [
    f"INSERT INTO Creditors (CreditorID, Name, Role) VALUES\n" + ",\n".join(creditors_values) + ";" if creditors_values else "",
    f"INSERT INTO Performers (CreditorID, PerformerURI) VALUES\n" + ",\n".join(performers_values) + ";" if performers_values else "",
    f"INSERT INTO Producers (CreditorID, ProducerURI) VALUES\n" + ",\n".join(producers_values) + ";" if producers_values else "",
    f"INSERT INTO Writers (CreditorID, WriterURI) VALUES\n" + ",\n".join(writers_values) + ";" if writers_values else ""
]

# Filter out empty statements
sql_statements = [stmt for stmt in sql_statements if stmt]

# Save the SQL statements to a file
with open('populate_creditors_final.sql', 'w') as sql_file:
    sql_file.write('\n'.join(sql_statements))

print("Final SQL file with new lines has been generated.")
