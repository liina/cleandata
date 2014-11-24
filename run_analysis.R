library(dplyr)

#Step 1 - merges test set and training set

testdata<-read.table("cleandata/UCI HAR Dataset/test/X_test.txt",stringsAsFactors=FALSE)
traindata<-read.table("cleandata/UCI HAR Dataset/train/X_train.txt",stringsAsFactors=FALSE)
ucidata<-rbind(testdata,traindata)

#Step 2 - extracts only columns that contain mean or std in relevant rows of features.txt

features<-read.table("cleandata/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
meanstd<-grep("mean|std",features[,2])
ucidata<-ucidata[,meanstd]

#Step 3 - adds column with descriptive activity names

testlabels<-scan("cleandata/UCI HAR Dataset/test/y_test.txt")
trainlabels<-scan("cleandata/UCI HAR Dataset/train/y_train.txt")
labels<-c(testlabels,trainlabels)
act_labels<-read.table("cleandata/UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
for (i in c(1:nrow(act_labels))) {
	labels<-gsub(i,act_labels[i,2],labels)
}
ucidata<-cbind(activity=labels,ucidata)

#Step 4 - replaces variable names with names from features.txt columnindex is rowindex+1because I have already added activity column

features<-features[meanstd,]
features[,2]<-gsub("\\(\\)","",features[,2])
for(i in (1:nrow(features))) {
	names(ucidata)[i+1]<-features[i,2]
}

#Step 5 - adds subject column, uses dplyr package for grouping and summarizing

testsubjects<-scan("cleandata/UCI HAR Dataset/test/subject_test.txt")
trainsubjects<-scan("cleandata/UCI HAR Dataset/train/subject_train.txt")
subject<-c(testsubjects,trainsubjects)
ucidata<-cbind(subject=subject,ucidata)
ucitable<-tbl_df(ucidata)
ucitable<-group_by(ucitable,subject,activity)
tidyuci<-summarise_each(ucitable,funs(mean))
write.table("tidyuci.txt",row.names=FALSE)
