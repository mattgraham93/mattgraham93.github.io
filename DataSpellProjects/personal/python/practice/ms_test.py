import json

filename = "file1"

recs = json.load(filename)

"""
    get hashes from main datasource

    when a file is received with specified name
        get records in current file

    identify duplicate records within file
        get distinct

    generate unique hash for record
        need hashing -- keys will become very big, need key that is condensed and small
        generate hash key, assign to JSON combination
    
    for unique hash in record:
        {
            key:
                {
                    name:
                    age:
                    gender:
                }
        }

        if it does exist, continue

    otherwise, insert into datasource

"""