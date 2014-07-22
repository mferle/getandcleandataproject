## read activity labels and descriptions into dataset al
al <- read.table("activity_labels.txt", col.names=c("ActivityID", "ActivityDesc"))

## read features list into dataset fl
fl <- read.table("features.txt")
## create vector v to contain only labels
v = as.vector(fl$V2)

## read test data into dataset xtest using features list as column names
xtest <- read.table("test/X_test.txt", col.names = v)
## read train data into dataset xtrain using features list as column names
xtrain <- read.table("train/X_train.txt", col.names = v)

## extract only the measurements on the mean and standard deviation for each measurement
## create a vector with columns that contain mean() and std() and replace
## special characters with .
colsStdMean <- c(v[grep("std", v)], v[grep("mean", v)])
colsStdMean <- gsub("\\(", ".", colsStdMean)
colsStdMean <- gsub("\\)", ".", colsStdMean)
colsStdMean <- gsub("-", ".", colsStdMean)
colsStdMean <- gsub(",", ".", colsStdMean)

## extract columns identified in the previous step from xtest into xteststdmean
xteststdmean <- xtest[, colsStdMean]
## extract columns identified in the previous step from xtrain into xtrainstdmean
xtrainstdmean <- xtrain[, colsStdMean]

## read test data subject labels into dataset xtestsubject
xtestsubject <- read.table("test/subject_test.txt", col.names="SubjectID")

## read train data subject labels into dataset xtrainsubject
xtrainsubject <- read.table("train/subject_train.txt", col.names="SubjectID")

## read test data activity labels into dataset xtestal
xtestal <- read.table("test/y_test.txt", col.names="ActivityID")

## read train data activity labels into dataset xtestal
xtrainal <- read.table("train/y_train.txt", col.names="ActivityID")

## merge activity labels with corresponding descriptions from dataset al
## into dataset xtestaldesc
xtestaldesc <- merge(x = xtestal, y = al, by = "ActivityID", all.x = TRUE)

## merge activity labels with corresponding descriptions from dataset al
## into dataset xtrainaldesc
xtrainaldesc <- merge(x = xtrainal, y = al, by = "ActivityID", all.x = TRUE)

## combine test data subject labels and activity descriptions
## with test data into dataset x
x <- cbind(xtestsubject, xtestaldesc, xteststdmean)

## combine train data subject labels and activity descriptions
## with train data into dataset y
y <- cbind(xtrainsubject, xtrainaldesc, xtrainstdmean)

## combine test and train datasets into one
result <- rbind(x, y)

## aggregate result by calculating mean over SubjectID and ActivityDesc
resultagg <- aggregate(result, list(result$ActivityDesc, result$SubjectID), mean)

## tidy the aggregated result by renaming Group.1 and Group.2 columns
resulttidy <- resultagg[, c("Group.1", "Group.2", colsStdMean)] 
colnames(resulttidy) <- c("ActivityDesc", "SubjectID", colsStdMean)

## write result tidy dataset to file avg_activity_subject.txt
write.table(resulttidy, "avg_activity_subject.txt", sep=" ")
