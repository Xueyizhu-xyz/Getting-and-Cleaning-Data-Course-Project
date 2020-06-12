dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile ="data.zip")
dat <- unzip("data.zip")

XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")

Xdataset <- rbind(XTest, XTrain)
Ydataset <- rbind(YTest, YTrain)
Subjectdataset <- rbind(SubjectTest, SubjectTrain)  

features <- read.table("./UCI HAR Dataset/features.txt")
info <- readLines("./UCI HAR Dataset/features_info.txt" )  
index<-grep("mean\\(\\)|std\\(\\)", features[,2])
Xdataset <- Xdataset[, index]

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
Ydataset[,1] <- activities[Ydataset[,1], 2]

names <- features[index, 2]
names(Xdataset) <- names
names(Subjectdataset)<-"SubjectID"
names(Ydataset)<-"Activity"
data <- cbind(Subjectdataset, Ydataset, Xdataset)
head(data)

TidyData <- aggregate(.~SubjectID + Activity, data, mean)
write.table(TidyData, file = "TidyData.txt", row.name=FALSE)

