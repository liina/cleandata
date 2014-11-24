1.Download files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Unpack the zip file into subidrectory of working directory UCI HAR Dataset.

2.test/X_test.txt and train/X_train.txt were merged into a dataset of 561 variables and 10299 observations

3.Only variables for standard deviation and average values were extracted -  leaving 79 variables.
Extraction was based on features.txt file - only features containing std or mean were considered.
It was assumed that number of row in features.txt was the same as column index of the X_test.txt and X_train.txt files.

4.Additional columns were added to the dataset:
Activity
