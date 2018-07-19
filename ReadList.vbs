'--------------------------------------------------------
'New excel Generator for Bloomberg
'Aurther: Mingjun Wang
'Date: 09/13/2017
'--------------------------------------------------------

'Get current time in to a variable
dtmValue = Now()
numday = right("00" & Day(dtmValue) ,2)
nummonth = right("00" & Month(dtmValue) ,2)
numyear = Year(dtmValue)

'Main directory is current directory where vbs file is.
path = "\\csbs.local\files\CSBS\REGULATE\REGULATE 2017\Analytics and Research\Mingjun\Bloomberg"

'--------------------------------------------------------
'Log file
'--------------------------------------------------------

'For text file creation, reading and writing
Set fs = CreateObject("Scripting.FileSystemObject") 
'Location of log file 
tFilename = path & "\Log_Last Run.txt"

'Check log file
'if exist one, read it and using the time in the log file as start time
'If not exist log file, set start time to 01/01/1999, 
'and create a blank txt file as log file in the current directory call it "Log_Last Run.txt"
Sub LogTime(fs, tFilename, dtmValue)
    'Read date from last line of log file
    If (fs.FileExists(tFilename)) Then
    ELSE
        Set objFileToCreate = fs.CreateTextFile(tFilename, True)
        objFileToCreate.Close
        Set objFileToCreate = Nothing
    End If
    Set objFileToAdd = fs.OpenTextFile(tFilename, 8, True)
    objFileToAdd.WriteLine(right("00" & Month(dtmValue) ,2) & "/" & right("00" & Day(dtmValue),2) & "/" & Year(dtmValue))
    objFileToAdd.Close
    set objFileToAdd=Nothing
End sub    

'--------------------------------------------------------
'End of Log File Function

'--------------------------------------------------------


'--------------------------------------------------------
'Excel Functions
'--------------------------------------------------------

'Create the folder by use datepart functions
strDate = path & "\Data\"

'Set the save location of excel
strExcelPath = strDate & right("00" & Month(dtmValue) ,2) & "_" & right("00" & Day(dtmValue),2) & "_" & Year(dtmValue) & ".xlsx"

'Create the folders using objFSO
'First check if folders exists and create only they dont exist
if fs.FolderExists(strDate) Then
    'Check if excel is exists
    if fs.FileExists(strExcelPath) Then
	    fs.DeleteFile strExcelPath
    End If
Else
	'Create Top level folder first
	fs.CreateFolder(strDate)
End If

'Create Excel file
'Bind to the Excel object

ReDim arrCode(-1)
ReDim arrIname(-1)
Set objExcel = CreateObject("Excel.Application")
Set objWorkbook = objExcel.Workbooks.Open _
(path & "\list.xlsx")

intRow = 2

Do Until objExcel.Cells(intRow, 1).Value = ""
Bcode = objExcel.Cells(intRow, 1).Value
Redim Preserve arrCode(UBound(arrCode)+1)
arrCode(UBound(arrCode)) = Bcode
'READ THIRD COLUMN IN EXCEL
indexname = objExcel.Cells(intRow, 3).Value
Redim Preserve arrIname(UBound(arrIname)+1)
arrIname(UBound(arrIname)) = indexname

intRow = intRow + 1
Loop

'Load Bloomberg Excel Add-in.
objExcel.Workbooks.Open("C:\blp\API\Office Tools\BloombergUI.xla")

FID_LP = "PX_LAST"
'FID_MP = "PX_MID"
StartDate = """01/01/1900""," 
EndDate = "BToday(),"
'Period = """Period"",""D"""
Period = """Period"",""Q"""
for i = 0 To UBound(arrCode)
    Set objSheet = objExcel.ActiveWorkbook.Worksheets.Add
    objSheet.Cells(1, 1).Value = "QDATE"
    objSheet.Cells(1, 2).Value = arrIname(i)

    if arrCode(i) = "SPX Index" Then
        SPE = "PE RATIO"
        objSheet.Cells(2, 1).formula = "=BDH(" & """" & arrCode(i) & """," & """" &  _ 
        SPE & """," & StartDate & EndDate & Period & ")"
    else 
        objSheet.Cells(2, 1).formula = "=BDH(" & """" & arrCode(i) & """," & """" &  _ 
        FID_LP & """," & StartDate & EndDate & Period & ")"
    End if
    'For Excel Formula to run, wait 5 seconds
    WScript.Sleep(5000)

    'Use Special Paste change A2 from formula to actual value
    objSheet.Range("A2").Copy 
    'No 0,0 will work
    objSheet.Range("A2").PasteSpecial -4163,-4142
    Set objSheet = Nothing
Next
objExcel.displayalerts = false
objExcel.ActiveWorkBook.Worksheets("Sheet1").Delete
objExcel.displayalerts = True

'--------------------------------------------------------
' Save the spreadsheet and close the workbook
'--------------------------------------------------------

objExcel.ActiveWorkbook.SaveAs strExcelPath
objExcel.ActiveWorkbook.Close

'Quit Excel
objExcel.Application.Quit
 
'Clean Up
Set objExcel = Nothing

Call LogTime(fs, tFilename, dtmValue)
set fs=Nothing