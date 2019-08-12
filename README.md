# Naive Bayes Classifier
This project implements a Naive Bayes Classifier to determine if a family would or would not buy a home in a specific location based on various factors.

# Data Set
The data set processed by the classifier was found at: http://lib.stat.cmu.edu/datasets/boston.

We ran into some formatting issues with the data which created the need for the 'formatDataSet' folder which formats the data set so it can easily be read into a matrix data frame in R. We also reduced the data set as we did not find all variables from the original data set relevant or benifical to our alogrithm. We originally scaled down the number of variables to 5 but decided to only implement the bayesian process on 3 as we had some issues with the data not being distributed in a way that lent itself well to a Naive Bayes Classifier. This is made clearer while overviewing the program itself.

In addition, the data set used contained a range of values for each category, in order to implement the classifier properly we also needed store each range of values in bins. The values for the threshold of each bin were originally based on splitting the rage of each variable into equal parts, this was eventually done away with and they were adjusted manually to get the best spread of values possible. Although we initially created thresholds for 5 variables, to limit the complexity of the scope of this project only 3 variables were used in the final implementation of the classifier. These thresholds are outlined in the tables below.

Threshold Values for Property Tax:

| Bin Label   | Threshold Value |
| ----------- | --------------- |
| Low         | <= 258          |
| High        | > 258           |

Threshold Values for Student Teacher Class Ratio:

| Bin Label   | Threshold Value |
| ----------- | --------------- |
| Small Class | <= 17           |
| Large Class | > 17            |

Threshold Values for Number of Rooms (property size):

| Bin Label   | Threshold Value |
| ----------- | --------------- |
| Small       | < 4             |
| Medium      | >= 4 & < 7      |
| Large       | >= 7            |



# Initial Model
The initial model created for our classifier was  


# Applying the Model

![Bayes Equations](CodeCogsEqn.gif)




# Results
