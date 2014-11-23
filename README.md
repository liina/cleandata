Course project for getdata-009

Assumes that data files are in subdirectory named UCI HAR Dataset Making it easy for my marker :) library(dplyr) - comes handy in finding mean values of variables for groups

Step 1 - merges test set and training set reads test and training sets and rbinds them together. Subjects and Activity values are read later. testdata<-read.table("cleandata/UCI HAR Dataset/test/X_test.txt",stringsAsFactors=FALSE) traindata<-read.table("cleandata/UCI HAR Dataset/train/X_train.txt",stringsAsFactors=FALSE) ucidata<-rbind(testdata,traindata)

Step 2 - extracts only columns that contain mean or std in relevant rows of features.txt creates df features from features.txt explaining measurements, finds on which rows were strings containing mean or std and extracts relevant columns from dataframe

features<-read.table("cleandata/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE) meanstd<-grep("mean|std",features[,2]) ucidata<-ucidata[,meanstd]

Step 3 - adds column with descriptive activity names creates vectors of activity numbers from relevant files and merges them together in vector labels creates df of meaningful activity labels act_labels in for loop replaces each value in labels vector with relevant activity name from act_labels df adds activity column to dataset

testlabels<-scan("cleandata/UCI HAR Dataset/test/y_test.txt") trainlabels<-scan("cleandata/UCI HAR Dataset/train/y_train.txt") labels<-c(testlabels,trainlabels) act_labels<-read.table("cleandata/UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE) for (i in c(1:nrow(act_labels))) { labels<-gsub(i,act_labels[i,2],labels) } ucidata<-cbind(activity=labels,ucidata)

Step 4 - replaces variable names with names from features.txt uses features df from step 2 to replace initial variable names with descriptive names. extracts from features rows containing mean or std (meanstd vector from Step 2) removes parentheses uses for loop to replace variable name with descriptive name columnindex is rowindex+1because I have already added activity column

features<-features[meanstd,] features[,2]<-gsub("\(\)","",features[,2]) for(i in (1:nrow(features))) { names(ucidata)[i+1]<-features[i,2] }

Step 5 - adds subject column, uses dplyr package for grouping and summarizing creates subject vector and cbinds it to dataset uses dplyr library for grouping and summarising

testsubjects<-scan("cleandata/UCI HAR Dataset/test/subject_test.txt") trainsubjects<-scan("cleandata/UCI HAR Dataset/train/subject_train.txt") subject<-c(testsubjects,trainsubjects) ucidata<-cbind(subject=subject,ucidata) ucitable<-tbl_df(ucidata) ucitable<-group_by(ucitable,subject,activity) tidyuci<-summarise_each(ucitable,funs(mean)) write.table(tidyuci.txt",row.names=FALSE)