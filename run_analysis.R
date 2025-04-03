##Step 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")

library(dplyr)

##Step 2
# Read in the training and test data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

##Step 3
# Merge training and test sets for the measurements
X_data <- rbind(X_train, X_test)
# Merge training and test sets for the activities
y_data <- rbind(y_train, y_test)
# Merge training and test sets for the subjects
subject_data <- rbind(subject_train, subject_test)

##Step 4
# Read feature names
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
# Extract the mean and standard deviation measurements
mean_std_columns <- grep("mean\\(\\)|std\\(\\)", features$V2)
# Subset the X_data for mean and std columns
X_data <- X_data[, mean_std_columns]
# Label columns with descriptive names
colnames(X_data) <- features$V2[mean_std_columns]

##Step 5
# Read activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
# Map activity codes to descriptive names
y_data$V1 <- factor(y_data$V1, levels = activity_labels$V1, labels = activity_labels$V2)
# Name the activity column
colnames(y_data) <- "Activity"

##Step 6
# Name the subject column
colnames(subject_data) <- "Subject"
# Combine all data into one data set
final_data <- cbind(subject_data, y_data, X_data)

##Step 7
# Create tidy dataset with the average of each variable for each subject and activity
tidy_data <- final_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(list(mean = ~mean(.)))
# Remove unnecessary lists created by summarise_all
tidy_data <- tidy_data %>% ungroup()

# Write the tidy data to a .txt file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
