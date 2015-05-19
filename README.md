#Getdata Coursera

=========

This document has two parts. First a short explanation is given of the steps taken to complete this project. 
In the second part the codebook of the final dataset is included.

### Discription

1. Download data from URL to local repo. Unzip the file in the same repo
2. Read data into R. testdata, trainingdata and features/activity labels
3. Label columns with the right descriptive variable names
4. Merge the 3 dataframes together for both the test- and trainingdata
5. Merge the two dataframes which are the result of step 4 in order to get one tidy and complete dataset
6. Label the activities with descriptive activity names
7. Select the 'mean' and 'std' variables together with the subjectnumber and activity name. Selection is stored in new dataframe
    (now the first 4 steps of the assignment are done)
8. Group by and summarise data into the format which is asked for using dplyr- and tidyr packages.


### Codebook

The final file is called tidydata.txt. It contains four colums (or variables).

1. Subjectnumber -> Refers to the subject who performed the activity
2. Activity -> Refers to the activity which was performed 
3. Measure -> The measurement that is summarized in column 4.
4. Mean -> The mean of the measurement described in column 3.
