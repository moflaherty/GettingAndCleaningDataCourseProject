# =============================================================
# Author:      Michael O'Flaherty (michael@oflaherty.com)
# Create date: 6/18/2014
#
# Description: This script is designed to take raw data from 
#              the getdata_projectfiles_UCI HAR Dataset.zip for
#              the course project found here 
#              https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions
#              and perform these steps:
#
#              1. Merge the training and the test data sets to  
#                 create one data set.
#              2. Extract only the measurements on the mean and 
#                 standard deviation for each measurement. 
#              3. Uses descriptive activity names to name the 
#                 activities in the data set.
#              4. Appropriately label the data set with descriptive 
#                 variable names. 
#              5. Creates a second, independent tidy data set with 
#                 the average of each variable for each activity 
#                 and each subject. 
#
# Note:        It is recommended you read the file README.md for
#              proper use of this script.
# =============================================================

# =============================================================
#                       IMPORTANT! 
# Load the data.table package if needed.
# =============================================================
#install.packages("data.table")
library(data.table)

# =============================================================
#                       IMPORTANT! 
# Set the working directory to where the data is located.
# =============================================================
setwd("F:\\Documents\\eInvasion\\School\\Coursera\\John Hopkins University\\Data Science\\3 - Getting and Cleaning Data\\Course Project")

# store the file names of the files we want to process
activity_labels.file             <- "getdata_projectfiles_UCI HAR Dataset\\activity_labels.txt"
features.file                    <- "getdata_projectfiles_UCI HAR Dataset\\features.txt"

train.subject_train.file         <- "getdata_projectfiles_UCI HAR Dataset\\train\\subject_train.txt"
train.x_train.file               <- "getdata_projectfiles_UCI HAR Dataset\\train\\X_train.txt"
train.y_train.file               <- "getdata_projectfiles_UCI HAR Dataset\\train\\y_train.txt"

test.subject_test.file           <- "getdata_projectfiles_UCI HAR Dataset\\test\\subject_test.txt"
test.x_test.file                 <- "getdata_projectfiles_UCI HAR Dataset\\test\\X_test.txt"
test.y_test.file                 <- "getdata_projectfiles_UCI HAR Dataset\\test\\y_test.txt"

# define the column names and types for each file
activity_labels.column.names     <- c('ActivityId', 'Description')
activity_labels.column.types     <- c('integer',    'character')
activity_labels <- read.table(activity_labels.file,
    colClasses=activity_labels.column.types, 
    col.names=activity_labels.column.names)

# give the activity labels a cleaner description
activity_labels$NewDescription   <- c('Walking', 'WalkingUpstairs', 'WalkingDownstairs', 'Sitting', 'Standing', 'Laying')

features.column.names            <- c('FeatureId',  'Description')
features.column.types            <- c('integer'  ,  'character')
features <- read.table(features.file, 
    colClasses=features.column.types,
    col.names=features.column.names)

# since we want to exclude meanFreq in our grep later, trash those columns by changing the column
# name to something that won't be picked up in the grep
for (i in 1:561) {features$Description[i] <- gsub("meanFreq", "###", features$Description[i])}

# clean up the column headers; make them pretty!
for (i in 1:561) {features$Description[i] <- gsub("mean", "Mean", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub("std", "Std", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub("-", "", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub("\\(", "", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub("\\)", "", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub("gravity", "Gravity", features$Description[i])}
for (i in 1:561) {features$Description[i] <- gsub(",", "", features$Description[i])}

train.subject_train.column.names <- c('SubjectId')
train.subject_train.column.types <- c('integer')
train.subject_train <- read.table(train.subject_train.file,
                                  colClasses=train.subject_train.column.types,
                                  col.names=train.subject_train.column.names)

train.x_train.column.names       <- features$Description
train.x_train.column.types       <- c('numeric')
train.x_train <- read.table(train.x_train.file,
                            colClasses=train.x_train.column.types,
                            col.names=train.x_train.column.names)

train.y_train.column.names       <- c('ActivityId')
train.y_train.column.types       <- c('integer')
train.y_train <- read.table(train.y_train.file,
                            colClasses=train.y_train.column.types,
                            col.names=train.y_train.column.names)

# add the activity column description to the y_train as a factor
train.y_train$Activity <- as.factor(activity_labels$NewDescription[train.y_train$ActivityId])

test.subject_test.column.names   <- c('SubjectId')
test.subject_test.column.types   <- c('integer')
test.subject_test <- read.table(test.subject_test.file,
                                  colClasses=test.subject_test.column.types,
                                  col.names=test.subject_test.column.names)

test.x_test.column.names         <- features$Description
test.x_test.column.types         <- c('numeric')
test.x_test <- read.table(test.x_test.file,
                            colClasses=test.x_test.column.types,
                            col.names=test.x_test.column.names)

test.y_test.column.names         <- c('ActivityId')
test.y_test.column.types         <- c('integer')
test.y_test <- read.table(test.y_test.file,
                            colClasses=test.y_test.column.types,
                            col.names=test.y_test.column.names)

# add the activity column description to the y_test as a factor
test.y_test$Activity <- as.factor(activity_labels$NewDescription[test.y_test$ActivityId])

# get the column names we are interested in
cols <- grep("(Mean|StdX|StdY|StdZ)", features$Description, ignore.case=TRUE)

# combine the column data from the train sources
train <- cbind(train.subject_train, train.y_train, train.x_train[cols])

# combine the column data from the test sources
test <- cbind(test.subject_test, test.y_test, test.x_test[cols])

# merge the row data into one dataset
mergedData <- rbind(train, test)

# build the tidy dataset
idx <- 1
for (i in unique(mergedData$SubjectId)) {
  subject <- as.data.table(subset(mergedData, mergedData$SubjectId==i))
  for (j in 1:6){
    activity <- as.data.table(subset(subject, subject$ActivityId==j))
    activityRow <- activity[, lapply(.SD, mean), by = Activity]
    if (idx == 1) {
      tidy <- activityRow
    }
    else {
      tidy <- rbind(tidy, activityRow)
    }
    idx = idx + 1
  }
}

# write out the tidy dataset
write.table(tidy, file = "data\\tidyData.txt", append = FALSE, row.names = FALSE)

# DEBUG CODE
#test <- read.table("data\\tidyData.txt")