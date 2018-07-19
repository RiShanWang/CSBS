# -*- coding: utf-8 -*-
"""
Created on Fri Sep  1 10:25:14 2017

@author: Mingjun Wang
@Project: Bloomberg Data Full Join
"""
import pandas as pd
#import numpy as np
from functools import reduce;
#from pandas import ExcelWriter
import datetime as dt
import os

#check FILE is exist, if it is, then delete it. input: full path of file
def checkFile(fileName):
    if os.path.isfile(fileName):
        os.remove(fileName)
        
todatdate = dt.datetime.today().strftime("%m_%d_%Y")
#blgdata = 'H:/Bloomberg Data/Data/' + todatdate + '.xlsx'
blgdata = r'\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg\Data\07_03_2018.xlsx'
xl = pd.ExcelFile(blgdata)
data_frames = []
for item in xl.sheet_names:
    df = pd.read_excel(blgdata, sheetname = item)
    data_frames.append(df)
    df_merged = reduce(lambda  left,right: pd.merge(left,right,on=['Date'], how='outer'), data_frames)
#sort data by date
df_merged_sort = df_merged.sort_values('Date',ascending=False)
##Replace "space" with "_" for header, so it can fit as header in database
##df_merged_sort.columns = [x.strip().replace(' ', '_') for x in df_merged_sort.columns]
#blgdata = r'C:\Users\mwang\Desktop\WMJ\Bloomberg\Data\\' + todatdate + '_AFTERJOIN.csv'
##Remove the index of dataframe
#df_merged_sort.to_csv(blgdata, index=False)

#dfagain = pd.read_csv(blgdata)
listq = []
for strq in df_merged_sort['Date']:
    #print (strq)
    listq.append(int(str(strq).replace('-','')[0:9]))
df_merged_sort['Date'] = listq
  
fulldata = r'\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg\Data\\' + todatdate + '_Final.csv'
checkFile(fulldata)
#Remove the index of dataframe
df_merged_sort.to_csv(fulldata,index=False)