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

The initial model created for our classifier was created according the criteria containted in the spreadsheet in this directory. We first selected the top ten values and then assigned them a 'yes' or 'no' value based on the thresholds contained in the spreadsheet. We found that this this process caused our model to be somewhat lopsided and decided to select other random indexes to perform the same process on; this is why the indexes are 1-10 and then become chaotic.

This still left the model somehwat lopsided, with some manual tweaking of the 'yes' and 'no' results in the model we eventually settled on an inital model that gave a good spread of 'yes' and 'no' results on the select data. The following table illustrates the version of the model that was run across the rest of our data set: (this process is explained in the next section)

| Row Number | Number of Rooms (House Size) | Property Tax | Student-Teacher Class Ratio | Yes or No |
|------------|------------------------------|--------------|-----------------------------|-----------|
| 1          | medium                       | low tax      | small class                 | yes       |
| 2          | medium                       | high tax     | large class                 | yes       |
| 3          | large                        | high tax     | large class                 | yes       |
| 4          | medium                       | high tax     | large class                 | yes       |
| 5          | large                        | high tax     | large class                 | no        |
| 6          | medium                       | high tax     | large class                 | yes       |
| 7          | medium                       | low tax      | small class                 | no        |
| 8          | medium                       | low tax      | small class                 | no        |
| 9          | medium                       | low tax      | small class                 | no        |
| 10         | medium                       | low tax      | small class                 | no        |
| 56         | large                        | high tax     | large class                 | no        |
| 99         | large                        | low tax      | large class                 | no        |
| 145        | medium                       | low tax      | small class                 | no        |
| 187        | large                        | high tax     | large class                 | yes       |
| 306        | medium                       | high tax     | large class                 | yes       |
| 346        | medium                       | low tax      | large class                 | no        |
| 369        | medium                       | low tax      | large class                 | yes       |
| 372        | medium                       | low tax      | large class                 | yes       |
| 415        | medium                       | low tax      | large class                 | yes       |
| 506        | medium                       | low tax      | large class                 | no        |


Along with assigning yes and no values to each of the indexes used in the inital model. We also needed to find the probabiliaties for each variable. The probabilaties for each variable allowed us to then apply Bayes equation and assin 'yes' and 'no' values to all of the other indexes. With each assignment of 'yes' and no the overall model was updated, making it more and more accurate (this process is also explained in the next section). Below are the initial probabilaties tables for each variable used: 

Probability Table for Property Tax: 

|         | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|---------|----------|-----------|----------|--------|-------|
| High    | 12       | 4         | 8        | 0.2    | 0.4   |
| Low     | 8        | 6         | 2        | 0.3    | 0.1   |
| Results | 20       | 10        | 10       | 0.5    | 0.5   |


Probability Table for Student Teacher Class Ratio: 

|         | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|---------|----------|-----------|----------|--------|-------|
| Large   | 14       | 9         | 5        | 0.45   | 0.25  |
| Small   | 6        | 1         | 5        | 0.05   | 0.25  |
| Results | 20       | 10        | 10       | 0.50   | 0.50  |


Probability Table for Number of Rooms (house size): 

|          | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|----------|----------|-----------|----------|--------|-------|
| Small    | 0        | 0         | 0        | 0.0    | 0.0   |
| Medium   | 15       | 8         | 7        | 0.4    | 0.35  |
| Large    | 5        | 2         | 3        | 0.1    | 0.15  |
| Results  | 20       | 10        | 10       | 0.5    | 0.05  |


Note: as mentioned above, we initially started with the intention of using 5 variables but scaled down to 3 to simplify the process and because some of the variables were not well distributed for this use case. Improvemnts in these factors can be made in the future. If you are interested in what the probablaties for these other two variables, feel free to run the 'main.r' file and see their results.

To wrap up this section here is the final table covering the probablaties of all the tables above, how many overall 'yes'', 'nos' and their corresponding probabilaties is outlined here: (this table is very important in the us of the model below)

|         | Yes or No | P(Yes) or P(No) |
|---------|-----------|-----------------|
| Yes     | 10        | 0.5             |
| No      | 10        | 0.5             |
| Results | 20        | 1.0             |

# Applying the Model

After the probabilaties for each of the variables in the initial model had been determined it was simply time to apply the model to the rest of our data set. This meant applying the following equations to every index in the rest of the data set, the 20 entries which had already been labeled with a  'yes' or 'no' to produce the model described above were skipped.

![Bayes Equations](CodeCogsEqn.gif)

The following pseudo-code is how these equations were applied to the rest of the data set:

    For all indexes:
    - Verify it has not already been labeled (skip it if it has)
      - Check the the tax bin it's using (high or low)
      - Check the class ratio bin it's using (small or large)
      - Check the room size bin it's using (small medium large)
        - Plug the corespondings bin and 'yes' or 'no' values into the equations above
        - If 'yes' > 'no' prob
          - label index 'yes' 
          - else
          - label index 'no'
      - Based on the results, update the tax, class-ratio, room size and overall results prob. tables
    -Repeat for next index

As is illustrated in the pseudo-code after the entries of every index are processed the model gets more accurate as it has been fed more data. This means that anyone who has data on the criteria the model is designed to process could 'bin' that data and have this program process it, the program would then tell them with how much confidence they should or should not buy the house based on the 3 criteria.

# Results

Overall desipte the initial issues that our data caused such as difficutly putting it into the right bins, it's lopsided spread and the resulting issues with the initial model itself, the program was a success. The table below is the same as the overall probabilaties table after the model has been applied to the entire data set: 

|         | Yes or No | P(Yes) or P(No) |
|---------|-----------|-----------------|
| Yes     | 439        | 0.8524272             |
| No      | 76        | 0.1475728             |
| Results | 515        | 1.0000000             |

For the sake of completness here are the final probabilaties for all other variables: 

Probability Table for Property Tax: 

|         | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|---------|----------|-----------|----------|--------|-------|
| High    | 83       | 58         | 25        | 0.1126214    | 0.04854369   |
| Low     | 432        | 381             | 51        | 0.7398058        | 0.09902913   |
| Results | 515       | 439        | 76           | 0.8524272    | 0.14757282   |


Probability Table for Student Teacher Class Ratio: 

|         | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|---------|----------|-----------|----------|--------|-------|
| Large   | 388       | 351         | 37        | 0.6815534   | 0.07184466  |
| Small   | 127        | 88         | 39        | 0.1708738   | 0.07572816  |
| Results | 515       | 439        | 76       | 0.8524272   | 0.14757282  |


Probability Table for Number of Rooms (house size): 

|          | Quantity | Yes Count | No Count | P(Yes) | P(No) |
|----------|----------|-----------|----------|--------|-------|
| Small    | 2        | 0         | 2        | 0.000000000    | 0.003883495   |
| Medium   | 447       | 437         | 10       | 0.848543689    | 0.019417476  |
| Large    | 66        | 2         | 64      |  0.003883495   | 0.124271845  |
| Results  | 515       | 439        | 76       | 0.852427184    | 0.147572816  |

In conclusion this program does sucessfuly classify wether or not a user should or should not buy a property based on given data using Bayseian classification and machine learning model. The results are skewed such that the spread of the data is abnormal, for example, it is highly likely the result will be a 'yes' as opposed to a 'no', this indicates there are improvemnts to be made, although the program is in fact fully functional. 

# Future Work

In the future there are many steps which can be taken to improve this model while still using Naive Bayes. For example, a thurough analysis of the distribution of each of the variables and correct action being taken to make them as desirable as possible for the program would be a good first step. Also,  better determination for the bin thresholds should be made and an overall bigger data set would allow for the model to be setup and trained in a more accurate manner. Lastly the program itself can be optomized. 'main.r' which contains the most important script for the project does not run in the most effiecnt runtime and is not broken down into managable chunks and functions. This can be changed in the future for better use comprehension and program fine tuning.
