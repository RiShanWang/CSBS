# -*- coding: utf-8 -*-
"""
Created on Mon Jan 29 10:14:06 2018

@author: mwang
"""

import pandas as pd
import os
import datetime as dt

def reverseQuarter(string):
    str1 = string[3:] + string[1:2]
    return str1

#check FILE is exist, if it is, then delete it. input: full path of file
def checkFile(fileName):
    if os.path.isfile(fileName):
        os.remove(fileName)
        
totalloan = r'\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Delinquency\grid1_ui4zey0f_number.xlsx'
delinnumber = r'\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Delinquency\grid1_1dfmug1c_rate.xlsx'
df1 = pd.read_excel(totalloan, sheetname='Worksheet', index = 'true')
#df1.drop(df1.index[[0,9]])
#df1.drop('National Delinquency Survey, All Loans', inplace=True)
df2 = pd.read_excel(delinnumber, sheetname='Worksheet', index = 'true')
#df2.drop(df2.index[[0,9]])
#df2.drop('National Delinquency Survey, All Loans', inplace=True)
#fill df1 null cell with df2 cell at same location
df1.update(df2)
df1.drop('National Delinquency Survey, All Loans', inplace=True)
df3 = pd.DataFrame()
for i in range(0, 586, 9):
    #select each block of the area
    df = df1.iloc[i:i+9]
    #transpose row to column 
    df = df.transpose()
    #get area name
    a = df.columns[0]
    #insert new column name is 'Geo' with area name
    df.insert(1,"GEO", a)
    #reset all column name
    df.columns = ['ee','GEO',
                      'TOTAL_NUMBER_LOANS_SERVICED',
                      'TOTAL_PAST_DUE',
                      'OVER_30DAYS',
                      'OVER_60DAYS',
                      'OVER_90PLUSDAYS',
                      'FORECLO_INVENTORY_END_QUARTER',
                      'FORECLO_STARTED_DURING_QUARTER',
                      'SERIOUSLY_DELINQUENT']
    #delete the one I donot need 
    df.drop(['ee'], axis = 1, inplace = True)
    #insert new column with new name and value is the index
    df.insert(0,"QUARTER_ID", df.index)
    df3 = df3.append(df)
    
listq = []
for strq in df3['QUARTER_ID']:
    listq.append(reverseQuarter(strq))

df3['QUARTER_ID'] = listq
#Replace all value in dataframe
df4 = df3.replace(['--'], ['']) 

todatdate = dt.datetime.today().strftime("%m_%d_%Y")
fulldata = r'\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Delinquency\Clean Data\\' + todatdate + 'fulldatant.csv'
checkFile(fulldata)
#Remove the index of dataframe
df4.to_csv(fulldata,index=False)