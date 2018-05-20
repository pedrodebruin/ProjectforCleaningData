# Codebook for tidy data produced by run\_analysis.R

## Output files

Executing <i>run_analysis.R</i> will produce a tidy dataset located in the _datasets/mergedUCI_ folder, while the original 
UCI HAR dataset will be downloaded to a folder called _UCI HAR Dataset_.
**Specifically, the tidy dataset asked in task 5 corresponds to the _datasets/mergedUCI/tidyTask5.txt_ file.**

## The Raw Dataset

The input raw dataset is located in the _datasets/UCI HAR Dataset_ folder.

This folder has the following files and folders:
* README.txt
* features\_info.txt: Shows information about the variables used on the feature vector.
* features.txt: List of all features.
* activity\_labels.txt: Links the class labels with their activity name.
* train/X\_train.txt: Training set.
* train/y\_train.txt: Training labels.
* test/X\_test.txt: Test set.
* test/y\_test.txt: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

* train/subject\_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* train/Inertial Signals/total\_acc\_x\_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the total\_acc\_x\_train.txt and total\_acc\_z\_train.txt files for the Y and Z axis.
* train/Inertial Signals/body\_acc\_x\_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* train/Inertial Signals/body\_gyro\_x\_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
Notes:
* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

## The Tidy Dataset

The output tidy dataset is written out to the _datasets/mergedUCI_ folder.
This folder contains the following files and folders:
* Inertial Signals: similar to the <i>Inertial Signals</i> folder of the unmerged _UCI HAR Dataset_, but with files corresponding to merged tables
* subject\_merged.txt: the subject table made from merging test/subject.txt and train/subject.txt
* X\_merged.txt: the table made from merging <i>train/X_train.txt</i> and <i>test/X_test.txt</i>. 
* y\_merged.txt: the table made from merging <i>train/y_train.txt</i> and <i>test/y_test.txt</i>. 
* tidyData.txt: the tidy version of <i>X_merged</i>, which also includes columns for activity and subject Only features related to std() and mean() are kept, as is asked in the project description
* tidyTask5.txt: the tidy data table asked for in task 5 of the project assignment, where the means of features are stored per subject and activity


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

