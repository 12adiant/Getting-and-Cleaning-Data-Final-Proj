# Coursera Getting and Cleaning Data Final Project
# Michael Haseley michaelh@stamford.edu
# run_analysis.R Documentation:
# Project Data:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# run_analysis.R does the following:
# Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive variable names. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Clear Variables
rm(list=ls())

# Integrate the Training and Test Data sets

# Import data
ActType	<- read.table('./activity_labels.txt',header=FALSE)
Feat	<- read.table('./features.txt',header=FALSE) 
SubTst	<- read.table('./test/subject_test.txt',header=FALSE)
xTest	<- read.table('./test/x_test.txt',header=FALSE)
yTest	<- read.table('./test/y_test.txt',header=FALSE)
SubTrn	<- read.table('./train/subject_train.txt',header=FALSE) 
xTrain	<- read.table('./train/x_train.txt',header=FALSE)
yTrain	<- read.table('./train/y_train.txt',header=FALSE)

# Name Custom Columns
colnames(ActType)	<- c('activityId','activityType')
colnames(SubTst)	<- "subjectId"
colnames(xTest)		<- Feat[,2]
colnames(yTest)		<- "activityId"
colnames(SubTrn)	<- "subjectId"
colnames(xTrain)	<- Feat[,2]
colnames(yTrain)	<- "activityId"

# Create Initial Data Sets
TstData <- cbind(yTest,SubTst,xTest)
TrnData <- cbind(yTrain,SubTrn,xTrain)
FinData <- rbind(TstData,TrnData)

# Data Extraction
DumCol	<- colnames(FinData) 
VarSel	<- (grepl("activity..",DumCol) | grepl("subject..",DumCol) | grepl("-mean..",DumCol) & !grepl("-meanFreq..",DumCol) & !grepl("mean..-",DumCol) | grepl("-std..",DumCol) & !grepl("-std()..-",DumCol))

# Create Final Data Set
FinData	<- FinData[VarSel==TRUE]

# Assign Descriptive Activity Names
FinData	<- merge(FinData,ActType,by='activityId',all.x=TRUE)
#finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);
DumCol	<- colnames(FinData)

# Assign Meaningful Variable Names
for (i in 1:length(DumCol)) 
{
  DumCol[i] <- gsub("\\()","",DumCol[i])
  DumCol[i] <- gsub("-std$","StdDev",DumCol[i])
  DumCol[i] <- gsub("-mean","Mean",DumCol[i])
  DumCol[i] <- gsub("^(t)","Time",DumCol[i])
  DumCol[i] <- gsub("^(f)","Freq",DumCol[i])
  DumCol[i] <- gsub("([Gg]ravity)","Gravity",DumCol[i])
  DumCol[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",DumCol[i])
  DumCol[i] <- gsub("[Gg]yro","Gyro",DumCol[i])
  DumCol[i] <- gsub("AccMag","Acceleration",DumCol[i])
  DumCol[i] <- gsub("([Bb]odyaccjerkmag)","BodyJerk",DumCol[i])
  DumCol[i] <- gsub("JerkMag","Jerk",DumCol[i])
  DumCol[i] <- gsub("GyroMag","GyroMag",DumCol[i])
}
colnames(FinData) <- DumCol

# Create Tidy Data Set 
TblNoAct	<- FinData[,names(FinData) != 'activityType']
TidyData    <- aggregate(TblNoAct[,names(TblNoAct) != c('activityId','subjectId')],by=list(activityId=TblNoAct$activityId,subjectId = TblNoAct$subjectId),mean)
TidyData    <- merge(TidyData,ActType,by='activityId',all.x=TRUE);

#Write Tidy Data to txt file
write.table(TidyData, './TidyData.txt',row.names=TRUE,sep=',')

