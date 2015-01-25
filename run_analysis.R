# An R script called run_analysis.R that does the following: 
# 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of
#   each variable for each activity and each subject.
#

dataLocalName <- "FUCI HAR Dataset.zip"
dataRemoteURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(dataLocalName))
{
  download.file(url = dataRemoteURL,
                destfile = dataLocalName,
                method = "curl")
  unzip(dataLocalName) 
}

# 1) Merges the training and the test sets to create one data set.
test.x <- read.table("UCI HAR Dataset/test/X_test.txt") 
test.y <- read.table("UCI HAR Dataset/test/y_test.txt") 
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt") 

train.x <- read.table("UCI HAR Dataset/test/X_test.txt")
train.y <- read.table("UCI HAR Dataset/test/y_test.txt") 
train.subject <- read.table("UCI HAR Dataset/test/subject_test.txt") 

merge <- list(x=rbind(test.x, train.x), 
              y=rbind(test.y, train.y),
              subject=rbind(test.subject, train.subject))

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("UCI HAR Dataset/features.txt")
usedXColumnNumbers <- sapply(features[,2], function(f) grepl("(mean|std)", f))
used.x <- merge.x[,usedXColumnNumbers]

# 3) Uses descriptive activity names to name the activities in the data set

used.y <- merge.y
names(used.y) = "activity"
used.y[used.y == 1] = "WALKING"
used.y[used.y == 2] = "WALKING UPSTAIRS"
used.y[used.y == 3] = "WALKING DOWNSTAIRS"
used.y[used.y == 4] = "SITTING"
used.y[used.y == 5] = "STANDING"
used.y[used.y == 6] = "LAYING"
names(used.y) = "activity"
used.subject <- merge.subject
names(used.subject) = "subject"

# 4) Appropriately labels the data set with descriptive variable names. 

names(used.x) = features[usedXColumnNumbers, 2]

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of
#    each variable for each activity and each subject.

used <- cbind(used.x, used.y, used.subject)
tidy <- aggregate(used, by=list(used$activity, used$subject), FUN=mean)
names(tidy) = c("activity", "subject", colnames(tidy)[3:ncol(tidy)])
colnames(tidy[2]) = "subject"
write.csv(tidy, "tidy.csv", row.names=FALSE)