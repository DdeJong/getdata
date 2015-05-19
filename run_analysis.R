# To fullfill this project I have followed the following steps:
# 1. Download data
# 2. Read data into R
# 3. Label columns with the right descriptive variable names. 
# 4. Merge the 3 dataframes together for both the test- and trainingdata
# 5. Merge the two dataframes which are the result of step 4 in order to get one tidy and complete dataset
# 6. Label the activities with descriptive activity names
# 7. Select the 'mean' and 'std' variables together with the subjectnumber and activity name.
# (now the first 4 steps of the assignment are done)
# 8. Group by and summarise data into the format which is asked for



# 1.download zip file
setwd("~/R/getdata")
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="data.zip",mode="wb")
DateDownload<-date()
unzip("data.zip")

# 2a. read testdata
setwd("~/R/getdata/UCI HAR Dataset/test")
subject_test<-read.table("subject_test.txt")
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")

# 2b. read trainingdata
setwd("~/R/getdata/UCI HAR Dataset/train")
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")

# 2c. read features and activity_labels
setwd("~/R/getdata/UCI HAR Dataset")
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

# 3a. Label columns of dataframes X-test and X-train
headings<-features$V2
#headings<-gsub(pattern = "(", replacement = "", x = headings, fixed = TRUE)
#headings<-gsub(pattern = ")", replacement = "", x = headings, fixed = TRUE)
#headings<-gsub(pattern = "-", replacement = "", x = headings, fixed = TRUE)
#headings<-gsub(pattern = ",", replacement = "", x = headings, fixed = TRUE)
names(X_test)<-headings
names(X_train)<-headings
# remove vectors from workspace in order to keep things clean 
remove(features)
remove(headings)

# 3b. Label columns of dataframes subject_test and subject_train
subjecthdr<-c("subjectnumber")
names(subject_test)<-subjecthdr
names(subject_train)<-subjecthdr
# remove vector from workspace in order to keep things clean 
remove(subjecthdr)

# 3c. Label columns of dataframes y_test, y_train and activity_names equally
names(y_test)[names(y_test)=="V1"] <- "activity"
names(y_train)[names(y_train)=="V1"] <- "activity"
names(activity_labels)[names(activity_labels)=="V1"] <- "activity"


# 4. Merge dataframes with test- and traindata
testdata<-cbind(subject_test,y_test,X_test)
traindata<-cbind(subject_train,y_train,X_train)
# remove vector from workspace in order to keep things clean 
remove(subject_test)
remove(X_test)
remove(y_test)
remove(subject_train)
remove(X_train)
remove(y_train)
remove(activity_labels)

# 5. Merge both dataframes 
data<-rbind(testdata,traindata)
# remove vector from workspace in order to keep things clean 
remove(testdata)
remove(traindata)

# 6. Label the activities with descriptive activity names
attach(data)
data$activity[activity == "1"] <- "WALKING"
data$activity[activity == "2"] <- "WALKING_UPSTAIRS"
data$activity[activity == "3"] <- "WALKING_DOWNSTAIRS"
data$activity[activity == "4"] <- "SITTING"
data$activity[activity == "5"] <- "STANDING"
data$activity[activity == "6"] <- "LAYING"
detach(data)

# 7. Select the 'mean' and 'std' variables together with the subjectnumber and activity name. Subset is called 'meanstd'
tomatch<-c("mean","Mean","std","activity","subjectnumber")
meanstd<-data[,grep(paste(tomatch,collapse="|"),names(data))]
remove(tomatch)
remove(data)

#now step 1-4 are done
# 8. Group by and summarise data into the format which is asked for
library(dplyr)
library(tidyr)
meanstd1<-tbl_df(meanstd)
meanstd1<-gather(meanstd1,measure,value,-subjectnumber,-activity)
meanstd<-group_by(meanstd1, subjectnumber,activity,measure)
tidydata<-summarise(meanstd1, mean=mean(value))
write.table(tidydata, file="tidydata.txt",row.names=FALSE)


