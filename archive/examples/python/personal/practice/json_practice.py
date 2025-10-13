"""https://stackabuse.com/reading-and-writing-json-to-a-file-in-python/"""
import json

def main():
    # writing to JSON
    # data = {}
    # data['people'] = []
    # data['people'].append({
    #     'name': 'Scott',
    #     'website': 'stackabuse.com',
    #     'from': 'Nebraska'
    # })
    # data['people'].append({
    #     'name': 'Larry',
    #     'website': 'google.com',
    #     'from': 'Michigan'
    # })
    # data['people'].append({
    #     'name': 'Tim',
    #     'website': 'apple.com',
    #     'from': 'Alabama'
    # })
    #
    # with open('data.txt', 'w') as outfile:
    #     json.dump(data, outfile)

    # read json
    with open('data.txt') as json_file:
        data = json.load(json_file)
        # for p in data['people']:
        #     print('Name: ' + p['name'])
        #     print('Website: ' + p['website'])
        #     print('From: ' + p['from'])
        #     print('')
    pretty = json.dumps(data, sort_keys=True, indent=4)
    print(pretty)


if __name__ == "__main__":
    main()
