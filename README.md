---
title: "Coure Project - Getting and Cleaning Data"
output: html_document
---


This repository is the submission of the Getting and Cleaning Data course project. The R script that performs the steps required for the assignment is located in file run_analysis.R.

The following steps are performed:

1. Load required package dplyr.
2. Download the data set from the web and unzip it in a directory called "Datos".
3. Read the different training and testing data sets and then merge them into three sets: X, Y and Subject. Read files with feature names (for set X) and activity labels (for set Y).
4. Assigns column names and merge the three sets into a single data set.
5. Extract columns  with measurements on the mean and standard deviation only.
6. Replace activity column with the labels from activity label file.
7. Rename columns with descriptive variable names
8. Generate new table with average of each variable grouped by subject and activity, and extracts it to file "tidy_data.txt"