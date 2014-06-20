###CodeBook.md
=========
Author: Michael O'Flaherty (michael@oflaherty.com)

Create date: 6/19/2014

####Overview
This document details the data contained in the **tidyData.txt** file created from the **run_analysis.R** file.

####Source Data
The source data was provided in a zip file called **getdata_projectfiles_UCI HAR Dataset.zip**. The read me contained in the source data provides some important information about the collection of the data and also the licensing, so that is copied here:

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#####Notes
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

#####License
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

####TidyData.txt
**TidyData.txt** can be loaded into R or RStudio using this command: `tidyData <- read.table("data\\tidyData.txt")`. The dataset is created by merging these files into a single dataset first:

**File**   | **Description** 
------------ | ------------- | -------------
activity_labels.txt | Contains ids and descriptions of all activities in the system. There are 6 activities defined and they are detailed in the next section.
features.txt | Contains ids and descriptions of all features. There are 561 different features, but for the dataset, we are only interested in the mean and standard deviation columns which contains 64 variables. They are defined in the next section. There is a document called **features_info.txt** in the source zip that provides additional information about these individual features.
subject_train.txt / subject_test.txt | These files contain the subject ids from the train and test datasets. These datasets were combined when creating the tidy dataset.
X_train.txt / X_test.txt | These files contain the actual results based on features (561 columns) and activities (rows.) These datasets were combined when creating the tidy dataset.
y_train.txt / y_test.txt | These files contain the activity ids for the X datasets. These datasets were combined when creating the tidy dataset.

#####Structure
The tidy dataset contains an average for each of the 64 variables that were used--one per subject/activity. Each subject will have 6 rows (6 activities) which will equal 180 observations (30 subjects * 6 activities.) The structure is as follows:

`Subject Id | Activity Id | Activity | Feature 1 -----------> Feature 64`

Note: all fields will contain values (non-nullable/no NA's.)

#####Fields
**Column**   | **Data Type** | **Source** 
------------ | ------------- | -------------
SubjectId | Numeric | subject_train.txt / subject_test.txt. The source file only contained one column which is the subject identifier.
ActivityId | Numeric |  activity_labels.txt. Column one is the identifier field. Allowable values are 1 through 6 and you can see the Id/Descriptions defined in the Activity column definition for their definitions.
Activity | Factor |  This factor is created from the activity_labels.txt column two description field. The original descriptions were in all caps; the tidy dataset has proper-case versions of these descriptions. Valid values (Id-Description) are: 1-Walking, 2-WalkingUpstairs, 3-WalkingDownstairs, 4-Sitting, 5-Standing, and 6-Laying.
tBodyAccMeanX | Numeric | tBodyAcc-mean()-X -- the average mean per subject-activity
tBodyAccMeanY | Numeric | tBodyAcc-mean()-Y -- the average mean per subject-activity 
tBodyAccMeanZ | Numeric | tBodyAcc-mean()-Z -- the average mean per subject-activity
tBodyAccStdX | Numeric | tBodyAcc-std()-X -- the average standard deviation per subject-activity
tBodyAccStdY | Numeric | tBodyAcc-std()-Y -- the average standard deviation per subject-activity
tBodyAccStdZ | Numeric | tBodyAcc-std()-Z -- the average standard deviation per subject-activity
tGravityAccMeanX | Numeric | tGravityAcc-mean()-X -- the average mean per subject-activity
tGravityAccMeanY | Numeric | tGravityAcc-mean()-Y -- the average mean per subject-activity
tGravityAccMeanZ | Numeric | tGravityAcc-mean()-Z -- the average mean per subject-activity
tGravityAccStdX | Numeric | tGravityAcc-std()-X -- the average standard deviation per subject-activity
tGravityAccStdY | Numeric | tGravityAcc-std()-Y -- the average standard deviation per subject-activity
tGravityAccStdZ | Numeric | tGravityAcc-std()-Z -- the average standard deviation per subject-activity
tBodyAccJerkMeanX | Numeric | tBodyAccJerk-mean()-X -- the average mean per subject-activity
tBodyAccJerkMeanY | Numeric | tBodyAccJerk-mean()-Y -- the average mean per subject-activity
tBodyAccJerkMeanZ | Numeric | tBodyAccJerk-mean()-Z -- the average mean per subject-activity
tBodyAccJerkStdX | Numeric | tBodyAccJerk-std()-X -- the average standard deviation per subject-activity
tBodyAccJerkStdY | Numeric | tBodyAccJerk-std()-Y -- the average standard deviation per subject-activity
tBodyAccJerkStdZ | Numeric | tBodyAccJerk-std()-Z -- the average standard deviation per subject-activity
tBodyGyroMeanX | Numeric | tBodyGyro-mean()-X -- the average mean per subject-activity
tBodyGyroMeanY | Numeric | tBodyGyro-mean()-Y -- the average mean per subject-activity
tBodyGyroMeanZ | Numeric | tBodyGyro-mean()-Z -- the average mean per subject-activity
tBodyGyroStdX | Numeric | tBodyGyro-std()-X -- the average standard deviation per subject-activity
tBodyGyroStdY | Numeric | tBodyGyro-std()-Y -- the average standard deviation per subject-activity
tBodyGyroStdZ | Numeric | tBodyGyro-std()-Z -- the average standard deviation per subject-activity
tBodyGyroJerkMeanX | Numeric | tBodyGyroJerk-mean()-X -- the average mean per subject-activity
tBodyGyroJerkMeanY | Numeric | tBodyGyroJerk-mean()-Y -- the average mean per subject-activity
tBodyGyroJerkMeanZ | Numeric | tBodyGyroJerk-mean()-Z -- the average mean per subject-activity
tBodyGyroJerkStdX | Numeric | tBodyGyroJerk-std()-X -- the average standard deviation per subject-activity
tBodyGyroJerkStdY | Numeric | tBodyGyroJerk-std()-Y -- the average standard deviation per subject-activity
tBodyGyroJerkStdZ | Numeric | tBodyGyroJerk-std()-Z -- the average standard deviation per subject-activity
tBodyAccMagMean | Numeric | tBodyAccMag-mean() -- the average mean per subject-activity
tGravityAccMagMean | Numeric | tGravityAccMag-mean() -- the average mean per subject-activity
tBodyAccJerkMagMean | Numeric | tBodyAccJerkMag-mean() -- the average mean per subject-activity
tBodyGyroMagMean | Numeric | tBodyGyroMag-mean() -- the average mean per subject-activity
tBodyGyroJerkMagMean | Numeric | tBodyGyroJerkMag-mean() -- the average mean per subject-activity
fBodyAccMeanX | Numeric | fBodyAcc-mean()-X -- the average mean per subject-activity
fBodyAccMeanY | Numeric | fBodyAcc-mean()-Y -- the average mean per subject-activity
fBodyAccMeanZ | Numeric | fBodyAcc-mean()-Z -- the average mean per subject-activity
fBodyAccStdX | Numeric | fBodyAcc-std()-X -- the average standard deviation per subject-activity
fBodyAccStdY | Numeric | fBodyAcc-std()-Y -- the average standard deviation per subject-activity
fBodyAccStdZ | Numeric | fBodyAcc-std()-Z -- the average standard deviation per subject-activity
fBodyAccJerkMeanX | Numeric | fBodyAccJerk-mean()-X -- the average mean per subject-activity
fBodyAccJerkMeanY | Numeric | fBodyAccJerk-mean()-Y -- the average mean per subject-activity
fBodyAccJerkMeanZ | Numeric | fBodyAccJerk-mean()-Z -- the average mean per subject-activity
fBodyAccJerkStdX | Numeric | fBodyAccJerk-std()-X -- the average standard deviation per subject-activity
fBodyAccJerkStdY | Numeric | fBodyAccJerk-std()-Y -- the average standard deviation per subject-activity
fBodyAccJerkStdZ | Numeric | fBodyAccJerk-std()-Z -- the average standard deviation per subject-activity
fBodyGyroMeanX | Numeric | fBodyGyro-mean()-X -- the average mean per subject-activity
fBodyGyroMeanY | Numeric | fBodyGyro-mean()-Y -- the average mean per subject-activity
fBodyGyroMeanZ | Numeric | fBodyGyro-mean()-Z -- the average mean per subject-activity
fBodyGyroStdX | Numeric | fBodyGyro-std()-X -- the average standard deviation per subject-activity
fBodyGyroStdY | Numeric | fBodyGyro-std()-Y -- the average standard deviation per subject-activity
fBodyGyroStdZ | Numeric | fBodyGyro-std()-Z -- the average standard deviation per subject-activity
fBodyAccMagMean | Numeric | fBodyAccMag-mean() -- the average mean per subject-activity
fBodyBodyAccJerkMagMean | Numeric | fBodyBodyAccJerkMag-mean() -- the average mean per subject-activity
fBodyBodyGyroMagMean | Numeric | fBodyBodyGyroMag-mean() -- the average mean per subject-activity
fBodyBodyGyroJerkMagMean | Numeric | fBodyBodyGyroJerkMag-mean() -- the average mean per subject-activity
angletBodyAccMeanGravity | Numeric | angle(tBodyAccMean,gravity) -- the average mean per subject-activity
angletBodyAccJerkMeanGravityMean | Numeric | angle(tBodyAccJerkMean),gravityMean) -- the average mean per subject-activity
angletBodyGyroMeanGravityMean | Numeric | angle(tBodyGyroMean,gravityMean) -- the average mean per subject-activity
angletBodyGyroJerkMeanGravityMean | Numeric | angle(tBodyGyroJerkMean,gravityMean) -- the average mean per subject-activity
angleXGravityMean | Numeric | angle(X,gravityMean) -- the average mean per subject-activity
angleYGravityMean | Numeric | angle(Y,gravityMean) -- the average mean per subject-activity
angleZGravityMean | Numeric | angle(Z,gravityMean) -- the average mean per subject-activity
