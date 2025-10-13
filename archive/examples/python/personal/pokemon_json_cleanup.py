import json

pokemon_file = r"/data/pokemon.json"

with open(pokemon_file) as f:
    data = json.load(f)

for record in data:
    print(record.index(3))
    # print(data[record].pa)
