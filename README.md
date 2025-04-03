# UCI_HAR_Analysis
This repository contains the analysis of the UCI Human Activity Recognition (HAR) dataset. The script `run_analysis.R` performs the following:

1. Merges the training and test datasets.
2. Extracts measurements on the mean and standard deviation.
3. Uses descriptive activity names.
4. Labels the data with descriptive variable names.
5. Creates a tidy dataset with the average of each variable for each activity and subject.

## How to Run the Script

1. Download the UCI HAR Dataset and place it in the working directory.
2. Run the `run_analysis.R` script in R.

## Variables

The following variables are included in the tidy dataset:

- **Subject**: The ID of the subject performing the activity.
- **Activity**: The activity performed (e.g., WALKING, WALKING_UPSTAIRS).
- **Measurements**: Various measurements of the accelerometer and gyroscope, including mean and standard deviation values.

