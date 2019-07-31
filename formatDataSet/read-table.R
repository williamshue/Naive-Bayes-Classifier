#DESCRIPTION: this file takes the plain text file created by the formatDataSet.R script and puts it into a data frame
#the data frame is then reduced to contain only the columns we want to use in the bayesian classification
#this file also prints the data to the plain the plain text file named ------- to use in the other directory

#create a data frame using read.table
dataSet <- read.table("dataSet.txt", header = FALSE)

#print(dataSet[1,])
#store column 6 in the column_6 vector variable
column_6 <- dataSet[,6]
#print(column_6[2]) #test that the output is correct
#do the same for the other columns
column_9 <- dataSet[,9]
column_10 <- dataSet[,10]
column_11 <- dataSet[,11]
column_14 <- dataSet[,14]

#alternatively we can simply make a subtable of the table from our original data set by removing the unwanted columns
dataSubset = subset(dataSet, select = -c(1,2,3,4,5,7,8,12,13))

write.table(dataSubset, file = "dataSubset.txt", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
#seems to be writing to the wrong directory, needs to be fixed.

print("done")