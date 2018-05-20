
# Getting and Cleaning Data Course Project
# 
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
#         1) a tidy data set as described below, 
#         2) a link to a Github repository with your script for performing the analysis, and 
#         3) a code book that describes the variables, the data, and any transformations or work that you performed to 
#         clean up the data called CodeBook.md. 
#         
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#         
#         http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


if (!dir.exists("datasets")) {
        dir.create("datasets")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# tp stands for target path
tp <- "datasets/wearable.zip"
if (!file.exists(tp)) {
        download.file(fileurl, tp)
}

unmergedpath = "datasets/UCI HAR Dataset"
if (!dir.exists(unmergedpath)) {
        unzip(tp, exdir = "datasets")
}
unlink(x = "datasets/wearable.zip")

allFiles <- list.files(unmergedpath, full.names = T, recursive = T)

trainFiles <- grep("train", allFiles, value = T)
testFiles  <- grep("test" , allFiles, value = T)

if (length(trainFiles) != length(testFiles)) {
        stop("ERROR: different number of train and test files")
}



# For this dataset there should be the same # of test and train files
# Furthermore, list.files() does things alphabetically so the corresponding files have same indices in the list
# Careful when expanding to other datasets as this may not apply if the test and train folders name their files differently
if (!dir.exists("datasets/mergedUCI")) {
        dir.create("datasets/mergedUCI")
}
if (!dir.exists("datasets/mergedUCI/Inertial Signals")) {
        message("Creating Inertial Signals folder in merged dataset")
        dir.create("datasets/mergedUCI/Inertial Signals")
}


######################################################################
# Task 1: Merges the training and the test sets to create one data set.

i<-1
mergedTables <- list()
while (i <= length(testFiles)) {
        
        # This merges all train and test files
        # For example, the table corresponding to the merger of X_train.txt and X_test.txt can be accessed simply by mergedTables$X
        df_test <- read.table(testFiles[i])
        df_train <- read.table(trainFiles[i])
        mergedTables[[i]] <- rbind(df_test, df_train)

        # This block names the mergedTables list elements nice names
        tablename <- strsplit(testFiles[i],"/")[[1]]
        tablename <- tablename[length(tablename)]
        tablename <- gsub("_test.txt","", tablename)
        names(mergedTables)[i] <- tablename
        
        # Write to new folder for merged dataset
        outname <- gsub("UCI HAR Dataset", "mergedUCI", testFiles[i])
        # No need for separate test and train folders anymore
        outname <- gsub("test/", "", outname)
        # Change the _test in the file name to _merged
        outname <- gsub("_test", "_merged", outname)
        
        print(paste("Input test file: ", testFiles[i]))
        print(paste("Input train file: ", trainFiles[i]))
        
        # Add a caution to make sure things went ok
        if ( nrow(mergedTables[[i]]) != nrow(df_test)+nrow(df_train) ) {
                message( "Merged table has different number of rows than expected!" )
                message( paste("nrow test:"  , nrow(df_test) ) )
                message( paste("nrow train:" , nrow(df_train)) )
                message( paste("nrow merged:", nrow(mergedTables[[i]]), "; test+train:", nrow(df_test)+nrow(df_train)) )
        }
        
        print(paste("Going to write out merged table in file ", outname))
        print("")
        write.table(mergedTables[i], outname)
        
        i <- i+1   # Don't forget to iterate!
}

# After this block, can retrieve for example the merged X_train.txt and X_test by simply doing mergedTables$X

###################### Task 1 is now complete ########################



######################################################################
# Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
tidyTable <- mergedTables$X

features <- read.table(paste0(unmergedpath,"/features.txt"))

# features.txt contains the 561 feature names to be used for the 561 columns of mergedTable$X, a.k.a tidyTable
colnames(tidyTable) <- features$V2

# The problem only wants mean and std devation so:
tidyTable <- tidyTable[ , grep("std\\(\\)|mean\\(\\)",colnames(tidyTable))]

###################### Task 2 is now complete ########################


######################################################################
# Task 3: Uses descriptive activity names to name the activities in the data set

# Start by cleaning up column names. Tidy data has simple column names, all lower-case, no special characters
colnames(tidyTable) <- gsub("\\(\\)","", colnames(tidyTable))
colnames(tidyTable) <- gsub("-","", colnames(tidyTable))
colnames(tidyTable) <- gsub(",","", colnames(tidyTable))
colnames(tidyTable) <- tolower(colnames(tidyTable)) 

# Need to essentially add two columns, one for the activity and another for the subject
df_subject <- mergedTables$subject

# y_train.txt and y_test.txt have the of the activity of each row. 
df_activities <- mergedTables$y

# While activity_labels has the pretty names that describe each activity
activitylabels <- read.table(paste0(unmergedpath,"/activity_labels.txt"))$V2

tidyTable <- cbind(tidyTable, activity=activitylabels[df_activities$V1])
tidyTable <- cbind(tidyTable, subject = df_subject$V1)

write.table(tidyTable, "datasets/mergedUCI/tidyData.txt")

###################### Task 3 is now complete ########################


######################################################################
# Task 4: Appropriately labels the data set with descriptive variable names.
# This was already done in task 3!
###################### Task 4 is now complete ########################



######################################################################
# Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
ds2 <- mutate(tidyTable, subject = as.factor(subject)) %>% 
        group_by(activity, subject) %>% 
        summarise_all(funs(mean)) %>% 
        ungroup

write.table(ds2, "datasets/mergedUCI/tidyTask5.txt", row.names = FALSE)
###################### Task 5 is now complete ########################

