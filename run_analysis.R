##

## Load necessary package

library(dplyr)

## Download data from web and unzip in folder Datos

archivoURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./Datos")){
        dir.create("./Datos")
        download.file(archivoURL, destfile = "./Datos/ArchivoDatos.zip", method = "curl")
}
if(!file.exists("./Datos/UCI HAR Dataset")){
        unzip(zipfile = "./Datos/ArchivoDatos.zip", exdir = "./Datos")        
}


## Read necessary data from files

data_x_test <- read.table("./Datos/UCI HAR Dataset/test/X_test.txt", header = FALSE)
data_y_test <- read.table("./Datos/UCI HAR Dataset/test/Y_test.txt", header = FALSE)
data_subject_test <- read.table("./Datos/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

data_x_train <- read.table("./Datos/UCI HAR Dataset/train/X_train.txt", header = FALSE)
data_y_train <- read.table("./Datos/UCI HAR Dataset/train/Y_train.txt", header = FALSE)
data_subject_train <- read.table("./Datos/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

features_names <- read.table("./Datos/UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("./Datos/UCI HAR Dataset/activity_labels.txt", header = FALSE)


## Merge the training and the test sets 

data_x <- rbind(data_x_train, data_x_test)
data_y <- rbind(data_y_train, data_y_test)
data_subject <- rbind(data_subject_train, data_subject_test)


## Define variable names

names(data_x) <- features_names$V2
names(data_y) <- c("activity")
names(data_subject) <- c("subject")


## Merge into a one data sets

data_all <- cbind(data_x, data_subject, data_y)


## Extract only the measurements on the mean and standard deviation for each measurement.

filter_col_names <- features_names$V2[grep("mean\\(\\)|std\\(\\)", features_names$V2)]
data_col_names <- c(as.character(filter_col_names), "subject", "activity")
data_all_tidy <- subset(data_all, select = data_col_names)


## Use descriptive activity names to name the activities in the data set

data_all_tidy$activity <- activity_labels[data_all_tidy$activity, 2]


## Label appropriately the data set with descriptive variable names

names(data_all_tidy) <- gsub("angle", "Angle", names(data_all_tidy))
names(data_all_tidy) <- gsub("gravity", "Gravity", names(data_all_tidy))
names(data_all_tidy) <- gsub("Acc", "Accelerometer", names(data_all_tidy))
names(data_all_tidy) <- gsub("Gyro", "Gyroscope", names(data_all_tidy))
names(data_all_tidy) <- gsub("Mag", "Magnitude", names(data_all_tidy))
names(data_all_tidy) <- gsub("BodyBody", "Body", names(data_all_tidy))
names(data_all_tidy) <- gsub("^t", "Time", names(data_all_tidy))
names(data_all_tidy) <- gsub("^f", "Frequency", names(data_all_tidy))


## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject

data_output <- data_all_tidy %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(data_output, file = "./tidy_data.txt", row.names = FALSE)