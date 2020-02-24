## Getting and Cleaning Data Project

Author: Mehdi BENYAHIA


### Source Data
You can Find Data and there description here: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Variables
subject_test : subject IDs for test

subject_train : subject IDs for train

X_test : values of variables in test

X_train : values of variables in train

y_test : activity ID in test

y_train : activity ID in train

activity_labels : Description of activity IDs in y_test and y_train

features_names : description(label) of each variables in X_test and X_train

Merged_data : bind of X_train and X_test

tidydata : Final Dataset after All required transformations

###Transformations

# Load The Data
Load the X_train data and y_train and bind them by columns (using cbind) and Adding Subject and Activity to the dataset then select the columns that contain "mean" and "sd" (using dplyr function select) resulting to train dataset.
Repet the same process to X_test and y_test resulting to test dataset.

# Merge Data
Merging train and test datasets by rows.

# Descriptive Names for Activities
rename each levels with 2nd column of activity_levels.

#Group by Subject and Activity and Summarize
tidy data set with the average of each variable for each activity and each subject.

# Convert tidy data to text file
Finally output the data as "tidy_data.txt".



