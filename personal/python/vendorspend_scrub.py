import numpy as np  # brought in before converting array to dataframe
import pandas as pd

# would like to get this into SQL, but let's start with just fixing the data
from pandas import DataFrame

# was original file name, removed for security
file_name = "spend.xlsx"
file_save = "fixedSpend.xlsx"

vsd = pd.read_excel(file_name)

# get unique GCs
vsd.ReportingGC.unique()
print("---- Replacing values -----")
# replace unique GC with anonymous identifier
vsd = vsd.replace(["Skanska Balfour Beatty", "SBB"], "GC1", regex=True)
vsd = vsd.replace("GLY Construction", "GC2", regex=True)
vsd = vsd.replace("Sellen Constuction Company, Inc", "GC3", regex=True)

# isolate unique sub consultants
subs = vsd["SubConsultant"]
unique_subs = subs.unique()
# create list for names
names = []
print("---- Getting unique vendors ----")
# create list of numbered sub consultants
for i in range(len(unique_subs)):
    name = f"Sub{i+1}"
    names.append(name)
print("---- Renaming vendors ----")
# convert unique_subs array to dataframe to replace values
unique_sub_df: DataFrame = pd.DataFrame(unique_subs, columns=['GCName'])
i = 0
# replace values
for sub in unique_subs:
    name = names[i]
    i += 1
    # replace seems to return with continue, must iterate through i first to get new name
    vsd = vsd.replace(sub, name, regex=True)

# vsd # display

print("---- writing to excel ----")
try:
    vsd.to_excel("test.xlsx")
    print("---- file saved successfully ----")
except Exception as e:
    print(e)
