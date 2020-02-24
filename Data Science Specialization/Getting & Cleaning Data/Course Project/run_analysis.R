
# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Mehdi BENYAHIA

# Packages and Data
install.packages("data.table")
install.packages("dplyr")
library(data.table)
library(dplyr)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Load The Data
features_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, col.names = c("index", "featureName"))
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("indexActivity","Activity"))

### Train Data Set
dftrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features_names$featureName)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("indexActivity"))
dftrain <- cbind(subject_train, dftrain)
dftrain <- dftrain %>% select(subject, contains("mean"), contains("std"))
train <- cbind(trainActivities, dftrain)


### Test Data Set
dftest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features_names$featureName)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("indexActivity"))
dftest <- cbind(subject_test, dftest)
dftest <- dftest %>% select(subject, contains("mean"), contains("std"))
test <- cbind(testActivities, dftest)


# Merge Data
Merged_data <- rbind(train , test)

# Descriptive Names for Activities
tidydata <- select(merge(activity_labels, Merged_data,  by="indexActivity"), -indexActivity)
tidydata <- tidydata[, c(2, 1, 3:88)]

#Group by Subject and Activity and Summarize
tidydata <- tidydata %>% group_by(subject, Activity) %>% summarise_all(mean)

# Convert tidy data to text file
write.table(tidydata,"tidydata.txt",sep=",",row.names=FALSE)