# getting_and_cleaning_data_CP
Getting and Cleaning Data Course Project

This is the data used for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script "run_analysis.R" does the following:

    - Merges the training and the test sets to create one data set.
    - Extracts only the measurements on the mean and standard deviation for each measurement.
    - Uses descriptive activity names to name the activities in the data set
    - Appropriately labels the data set with descriptive variable names.
    - From the data set in step 4, creates a second, independent tidy data set with the average 
      of each variable for each activity and each subject.
      
 Assumption: the data is unzipped in the following file: "./UCI HAR Dataset/"
 
 The resulting data set is "AverageTidyDataset.txt"    
