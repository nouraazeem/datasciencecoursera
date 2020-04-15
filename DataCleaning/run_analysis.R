#Noura Azeem
#Final Assignment Data Cleaning 

#You should create one R script called run_analysis.R that does the following.



library(dplyr)
library(data.table)
library(tidyr)

# 1. Merges the training and the test sets to create one data set.

# Loading in the labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))




# Loading in the test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Loading in the train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


XTrain <- rbind(X_train, X_test)
YTrain <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)
mergedData <- cbind(Subjects, YTrain, XTrain)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <- mergedData %>% 
  select(subject, code, contains("mean"), contains("std"))

# The number of variables goes down from 561 to 88 variables

# 3. Uses descriptive activity names to name the activities in the data set
TidyData$code <- activityLabels[TidyData$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.

# leading t or f is based on time or frequency measurements.
#Body = related to body movement.
#Gravity = acceleration of gravity
#Acc = accelerometer measurement
#Gyro = gyroscopic measurements
#Jerk = sudden movement acceleration
#Mag = magnitude of movement
#mean and SD are calculated for each subject for each activity for each mean and SD measurements. 
#The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))

names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))


# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.


Finale<- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Finale, "Finale.txt", row.name=FALSE)






