import csv
import json


# Function to convert a CSV to JSON
# Takes the file paths as arguments
def make_json(csv_file_path, json_file_path):
    # create a dictionary
    data = {}

    # Open a csv reader called DictReader
    with open(csv_file_path, encoding='utf-8') as csvf:
        csv_reader = csv.DictReader(csvf)

        # Convert each row into a dictionary
        # and add it to data
        for rows in csv_reader:
            # Assuming a column named 'No' to
            # be the primary key
            key = rows['#']
            data[key] = rows

    # Open a json writer, and use the json.dumps()
    # function to dump data
    with open(json_file_path, 'w', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

# Driver Code

# Decide the two file paths according to your
# computer system
csv_file_path = r"C:\mattgraham93.github.io\DataSpellProjects\data\pokemon.csv"
json_file_path = r"C:\mattgraham93.github.io\DataSpellProjects\data\pokemon.json"

# Call the make_json function
print("running conversion")
make_json(csv_file_path, json_file_path)
print("complete")
