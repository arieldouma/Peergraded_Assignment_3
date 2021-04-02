---
title: "Course Project - Getting and Cleaning Data"
output: html_document
---

## Codebook

The Getting and Cleaning Data course project requires some data transformation in order to get the final tidy data set. The `run_analysis.R` script performs the following steps:  

1. Read data sets from files, creating the following data sets:  

* `data_x_test` from file `X_test.txt`  
* `data_y_test` from file `Y_test.txt`  
* `data_subject_test` from file `subject_test.txt`  

* `data_x_train` from file `X_train.txt`  
* `data_y_train` from file `Y_train.txt`  
* `data_subject_train` from file `subject_train.txt`  

* `features_names` from file `features.txt`  
* `activity_labels` from file `activity_labels.txt`  

2. Merge training and testing data sets:

* `data_x` merging sets `data_x_train` and `data_x_test`  
* `data_y` merging sets `data_y_train` and `data_y_test`  
* `data_subject` merging sets `data_subject_train` and `data_subject_test`  

3. Column names are defined and data sets are merged into a single set.

* Names for columns in `data_x` are taken from data set `features_names`  
* For data sets `data_y` and `data_subject`, column names are defined as `activity` and `subject`, respectively.  
* `data_all` is created merging sets `data_x`, `data_y` and `data_subject`

4. Extract columns with measurements on the mean and standard deviation only

* `data_all_tidy` is created as a subset of `data_all`, selecting columns related to mean and standard deviation, plus subject and activity columns

5. Activity column is replaced with the activity names from activity label file.

* Column `activity` contains numbers, these are replaced with activity names taken from data set `activity_labels`  

6. Column names are renamed with descriptive variable names

* Names containing the word `angle` are replaced with `Angle`  
* Names containing the word `gravity` are replaced with `Gravity`,  
* Names containing the word `Acc` are replaced with `Accelerometer`,  
* Names containing the word `Gyro` are replaced with `Gyroscope`,  
* Names containing the word `Mag` are replaced with `Magnitude`,  
* Names containing the word `BodyBody` are replaced with `Body`,  
* Names starting with the letter `t` are replaced with `Time`, 
* Names starting with the letter `f` are replaced with `Frequency`.  

7. A new table is generated with the average of each variable grouped by subject and activity

* `data_output` is created from `data_all_tidy`, grouping by `subject` and `activity`, with the mean of each variable

8. The data set is exported to the file `tidy_data.txt`