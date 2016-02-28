Code Book
Getting and Cleaning Data Final Project

This file will describe each variable in the run_analysis.R script, as well as give a general description of the way the code is meant to function.

Variables:
Imported Raw Data Sets
•	activity_labels.txt = ActType
•	subject_train.txt = SubTrn
•	x_train.txt = xTrain
•	y_train.txt = yTrain
•	subject_test.txt = SubTst
•	x_test.txt = xTest
•	y_test.txt = yTest
•	features.txt
Initial Data Sets
•	Extracted Test Data = TstData
•	Extracted Training Data = TrnData
•	Combined Test and Training Data = FinData
Placeholder Dummy Variables
•	Dummy Column = DumCol
•	Selected Variables Swap = VarSel
•	Initial Tidy set with no activity names = TblNoAct
•	Final Tidy Data Set = TidyData

Code Functionality

WorkSpace Cleared
Raw Data Imported into Variables described above
Appropriate Columns extracted from Raw Data Sets into newly created variables
Initial Data Sets Created then Merged into FinData
Data extracted using grepl and Dummy Column for subset
Extracted Data Merged into FinData
Meaningful variable names assigned to Columns using gsub for loop and dummy column
Activity Type Assigned and appended to FinData
TidyData.txt written to file using write.tables with comma seperated values
