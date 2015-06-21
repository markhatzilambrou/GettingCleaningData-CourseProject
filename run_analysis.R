library(dplyr)
# Load the features (the measurement names) and the activity lablels into variables
#       features = the measurement names made into a string vector for the names of the variables
#       activityLabels = names of the activities (walking, sitting, etc.) as a table of integer level and name
features = read.table("./UCI HAR Dataset/features.txt", sep=" ", stringsAsFactors = FALSE)
features = features$V2
activityLabels = read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")
#
# Load the test data
#       testSubjects = integer vector of test subject for each test experiment/row
#       testActivities = factor vector factors named according to activityLables for each experiment/row
#       testDataSelected:
#               *load the test data from test/X_test.txt using the features vector as the column names
#               *select only the mean and std columns for the 33 basic measurement types
#                       *cbind the datasets with the selected columns
#               *add columns for the testActivities and testSubjects
#                       *rename to Activity an Subject
#               
#
testSubjects = read.table("./UCI HAR Dataset/test/subject_test.txt", sep=" ")
testSubjects = testSubjects$V1
testActivities = read.table("./UCI HAR Dataset/test/y_test.txt", sep=" ")
testActivities = factor(testActivities$V1, unique(testActivities$V1), labels = as.character(activityLabels$V2), 
                        ordered = TRUE)
testData = read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features)
testDataMeans = select(testData, contains(".mean."))
testDataStds = select(testData, contains(".std."))
testDataSelected = cbind(testDataMeans, testDataStds)
testDataSelected = cbind(testActivities, testDataSelected)
testDataSelected = cbind(testSubjects, testDataSelected)
testDataSelected = rename(testDataSelected, Activity = testActivities)
testDataSelected = rename(testDataSelected, Subject = testSubjects)
# clean up test data
rm(testSubjects)
rm(testActivities)
rm(testData)
rm(testDataMeans)
rm(testDataStds)
#
# Load the test data
#       trainingSubjects = integer vector of training subject for each test experiment/row
#       testActivities = factor vector factors named according to activityLables for each experiment/row
#       testDataSelected:
#               *load the test data from test/X_test.txt using the features vector as the column names
#               *select only the mean and std columns for the 33 basic measurement types
#                       *cbind the datasets with the selected columns
#               *add columns for the testActivities and testSubjects
#                       *rename to Activity an Subject
#               
#
trainingSubjects = read.table("./UCI HAR Dataset/train/subject_train.txt", sep=" ")
trainingSubjects = trainingSubjects$V1
trainingActivities = read.table("./UCI HAR Dataset/train/y_train.txt", sep=" ")
trainingActivities = factor(trainingActivities$V1, unique(trainingActivities$V1), 
                            labels = as.character(activityLabels$V2), ordered = TRUE)
trainingData = read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features)
trainingDataMeans = select(trainingData, contains(".mean."))
trainingDataStds = select(trainingData, contains(".std."))
trainingDataSelected = cbind(trainingDataMeans, trainingDataStds)
trainingDataSelected = cbind(trainingActivities, trainingDataSelected)
trainingDataSelected = cbind(trainingSubjects, trainingDataSelected)
trainingDataSelected = rename(trainingDataSelected, Activity = trainingActivities)
trainingDataSelected = rename(trainingDataSelected, Subject = trainingSubjects)
# clean up training data
rm(trainingSubjects)
rm(trainingActivities)
rm(trainingData)
rm(trainingDataMeans)
rm(trainingDataStds)
#
# Combine into final data set
#       DataSelected combines the rows of the test and training data
#               * columns of each are identical selections of mean and std variables
DataSelected = rbind(testDataSelected, trainingDataSelected)
#       cleanup:
rm(testDataSelected) ; rm(trainingDataSelected)
#
# Group the combined selected data by Subject and Activity
#
DataSelectedGrouped = group_by(DataSelected, Subject, Activity)
#       cleanup:
rm(DataSelected)
#
# Make a summary table of the mean of all column variables by combined subject and activity
#
DataSelectedGroupedMeans = summarise_each(DataSelectedGrouped, funs(mean))
#
#       cleanup:
rm(DataSelectedGrouped)
#
# Write the summary data to file SummaryMeans.txt
#
write.table(DataSelectedGroupedMeans, file = "SummaryMeans.txt", row.names = FALSE)