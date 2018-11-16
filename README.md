# Cross-Validation
How to write your own code for cross validation

The code uses diabeties dataset imported from mlbech library. If you don't already have it, install "mlbench" and then import the dataset as done in the code.

Code is self-explainatory. It is well commented.
Brief:
1: partiton the dataset into n subsets
2: select one of the subset as test and rest all as train
3. train the model with train subset and then calculate the rmse on test dataset
4: return the average of all the n rmse values

enjoy!
