### Author: Hanifah Gladis Amalia 

# Load necessary libraries
library(dplyr)

# Step 1 - Download and Unzip the Data 
# Download the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI_HAR_Dataset.zip")

# Unzip the dataset
unzip("UCI_HAR_Dataset.zip")

# Step 2 - Load the Data into R 
# Read the data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Step 3 - Merge the Training and Test Data Sets 
# Merge the data
subject <- rbind(subject_train, subject_test)
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
merged_data <- cbind(subject, Y, X)

# Step 4 - Extract Measurements on Mean and Standard Deviation
# Extract measurements on mean and standard deviation
tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

# Step 5 - Use Descriptive Activity Names 
# Name the activities
tidy_data$code <- activities[tidy_data$code, 2]

# Step 6 - Label the Data Set with Descriptive Variable Names 
# Appropriately label the data set with descriptive variable names
names(tidy_data)[2] <- "activity"
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# Step 7 - Create a Second, Independent Tidy Data Set 
# Create a second, independent tidy data set
final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Write the final data to a .txt file
write.table(final_data, "tidy_data.txt", row.name = FALSE)
