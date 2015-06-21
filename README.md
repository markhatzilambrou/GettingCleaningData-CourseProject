This README.md file describes the operations and requirements of the run_analysis.R script for cleaning and summarizing the "Human Activity Recognition Using Smartphones Dataset Version 1.0" from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Prior to running the script in R, the data must be present in the working directory with the hierarchy inherent in the zip file.  Before running the script, the above zip file should be unzipped in the current directory so that the following files exist:

./UCI HAR Dataset/activity_labels.txt
./UCI HAR Dataset/features.txt
./UCI HAR Dataset/test/subject_test.txt
./UCI HAR Dataset/test/X_test.txt
./UCI HAR Dataset/test/y_test.txt
./UCI HAR Dataset/train/subject_train.txt
./UCI HAR Dataset/train/X_train.txt
./UCI HAR Dataset/train/y_train.txt

running the command in R:

> source("run_analysis.R")

from the . directory will produce an output file:

./SummaryMeans.txt

which contains the average values for the mean and standard deviation of the 33 fundamental signals for a total of 66 variables.  These averages were taken accross 30 total subjects and 6 activities for 180 group combinations.  Therefore, the final SummaryMeans.txt table contains 66 x 180 calculated averages.

For details on the script flow and the variables of interest, see CODE_BOOK.md, and the comments in run_analysis.R
