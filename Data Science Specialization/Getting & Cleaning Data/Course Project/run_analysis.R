
# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Mehdi BENYAHIA

# Packages and Data
install.packages("data.table", "dplyr")
library(data.table)
library(dplyr)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Load The Data
features_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, col.names = c("index", "featureName"))
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("indexActivity","ActivityLabel"))
extractfeature <- features_names %>% filter(grepl("(mean|std)\\(\\)", featureName))

### Train Data Set
dftrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features_names$featureName)
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("indexActivity"))
dftrain <- dftrain %>% select(extractfeature$featureName)
train <- cbind(dftrain, trainActivities)


### Test Data Set
dftest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features_names$featureName)
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("indexActivity"))
dftest <- dftest %>% select(extractfeature$featureName)
test <- cbind(dftest, testActivities)


# Merge Data
Merged_data <- rbind(train , test)

# Descriptive Names for Activities
tidydata <- select(merge(Merged_data, activity_labels, by="indexActivity"), -indexActivity)

# Convert tidy data to text file
write.table(tidydata,"tidydata.txt",sep=",",row.names=FALSE)