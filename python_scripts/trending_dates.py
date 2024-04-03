import json

# Load the JSON data from 'tracks.json'
with open('tracks.json', 'r') as file:
    tracks = json.load(file)

# Open a new CSV file to write the output
with open('trending_dates.csv', 'w') as output_file:
    # Write the CSV header
    output_file.write("TrackID,TrendingDate,PeakRank,AppearancesOnChart,ConsecutiveAppearancesOnChart\n")
    
    for track_id, track in enumerate(tracks, start=1):
        peak_rank = track['peakRank']
        appearances_on_chart = track['appearancesOnchart']
        consecutive_appearances_on_chart = track['consecutiveAppearancesOnChart']
        
        # Write each trending date with the track ID and other attributes
        for date in track['trendingWeek']:
            output_file.write(f"({track_id},{date},{peak_rank},{appearances_on_chart},{consecutive_appearances_on_chart}),\n")

print("Trending dates have been successfully written to 'trending_dates.csv'.")
