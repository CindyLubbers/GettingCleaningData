GettingCleaningData
===================

The repository for the Getting and Cleaning Data Course Project, it contains the following files:

README.md, this README


run_analysis.R, that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

In more detail the transformations from CodeBook.md:

### Merges the training and the test sets to create one data set.
- Reading in the feature names
- Reading in test data
- Reading in train data
- Assigning feature names to the column names
- Combine the Y, the subject and X
- Combine the test and train dataset

### Extracts only the measurements on the mean and standard deviation for each measurement. 
- We use an exact match grep (fixed = TRUE) to obtain a list of indices of variables
 containing either mean() or std()
 + 2, because the first column is now Y from Y_test and Y_train and the second is the subject. We still need the Y, therefore the first column is added

### Uses descriptive activity names to name the activities in the data set
- Reading in the activity names
- Merge the two sets
- Drop the Y, it has become redundant with the new act_desc

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
- Reshape the data, so that the mean of all variables can be calculated at once
- Write the tidy data set to a txt-file


CodeBook.md, that describes the variables, the data, and any transformations or work that you performed to clean up the data called


