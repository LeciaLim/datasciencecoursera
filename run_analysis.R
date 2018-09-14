# DATASCIENCE: GETTING AND CLEANING DATA
# COURSE PROJECT: WEEK 4

# Download the datasets
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "finalproject.zip"
if (!file.exists(fileName)) {
  download.file(fileURL, fileName)
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(fileName)
}

# Read in the datasets
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

subject <- rbind(subject_train, subject_test)
names(subject) <- "subject"
activity <- rbind(y_train, y_test)
names(activity) <- "activity"

# 1. Merges the training and the test sets to create one data set.
xmergeset <- rbind(x_train,x_test)
colnames(xmergeset) <- features[,2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
selectindex <- grep("mean()|std()", features[,2])
selectdata <- xmergeset[,selectindex]

# 3. Uses descriptive activity names to name the activities in the data set
activitygrp <- rep(NA,dim(selectdata)[1])
selectdata <- cbind(activity, activitygrp, selectdata)
for (act in 1:6) {
  selectdata[selectdata$activity == act,"activitygrp"] <- as.character(activity_label[activity_label[,1]==act,2])
}

# 4. Appropriately labels the data set with descriptive variable names.
names(selectdata) # selectdata already have descriptive variable name

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
selectdata <- cbind(subject, selectdata)
selectact <- names(selectdata)[4:dim(selectdata)[2]]
newdata <- melt(selectdata, id.vars = c("subject", "activitygrp"))
avgdata <- dcast(newdata, subject + activitygrp ~ variable, fun.aggregate = mean, na.rm = TRUE)
write.table(avgdata, "avgdata.txt", row.name=FALSE)
