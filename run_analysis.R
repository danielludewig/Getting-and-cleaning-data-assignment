## run_analysis.R

## Load relevent packages
library(dplyr)
library(data.table)

## Check for existence of directory for assignment data, and create one if it 
## does not exist. 

if(!dir.exists("./GaCD_Assignment")){dir.create("./GaCD_Assignment")}

## Create variable containing data URL.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download zip file from source.

download.file(url, destfile = "./GaCD_Assignment/zipfile.zip")

## Unzip data from zip file, then delete the original zip file.

unzip("./GaCD_Assignment/zipfile.zip", exdir = "./GaCD_Assignment")
file.remove("./GaCD_Assignment/zipfile.zip")

## Change working directory to unzipped file. 

setwd(dir("./GaCD_Assignment", full.names = TRUE))

## Read in features text file and save to a variable called "features". 

features <- read.table("./features.txt")

## Extract the features from the "features" table to a variable called colNames

colNames <- as.vector(features[, 2])

## Read in the "X_test.txt" file and save it to a variable called "test_data".
## Pass the variable "colNames" as the col.names argument. 

test_data <- data.table(read.table("./test/X_test.txt", header = FALSE, 
                        col.names = colNames))

## Read in the "y_test.txt" file and save it to a variable called "test_labels".
## Pass "Activity_Label" as the col.names argument.

test_labels <- data.table(read.table("./test/y_test.txt", header = FALSE, 
                          col.names = "Activity_Label"))

## Read in the "subject_test.txt" file and save it to a variable called 
## "test_subject". Pass "Subject" as the col.names argument.

test_subject <- data.table(read.table("./test/subject_test.txt", header = FALSE, 
                          col.names = "Subject"))

## Bind the "test_subject", "test_labels" and "test_data" and save the to a new 
## variable called "test_total". 

test_total <- cbind(test_subject, test_labels, test_data)

## Remove unnecessary data.

rm(test_data, test_labels, test_subject, url)

## Read in the "X_train.txt" file and save it to a variable called "train_data".
## Pass the variable "colNames" as the col.names argument. 

train_data <- data.table(read.table("./train/X_train.txt", header = FALSE, 
                        col.names = colNames))

## Read in the "y_train.txt" file and save it to a variable called 
## "train_labels". Pass "Activity_Label" as the col.names argument.

train_labels <- data.table(read.table("./train/y_train.txt", header = FALSE, 
                          col.names = "Activity_Label"))

## Read in the "subject_train.txt" file and save it to a variable called 
## "train_subject". Pass "Subject" as the col.names argument.

train_subject <- data.table(read.table("./train/subject_train.txt", 
                                       header = FALSE, col.names = "Subject"))

## Bind the "train_subject", "train_labels" and "train_data" and save the to a 
## new variable called "train_total". 

train_total <- cbind(train_subject, train_labels, train_data)

##QUESTION 1
## Bind the two total data frames to form a complete set of data. Save it the 
## a new variable called "all_data".

all_data <- rbind(train_total, test_total)

## Remove unnecessary data.

rm(features, test_total, train_data, train_labels, train_subject, train_total, 
   colNames)

## Arrange data so that the subject go in ascending order, followed by the 
## activity. 

all_data <- arrange(all_data, Subject, Activity_Label)

## QUESTION 2
## Extract the mean and standard deviation for each measurement. Save it to a 
## variable call "subset_data".

subset_data <- all_data[, c(1,2,grep("[Mm]ean|std", names(all_data)))]

## QUESTION 3
## Read in "activity_labels.txt" and save it as a variable called 
## "activity_labels". 

activity_labels <- (read.table("activity_labels.txt"))

## Mutate the numeric indicator of the activity label to a descriptive name.

subset_data <- mutate(subset_data, Activity_Label= as.character(factor(
      subset_data$Activity_Label, levels = 1:6, labels = activity_labels[,2])))

## QUESTION 4
## As the columns of the data frame were labelled when original data was read 
## in, they already have descriptive names. For futher descriptions, see 
## Codebook. 

## QUESTION 5
## Summarise the data grouped by the subject and teh activity. Save the data in
## the vaiable "tidy_data".

tidy_data <- subset_data %>% group_by(Subject, Activity_Label) %>% 
      summarise_all(mean)

## Write the data to a text file called "tidy_data.txt".

write.table(tidy_data, file= "tidy_data.txt", row.names = FALSE)




