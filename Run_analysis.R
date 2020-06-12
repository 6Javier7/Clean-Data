library(data.table)
#Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "dataset.zip")
unzip("dataset.zip")

al <- fread("./R/Cleaning/activity_labels.txt") #Activities labels
ts <- fread("./R/Cleaning/test/subject_test.txt") #test activities subset by subject
tx <- fread("./R/Cleaning/test/X_test.txt") #test results subset
ty <- fread("./R/Cleaning/test/Y_test.txt") #test subjects subset
trs <- fread("./Cleaning/train/subject_train.txt") #test activities subset by subject
trx <- fread("./R/Cleaning/train/X_train.txt") #test results subset
try <- fread("./Cleaning/train/Y_train.txt") #test subjects subset


#Processing
##test subsect
tsa <- merge(ty, al) #Merge activities of test subset with activities labels file
ty[,Activity1 := tsa[,2]] #Add the activity number
ty[,Activity := tsa[,1]] #a
colnames(ty) <- c("Subject" ,"Label", "Activity") #descriptive names
test <- cbind(ty, tx)
test[,Subset := rep("Test", nrow(ty[,1]))] #a new column with the subsect name

##training subset
tra <- merge(try, al) #Merge activities of training subset with activities labels file
try[,Activity := tra[,2]]
try[,Activity1 := tra[,1]]
colnames(try) <- c("Subject" ,"Label", "Activity") #descriptive names
train <- cbind(try, trx)
train[,Subset := rep("Train", nrow(try[,1]))] #a new column with the subsect name


data <- rbind(test[,c(1, 2, 3, 4, 5, 6, 7, 8, 9, 44, 45, 46, 47, 48, 49, 84, 85, 86, 87, 88, 89, 124, 125, 126, 127, 128, 129, 164, 165, 166, 167, 168, 169, 204, 205, 217, 218, 230, 231, 243, 244, 256, 257, 269, 270, 271, 272, 273, 274, 348, 349, 350, 351, 352, 353, 427, 428, 429, 430, 431, 432, 506, 507, 565)] ,train[,c(1, 2, 3, 4, 5, 6, 7, 8, 9, 44, 45, 46, 47, 48, 49, 84, 85, 86, 87, 88, 89, 124, 125, 126, 127, 128, 129, 164, 165, 166, 167, 168, 169, 204, 205, 217, 218, 230, 231, 243, 244, 256, 257, 269, 270, 271, 272, 273, 274, 348, 349, 350, 351, 352, 353, 427, 428, 429, 430, 431, 432, 506, 507, 565)])
colnames(data) <- c("Subject" ,"Activity", "Activity1", "fBodyAccMag-std-X","tBodyAcc-mean-Y","tBodyAcc-mean-Z","tBodyAcc-mean-X","tBodyAcc-std-Y","tBodyAcc-std-Z","tBodyAcc-std-X","tGravityAcc-mean-Y","tGravityAcc-mean-Z","tGravityAcc-mean-X","tGravityAcc-std-Y","tGravityAcc-std-Z","tGravityAcc-std-X","tBodyAccJerk-mean-Y","tBodyAccJerk-mean-Z","tBodyAccJerk-mean-X","tBodyAccJerk-std-Y","tBodyAccJerk-std-Z","tBodyAccJerk-std-X","tBodyGyro-mean-Y","tBodyGyro-mean-Z","tBodyGyro-mean-X","tBodyGyro-std-Y","tBodyGyro-std-Z","tBodyGyro-std-X","tBodyGyroJerk-mean-Y","tBodyGyroJerk-mean-Z","tBodyGyroJerk-mean-X","tBodyGyroJerk-std-Y","tBodyGyroJerk-std-Z","tBodyGyroJerk-std","tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean","tBodyGyroMag-std","tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std-X","fBodyAcc-mean-Y","fBodyAcc-mean-Z","fBodyAcc-mean-X","fBodyAcc-std-Y","fBodyAcc-std-Z","fBodyAcc-std-X","fBodyAccJerk-mean-Y","fBodyAccJerk-mean-Z","fBodyAccJerk-mean-X","fBodyAccJerk-std-Y","fBodyAccJerk-std-Z","fBodyAccJerk-std-X","fBodyGyro-mean-Y","fBodyGyro-mean-Z","fBodyGyro-mean-X","fBodyGyro-std-Y","fBodyGyro-std-Z","fBodyGyro-std","fBodyAccMag-mean","Subset")

library(tidyverse)
#whith gather function i meke a column name 'Variable' whith all the variable names of the experiment
#and with the goup_by and summarize functions i get the average for each subject, varible, activity and subset
data1 <- data %>% gather("fBodyAccMag-std-X","tBodyAcc-mean-Y","tBodyAcc-mean-Z","tBodyAcc-mean-X","tBodyAcc-std-Y","tBodyAcc-std-Z","tBodyAcc-std-X","tGravityAcc-mean-Y","tGravityAcc-mean-Z","tGravityAcc-mean-X","tGravityAcc-std-Y","tGravityAcc-std-Z","tGravityAcc-std-X","tBodyAccJerk-mean-Y","tBodyAccJerk-mean-Z","tBodyAccJerk-mean-X","tBodyAccJerk-std-Y","tBodyAccJerk-std-Z","tBodyAccJerk-std-X","tBodyGyro-mean-Y","tBodyGyro-mean-Z","tBodyGyro-mean-X","tBodyGyro-std-Y","tBodyGyro-std-Z","tBodyGyro-std-X","tBodyGyroJerk-mean-Y","tBodyGyroJerk-mean-Z","tBodyGyroJerk-mean-X","tBodyGyroJerk-std-Y","tBodyGyroJerk-std-Z","tBodyGyroJerk-std","tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean","tBodyGyroMag-std","tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std-X","fBodyAcc-mean-Y","fBodyAcc-mean-Z","fBodyAcc-mean-X","fBodyAcc-std-Y","fBodyAcc-std-Z","fBodyAcc-std-X","fBodyAccJerk-mean-Y","fBodyAccJerk-mean-Z","fBodyAccJerk-mean-X","fBodyAccJerk-std-Y","fBodyAccJerk-std-Z","fBodyAccJerk-std-X","fBodyGyro-mean-Y","fBodyGyro-mean-Z","fBodyGyro-mean-X","fBodyGyro-std-Y","fBodyGyro-std-Z","fBodyGyro-std","fBodyAccMag-mean", key = "Variable", value = "Result") %>% group_by(Activity, Variable, Subset, Subject) %>% summarize(Average = mean(Result))
