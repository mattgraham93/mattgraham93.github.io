import numpy as np
import pandas as pd

# would like to get this into SQL, but let's start with just fixing the data
from pandas import DataFrame

file_name = "fixedSpend.xlsx"
file_save = "fixedSpend.xlsx"

vsd = pd.read_excel(file_name)

vsd.ReportingGC.unique()

vsd = vsd.replace(["Skanska Balfour Beatty", "SBB"], "GC1", regex=True)
vsd = vsd.replace("GLY Construction", "GC2", regex=True)
vsd = vsd.replace("Sellen Constuction Company, Inc", "GC3", regex=True)

subs = vsd["SubConsultant"]
unique_subs = subs.unique()
names = []

for i in range(len(unique_subs)):
    name = f"Sub{i+1}"
    names.append(name)

unique_sub_df: DataFrame = pd.DataFrame(unique_subs, columns=['GCName'])
i = 0
for sub in unique_subs:
    name = names[i]
    i += 1
    vsd = vsd.replace(sub, name, regex=True)

# vsd

print("---- writing to excel ----")
try:
    vsd.to_excel("test.xlsx")
    print("---- file saved successfully ----")
except Exception as e:
    print(e)
