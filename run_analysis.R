### 1.  Merges the training and the test sets to create one data set.
# Reading in the feature names
features <- read.table("UCI HAR Dataset/features.txt")

# Reading in test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c("subject")

# Reading in train data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c("subject")

# Assigning feature names to the column names
names(X_test) <- features[,2]
names(Y_test) <- c("Y")
names(X_train) <- features[,2]
names(Y_train) <- c("Y")

# Combine the Y, the subject and X
test <- cbind(Y_test, subject_test, X_test)
train <- cbind(Y_train, subject_train, X_train)

#Combine the test and train dataset
set <- rbind(test, train)

### 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
# We use an exact match grep (fixed = TRUE) to obtain a list of indices of variables
# containing either mean() or std()
# + 2, because the first column is now Y from Y_test and Y_train and the second is the subject. We still need the Y, therefore the first column is added

set.mean.std <- set[,c(c(1,2), c(grep("mean()", features[,2], fixed = TRUE),grep("std()", features[,2], fixed = TRUE))+2)]

### 3.  Uses descriptive activity names to name the activities in the data set

# Reading in the activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("Y", "act_desc")
# Merge the two sets
set.mean.std.desc <- merge(set.mean.std, activity_labels, by.x = "Y", by.y = "Y")
# Drop the Y, it has become redundant with the new act_desc
set.mean.std.desc <- set.mean.std.desc[,c(-1)]

### 4.  Appropriately labels the data set with descriptive variable names. 
# This is already done in prior steps.

### 5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(reshape2)
# Reshape the data, so that the mean of all variables can be calculated at once
setMelt <- melt(set.mean.std.desc, id = c("subject", "act_desc"))
avg.act.subject <- dcast(setMelt, subject + act_desc ~ variable, fun = mean)
# Write the tidy data set to a txt-file
write.table(avg.act.subject,file="tidy data set.txt")
