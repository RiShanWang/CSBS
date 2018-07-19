# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this program for? ###

* Quick summary
Automaticly use Excel to collect data from Bloomberg terminal, then import data to database and microstrategy.


### How is work? ###

* Requirements
ONLY run program on the Bloomberg terminal with Bloomberg is running and login.
Need install Office Add-Ins or Excel Add-in from Bloomberg to the terminal.
ONLY Office 2013 compatible with Add-in.

* Summary of files
For Bloomberg Mortgage Data
On P Driver 
	1.List.xlsx is an excel file which contain data name and corresponding Bloomberg code
		address:\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg
		
On Bloomberg Terminal
	1.Createexcel.vbs is a script which using Bloomberg code through excel add-in download quarter and national level data.
		address:Downloads\Bloomberg Data\Last
	2.call_CreateExcel.bat is batch file which make vbs file execution easier. Because vbs file need to run in command line.
		address:Downloads\Bloomberg Data\Last
On Local Machine
	1.FullJoinFinal.py clean raw data
	
On Server
	1.Create_BLOOMBERG_MV.sql
		address:C:\Users\mwang\AppData\Roaming\SQL Developer

For Delinquency Data

On Local Machine
1.Merge.py clean raw data
	
On Server
1.Create_Delinquency_MV.sql
	address:C:\Users\mwang\AppData\Roaming\SQL Developer

Documents for step by step download and update workflow.

* Result
For Bloomberg Mortgage Data

On P Driver 
1.Output is an excel file contain all data with report date
	address:\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg\Data
	Format:<Month>_<Date>_Final.csv
2. A log file called Log_Last Run.txt, which is contain the last date of this program runs
	address:\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg

* Community or team contact
Mingjun Wang