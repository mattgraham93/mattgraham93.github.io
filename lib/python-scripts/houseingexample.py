## Import Libraries
import inline
import matplotlib
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import preprocessing
import xgboost as XGB
import sklearn.metrics as metrics
from sklearn.metrics import make_scorer
from sklearn.model_selection import KFold, cross_val_score
from sklearn.metrics import mean_squared_error
import math
from scipy.stats import norm, skew
import seaborn as sns
import warnings

warnings.filterwarnings('ignore')

print("######################## reading files")
train = pd.read_csv('train.csv')
test = pd.read_csv('test.csv')

print("########################get/show test and train size and columns")
train.shape, test.shape

# train.head()
# train.info()

print("######################## show basic statistics")
print(train['SalePrice'].describe())

print("######################## first plot, non-normalized")
sns.distplot(train['SalePrice'])
plt.show()
print("######################## show skew and skew direction")
print("Skewness: %f" % train['SalePrice'].skew())
print("Kurtosis: %f" % train['SalePrice'].kurt())

print("######################## normalize and plot")
train['SalePrice'] = np.log1p(train['SalePrice'])
sns.distplot(train['SalePrice'], fit=norm)
plt.show()

print("######################## create correlation heatmap")
corrmat = train.corr()
f, ax = plt.subplots(figsize=(12, 9))
sns.heatmap(corrmat, vmax=.8, square=True)
plt.show()

print("######################## show heatmap with major features where correlation is greater that 0.5")
corr = train.corr()
highest_corr_features = corr.index[abs(corr["SalePrice"]) > 0.5]
plt.figure(figsize=(10, 10))
sns.heatmap(train[highest_corr_features].corr(), annot=True, cmap="RdYlGn")
plt.show()

# print(corr["SalePrice"].sort_values(ascending=False))

print("######################## get most correlated columns from dataset")
cols = ['SalePrice', 'OverallQual', 'GrLivArea', 'GarageCars', 'TotalBsmtSF', 'FullBath', 'YearBuilt']

print("######################## print pairwise relationship dataplot")
sns.pairplot(train[cols])
plt.show()

print("######################## assign y-axis value to training dataset SalePrice and get all test IDs")
y_train = train['SalePrice']
test_id = test['Id']
print("######################## append train and test datasets along col headers")
all_data = pd.concat([train, test], axis=0, sort=False)
print("######################## remove all Id and SalesPrice info from all_data")
all_data = all_data.drop(['Id', 'SalePrice'], axis=1)

print("######################## get total number and percent of null values for each home sale")
Total = all_data.isnull().sum().sort_values(ascending=False)
percent = (all_data.isnull().sum() / all_data.isnull().count()).sort_values(ascending=False)
print("######################## get sum and percent of null values by feature")
missing_data = pd.concat([Total, percent], axis=1, keys=['Total', 'Percent'])
missing_data.head(25)

print("######################## remove all items from all data from features when Total is greater than 5")
all_data.drop((missing_data[missing_data['Total'] > 5]).index, axis=1, inplace=True)
# print(all_data.isnull().sum().max())

print("######################## show that all new totals represent now-removed needless/unimportant features")
total = all_data.isnull().sum().sort_values(ascending=False)
total.head(19)

print("######################## replace all missing/null numerics with 0")
numeric_missed = ['BsmtFinSF1',
                  'BsmtFinSF2',
                  'BsmtUnfSF',
                  'TotalBsmtSF',
                  'BsmtFullBath',
                  'BsmtHalfBath',
                  'GarageArea',
                  'GarageCars']

for feature in numeric_missed:
    all_data[feature] = all_data[feature].fillna(0)

print("######################## replace all missing/null numerics with mode value of each category")
categorical_missed = ['Exterior1st',
                      'Exterior2nd',
                      'SaleType',
                      'MSZoning',
                      'Electrical',
                      'KitchenQual']

for feature in categorical_missed:
    all_data[feature] = all_data[feature].fillna(all_data[feature].mode()[0])

print("######################## replace all functional types with typ")
all_data['Functional'] = all_data['Functional'].fillna('Typ')
print("######################## remove all utilities")
all_data.drop(['Utilities'], axis=1, inplace=True)

# print(all_data.isnull().sum().max())

print("######################## set number of numeric features to all items that are not an object's index")
numeric_feats = all_data.dtypes[all_data.dtypes != 'object'].index
print("######################## set number of skew features to passed-in skew value")
skew_feats = all_data[numeric_feats].apply(lambda x: skew(x)).sort_values(ascending=False)
print("######################## set highly-skewed values and set to series")
high_skew = skew_feats[abs(skew_feats) > 0.5]
high_skew

print("######################## normalize all highly-skewed data and set equal to new normal feature value")
for feature in high_skew.index:
    all_data[feature] = np.log1p(all_data[feature])

print("######################## create new column value for TotalSF")
all_data['TotalSF'] = all_data['TotalBsmtSF'] + all_data['1stFlrSF'] + all_data['2ndFlrSF']

print("######################## get dummies for all_data")
all_data = pd.get_dummies(all_data)
all_data.head()

x_train = all_data[:len(y_train)]
x_test = all_data[len(y_train):]

x_test.shape, x_train.shape

scorer = make_scorer(mean_squared_error, greater_is_better=False)


def rmse_CV_train(model):
    kf = KFold(5, shuffle=True, random_state=42).get_n_splits(x_train.values)
    rmse = np.sqrt(-cross_val_score(model, x_train, y_train, scoring="neg_mean_squared_error", cv=kf))
    return (rmse)


def rmse_CV_test(model):
    kf = KFold(5, shuffle=True, random_state=42).get_n_splits(train.values)
    rmse = np.sqrt(-cross_val_score(model, x_test, y_train, scoring="neg_mean_squared_error", cv=kf))
    return (rmse)


print("######################## build model")
the_model = XGB.XGBRegressor(colsample_bytree=0.4603, gamma=0.0468, learning_rate=0.05, max_depth=3,
                             min_child_weight=1.7817, reg_alpha=0.4640, reg_lambda=0.8572, subsample=0.5213,
                             random_state=7, n_estimators=2200, nthread=-1)
the_model.fit(x_train, y_train)

print("######################## predict new values")
y_predict = np.floor(np.expm1(the_model.predict(x_test)))
y_predict

sub = pd.DataFrame()
sub['Id'] = test_id
sub['SalePrice'] = y_predict

print("######################## export to csv")
sub.to_csv('mysubmission.csv', index=False)