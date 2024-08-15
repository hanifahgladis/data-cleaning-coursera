# Code Book

This code book describes the variables, the data, and the transformations used to clean up the data.

## Data Source

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Data Cleaning Steps

1. Merged the training and the test sets to create one data set.
2. Extracted only the measurements on the mean and standard deviation for each measurement.
3. Used descriptive activity names to name the activities in the data set.
4. Labeled the data set with descriptive variable names.
5. Created a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables

- `subject`: The ID of the subject.
- `activity`: The activity performed by the subject.
- Other variables correspond to the mean and standard deviation of measurements on various signals, with appropriate descriptive names.
