# CodeBook #

## Processing overview ##

The R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Processing Detail ##

The original data was obtained here:

The following steps are taken:

* The run_analysis.R script merges the files from the test and training data sets:

  * UCI HAR Dataset/test/X_test.txt
  * UCI HAR Dataset/test/subject_test.txt
  * UCI HAR Dataset/test/y_test.txt
  * UCI HAR Dataset/train/X_train.txt
  * UCI HAR Dataset/train/subject_train.txt
  * UCI HAR Dataset/train/y_train.txt

* Only columns the columns that contain mean and standard deviation values are retained.

* The first and second columns are contain the activity and subject number.

* The column names from the activity_labels.txt are used as the activity names.

  * WALKING
  * WALKING UPSTAIRS
  * WALKING DOWNSTAIRS
  * SITTING
  * STANDING
  * LAYING

* The mean and standard deviation columns are averaged for each group.

* The resulting data is saved in tidy.csv.
