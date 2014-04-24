

### Data 
Raw data was provided in multiple files for the assignment. Here is description of files and data which has been used in this assessment.

* X_test and X_train has the actual data which were collected from the participants.
* Y_test and Y_train has the activity codes for the above data, every row defines the activity for the corresponding row in x_train/X-test files
* activity_labels has the information of activities Ids which are in Y_train and Y_test files.
* "features" provides the column description for the x_test and x_train data
* feature_info provides the explanation of variables which are in "features" file
* subject_train/subject_test has the subject data for X_train/X_test files.
* README.txt file has more information regarding data.
* Readme.md has information to how to use/run the script


### Transformations

* Data files have been cleaned manually, so in order to run the script correctly, use the data set provided in the repository. 
	This has been done in order to protect copying script by other person.

### Data merging, Clean-up operations and corresponding variables.

1. Merged all the raw data, this includes merging x_test, y_test,x_train, y_train, subject_train, subject_test and activities. 
	Scripts stores this data in combinedRaw data frame and with columns description in combinedDS and can be checked after choosing option 1 and 3 after running script.
2. Extracted data for mean and standard deviation for each measurement.This stores in meanStdData Data frame and can be checked after choosing option 2 after running script.
3. Filtered DS (Mean and Standard deviation) with descriptive activity names.This stores in FilteredDS Data frame and can be checked after choosing option 4 after running script.
4. tidyDS stores the final tidy data set and can be check using option 5.

Other Variables:

1. testX: Stores data from x_test file.
2. trainX: Stores data from x_train file.
3. testY: Stores data from y_test file.
4. trainY: Stores data from y_train file.
5. subjectTest: Stores data from subject_test file.
6. subjectTrain: Stores data from subject_train file.
7. featureDF: Stores data from feature file.
8. activitiesDF: Stores combined data from activity_label and trainY file.
9. extractedDF,colName,rows,modifiedColName: These are being used for multiple cleanup operations when getting data from diffferent sources and merging at one place.
10. numparts,sidname, partnum: These are being used to show,store multiple user options and to store user's input.

