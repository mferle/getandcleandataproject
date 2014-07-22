First we read the activity labels and descriptions into a dataset al.

Then we read the features list into a dataset fl. We use this dataset to assign column names in the following step.

We read test data from the file X_test.txt into a dataset xtest and we assign column names using the features list from dataset fl.
In the same manner we read the file X_train.txt into a dataset xtrain and assign column names using fl.

We extract only the measurements that refer to mean and standard deviation from the dataset fl by using grep to identify substring std or mean in the column names. We also replace special characters such as (, ), hyphen and comma to a period. The result list of applicable measurements is named colsStdMean.

Using colsStdMean we extract the applicable columns from xtest and xtrain into xteststdmean and xtrainstdmean.

We read the test subject labels from the file subject_test.txt into a dataset xtestsubject.
In the same manner we read the file subject_train.txt into xtrainsubject.

We read activity labels from the file y_test.txt into a dataset xtestal.
In the same manner we read activity labels from y_train.txt into xtrainal.

We merge the activity labels dataset with descriptions from dataset al to get xtestaldesc.
In the same manner we merge activity labels with descriptions to get xtrainaldesc.

We combine all three datasets related to test data into one dataset named x.

We combine all three datasets related to training data into one dataset named y.

Finally, we combine test data (dataset x) and training data (dataset y) into the final dataset named result.

We aggregate this result dataset by calculating the mean over SubjectID and ActivityDesc resulting in dataset resultagg.

We tidy this dataset by renaming Group.1 and Group.2 columns.

We write the results to the file avg_activity_subject.txt.

