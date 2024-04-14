import json
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
import pprint

filename = r"D:\Backup\repos\auth.json"
cert_file = r"D:\Backup\repos\musicalweather.pem"

with open(filename) as file:
    data = json.load(file)
    mongo_conn_st = data['musical_weather']

def get_client():
    return MongoClient(mongo_conn_st,
                       tls=True,
                       tlsCertificateKeyFile=cert_file,
                       server_api=ServerApi('1'))
