#import the dataset first
library(mlbench)
diabetes_data <- PimaIndiansDiabetes2


subsetting_data <- function(dataset, n)
{
  #find the number of rows in the dataset
  nr <- nrow(dataset)
  
  #calculate the each subset's rows to next decimal value
  row_per_subset <- ceiling(nr/n)
  
  #create a list to hold all the subsets
  myList <- list()
  
  for (l in 1:n) {
    ##find the first row_per_subset data from the dataset
    data1 <- head(dataset, n=row_per_subset)
    
    #delete the previously selected rows from the dataset
    dataset <- dataset[-(1:row_per_subset), , FALSE]
    
    #insert into list the subset
    myList[[l]] <- data1
  }
  return(myList)
}

cross_validation <- function(formul, dataset, k)
{
  #to calculate the average rmse(root mean square) value
  rmse_avg <- 0
  
  #divide the data in k subsets
  subsets <- subsetting_data(dataset, k)
  i <- 1
  while (i <= k) {
    #empty the train and test data
    train_data <- dataset[FALSE,]
    test_data <- dataset[FALSE,]
    
    #assign an index from the subsets to be the test data
    test_data <- subsets[[i]]
    
    #then combine the rest of the subsets to be train data
    for (j in 1:k) {
      #check if index of test is same as train, if yes, skip
      if(j == i){next}
      #else, add it to train data
      train_data <- union(train_data, subsets[[j]])
    }
    #fit a linear model
    fit <- lm(formul, data = train_data)
    #calculate the rmse
    root_mean_square <- rmse(fit, test_data)
    #add it to the total rmse
    rmse_avg <- rmse_avg + root_mean_square
    i <- i+1
  }
  #return the average rmse
  return(rmse_avg/k)
}

avg_rmse <- cross_validation(mass~., diabetes_data, 5)
print(avg_rmse)
