Course project for getdata-009

Assumes that data files are in subdirectory named UCI HAR Dataset

Making it easy for my marker :)

library(dplyr) - comes handy in finding mean values of variables for groups

Step 1

- merges test set and training set reads test and training sets and rbinds them together.
Subjects and Activity values are read later.

- testdata - data from "UCI HAR Dataset/test/X_test.txt"
- traindata - data from "UCI HAR Dataset/train/X_train.txt"
- ucidata - merged testdata and traindata

Step 2
- extracts only columns that contain mean or std in relevant rows of features.txt
- creates df features from features.txt explaining measurements, finds on which rows were strings containing mean or std and extracts relevant columns from dataframe

- features - data from "UCI HAR Dataset/features.txt"
- meanstd - vector of rownumbers where text contains "mean" or "std"
- ucidata - now contains only 79 relevant columns

Step 3
- adds column with descriptive activity names creates vectors of activity numbers from relevant files
- merges them together in vector labels 
- creates df of meaningful activity labels act_labels in for loop replaces each value in labels vector with relevant activity name from act_labels df
- adds activity column to dataset

- testlabels - activity codes from "UCI HAR Dataset/test/y_test.txt")
- trainlabels - activity codes from "UCI HAR Dataset/train/y_train.txt"
- act_labels - data from "UCI HAR Dataset/activity_labels.txt"
- labels - vector of merged activity labels

Step 4 - replaces variable names with names from features.txt
- uses features df from step 2 to replace initial variable names with descriptive names.
- extracts from features rows containing mean or std (meanstd vector from Step 2) removes parentheses
- uses for loop to replace variable name with descriptive name
-- columnindex is rowindex+1because I have already added activity column

features - vector of descripive names for 79 measurements

Step 5
- creates subject vector and cbinds it to dataset
- uses dplyr library for grouping and summarising

- testsubjects - subjects from "UCI HAR Dataset/test/subject_test.txt"
- trainsubjects - subjects from "UCI HAR Dataset/train/subject_train.txt"
- subject - vector of all subjects

- ucitable - dplyr table
- tidyuci - table of average values for each measurement groupde by subject and activity
