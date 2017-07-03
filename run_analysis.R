## run_analysis.R

## Reading the activity labels
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c('activityId','activityType') # Change column names

# Reading the feature vector denominations
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

## Reading the training data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") # feature vectors (1 per row)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") # activity label per feature vector
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") # subject per feature vector

## Reading the test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") # feature vectors (1 per row)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") # activity label per feature vector
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") # subject per feature vector


## Merging training and test set to create one data set
merged_train <- cbind(subject_train,y_train,X_train) # merging train data columns
merged_test <- cbind(subject_test,y_test,X_test) # merging test data columns
merged_data <- rbind(merged_train, merged_test) # merging train and test data sets

## Appropriate naming: Changing the column names for the merged data  
#names(merged_data) <- c("subjectId","activityId",names(merged_data[1,3:563]))
names(merged_data) <- c("subjectId","activityId",features[,2])


## Extracting only the measurements on the mean and standard deviation for each measurement.
mean_std_l <- grepl("mean|std",features[,2]) # create a logical vector for all "mean" and "std" features
merged_data_mean_std <- merged_data[,c(TRUE,TRUE,mean_std_l)] # select columns: "subjectID", "activityID" and all mean_std_l == TRUE


## Uses descriptive activity names to name the activities in the data set
merged_data_mean_std_final <- merge(activity,merged_data_mean_std, by="activityId", all.y=TRUE) # add the activity name to the data set


## Creating an independent tidy data set with the average 
## of each variable for each activity and each subject.
average_tidy_dataset <- aggregate(. ~subjectId + activityType, merged_data_mean_std_final, mean) # Compute the aggregated mean for subjectId and activityType
average_tidy_dataset <- average_tidy_dataset[order(average_tidy_dataset$activityId, average_tidy_dataset$subjectId),] # Order by activityId and subjectId

## Write the tidy data set 
write.table(average_tidy_dataset, "AverageTidyDataset.txt")