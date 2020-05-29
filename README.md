First, I downloaded the necessary libraries to R, namely: caret, rpart, rpart.plot, Rcolorbrewer, randomForest, rattle and e1071.

Second, I downloaded the necessary functions and assigned the static variables. Note that the seed is set in a way so that it was possible for someone to repeat the operation.

Third, I downloaded the files and named all missing data indicators as NA so that I could work with them later.

Afterwards, all the NA columns and not needed data (first 7 columns) can be deleted. Moreover, I deleted all the near-zero variance variables.

Next, I sliced the data into 2 sets for futher cross validation: training set consisting of 70% of the data for training the model, and a validation set for checking if the model is good.

Traning the model part

I used the training data set to fit Random Forest model as the latter chooses the most important variables and at the same time avoids the errors connected to outliers and correlated covariates. For this purpose I used 5-fold cross validation for the algorithm. In general, Random Forest is aimed at reducing the variance by averaging multiple deep decision trees. The algorithm is trained on different parts of the data set. At the same time, I used cross validation in order to see how my analysis will generalise to an independent data set. In my case of 5 fold cross-validation the original data set is divided into 5 equally sized sub sets with one set reserved for validation and other for training. When this process is repeated 5 times, the results from the folds are brought to the average. 

Estimating the performance part

The quality is assesed through comparing the forecasted values to the actual ones. This shows the accuracy and out-of-sample error which is the key for understanding how the model will behave with new data. 
In my model the accuracy is  0.9940527 and the out-of-sample error is 0.0059473.

Running the model part

Finally, I run my model to forecast the results.

For better understanding, I also introduced the decision tree visualization.
