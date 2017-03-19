# Getting and Cleaning Data Assignment
The Week 4 assignment for the Getting and Cleaning Data Coursera course. 

This was a project was designed to demostrate the ability to gather, tidy and summarize a data set concerning wearable computing. 

## The Data Set

30 volunteers aged 19-48 performed six activities whilst wearing a Samsung Galaxy SII on the waist. The six activities performed were walking, walking upstairs, walking downstairs, sitting, standing and laying. The built in accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The data set was then split into two parts, where 70% of the volunteers made up the training data and 30% made up the test data. 

A full description of how the data was collected can be found at the website: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The full data set can be downloaded from the link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## run_analysis.R

The script "run_analysis.R" was designed to complete to 5 criteria of the assignment;
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script contains statements describing the process to make it easy to follow and understand. 

The first step of the process is to load all relevant packages, download the files from the link above and unzip them. The script then changes the working directory to the unzipped file. 
The file containing the list of features is then read into a variable in R, as these are to be used as column names for the data. The three files in the test set of data are then read into R as separate variables. The arguments are passed during this process to give the columns names, avoiding the need to do this later to satisfy part three of the assignment criteria. The vector extracted from the features file is used to name the "X_test.txt" data file, "Activity_Labels" is used to name the "y_test.txt" data file and "Subject" is used to name the "subject_train.txt" data file. cbind() is then called to unite all the testing data in a new variable. 
This process is then repeated for the training set of data. This allows for the the easy use of rbind() to merge all the data into a single data set, satisfying the first criteria of the assignment. The arrange() function is then called to allow for easier data manipulation later. 
In order to satisfy the second criteria of the assignment the grep() function is called to subset the data. As the assignment was ambiguous as to what "mean" values were, the script broadly includes as mean measurements. 
The activity label data file is then read in and saved to a variable. This is then used to mutate the "Activity_Lables" column within the data frame to character vectors decribing the activity. This satisfies the third criteria of the assignment. 

