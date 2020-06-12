library(data.table)

#Data
al <- fread("activity_labels.txt") #Activities labels
ts <- fread("test/subject_test.txt") #test activities subset by subject
tx <- fread("test/X_test.txt") #test results subset
ty <- fread("test/Y_test.txt") #test subjects subset
trs <- fread("train/subject_train.txt") #test activities subset by subject
trx <- fread("train/X_train.txt") #test results subset
try <- fread("train/Y_train.txt") #test subjects subset


#processing
tsa <- merge(ty, al) #Merge activities of test subset with activities labels file
ty[,Activity := tsa[,2]]
ty[,Label := tsa[,1]]
colnames(ty) <- c("Subject" ,"Label", "Activity")
test <- cbind(ty, tx)
test[,Subset := rep("Test", nrow(ty[,1]))]

tra <- merge(try, al) #Merge activities of test subset with activities labels file
try[,Activity := tra[,2]]
try[,Label := tra[,1]]
colnames(try) <- c("Subject" ,"Label", "Activity")
train <- cbind(try, trx)
train[,Subset := rep("Train", nrow(try[,1]))]


data <- rbind(test[,c(1, 2, 3, 4, 5, 6, 7, 8, 9, 44, 45, 46, 47, 48, 49, 84, 85, 86, 87, 88, 89, 124, 125, 126, 127, 128, 129, 164, 165, 166, 167, 168, 169, 204, 205, 217, 218, 230, 231, 243, 244, 256, 257, 269, 270, 271, 272, 273, 274, 348, 349, 350, 351, 352, 353, 427, 428, 429, 430, 431, 432, 506, 507, 565)] ,train[,c(1, 2, 3, 4, 5, 6, 7, 8, 9, 44, 45, 46, 47, 48, 49, 84, 85, 86, 87, 88, 89, 124, 125, 126, 127, 128, 129, 164, 165, 166, 167, 168, 169, 204, 205, 217, 218, 230, 231, 243, 244, 256, 257, 269, 270, 271, 272, 273, 274, 348, 349, 350, 351, 352, 353, 427, 428, 429, 430, 431, 432, 506, 507, 565)])
colnames(data) <- c("Subject" ,"Label", "Activity", "" ,"Subset")
