# datasciencecoursera
Data Science Coursera

# README file for Data Science Cleaning Data Course Project
# You should include a README.md in the repo describing how the script works and the code book describing the variables.

The script first download the datasets if the data is not in the working directory.
It then read in the dataset to get the test and training data, as well as the activity labels and subjects for the data.
In step 1, row bind the training and test sets together
Can double check that it is suitable to use rbind by looking at dim(x_test) and dim(x_train)
In step 2, select the columns of data that are the measurements of mean and std dev.
In step 3, assign the activity number to the actual activity description
In step 4, label the columns of the dataset with its respective descriptive name.
Check using names() that the variable names are descriptive
In step 5, first cbind the subject with the selecetd data.
Next, load the reshape2 package and use the melt function to restructure the data
After which, use the dcast function from reshape2 to compute the average of each variable for the corresponding activity and subject.
Finally, save the output as a "avgdata.txt" text file.
