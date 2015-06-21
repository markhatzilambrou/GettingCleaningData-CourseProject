
This CODE_BOOK.md file describes the operations and requirements of the run_analysis.R script for cleaning and summarizing the "Human Activity Recognition Using Smartphones Dataset Version 1.0" from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

STUDY DESIGN
============

Prior to running the script in R, the data must be present in the working directory with the hierarchy inherent in the zip file.  Before running the script, the above zip file should be unzipped in the current directory so that the following files exist:

./UCI HAR Dataset/activity_labels.txt
./UCI HAR Dataset/features.txt
./UCI HAR Dataset/test/subject_test.txt
./UCI HAR Dataset/test/X_test.txt
./UCI HAR Dataset/test/y_test.txt
./UCI HAR Dataset/train/subject_train.txt
./UCI HAR Dataset/train/X_train.txt
./UCI HAR Dataset/train/y_train.txt

running the command:

> source("run_analysis.R")

from the . directory will produce an output file:

./SummaryMeans.txt

which contains the average values for the mean and standard deviation of the 33 fundamental signals for a total of 66 variables.  These averages were taken accross 30 total subjects and 6 activities for 180 group combinations.  Therefore, the final SummaryMeans.txt table contains 66 x 180 calculated averages.

Running the run_analysis.R script proceeds through the following steps:

* library(dplyr) is necessary to run the below procedures.

* The names for variables are read from the file: 
./UCI HAR Dataset/features.txt 
which vector is used to name th columns when reading in the data.

* The mapping between the index and names for the activities is read from the file:
./UCI HAR Dataset/activity_labels.txt
into a data frame for converting the indices in the main data to labels

*Each of the test and training data sets are read into memory and columns are selected as follows:
- The data is read from ./UCI HAR Dataset/test/subject_test.txt using the data from features.txt above for names
- Columns for mean and Std Deviation of the the 33 fundamental measurements are selected
- Indices for the activities is read from ./UCI HAR Dataset/test/y_test.txt and converted to text labels as factors from activity_labels.txt above, and appended to the left side of the data frame.  This column name is renamed to "Activity".
- The subject indices are read from ./UCI HAR Dataset/test/subject_test.txt, appended to the left side of the data frame, and the column is renamed to "Subject".

* The above process for the test data is repeated for the training data.

* The test and training data frames are row-binded.  This is straightforward because all columns of both sets are identical.

* The composite data frame is grouped by Activity and Subject, summarise_each is used to find the mean of each column according to each group combination, and the result is written to the file ./SummaryMeans.txt.

CODE BOOK
=========

There are 33 fundamental signals (the following is from features_info.txt, included in the above zip file):

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Each of the above is a single signal, except for the XYZ signals, which represent 3 signals.  These signals are further processed to produce 561 variables in the raw data available in the zip file.  Included in each of these is the mean and standard deviation of each of the above 33 signals.  By selecting only these two calculations for the 33 signals, we concentrate on only 66 of the 561 variables.

The variable names are taken from the file ./UCI HAR Dataset/features.txt for naming variable columns.  However, these variables contain characters (particulary "-", "(", and ")" ) that are inconvenient for R, so they are each substitued with "."

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z

As such, each of these names is transformed to, e.g.:

tBodyAcc.mean...X
tBodyAcc.mean...Y
tBodyAcc.mean...Z
tBodyAcc.std...X
tBodyAcc.std...Y 
tBodyAcc.std...Z

and so forth for all 66 variables.  Columns can then be selected as containing ".mean." or ".std."

All variable values are normalized and bounded within [-1,1].