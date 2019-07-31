setwd("/Users/williamshue/Downloads/naive-bayes-classifier")
#print(getwd())

dataSet <- read.table("dataSubset.txt")

print(dataSet[1,])

print('done')

#find mean and median of column 10 and 14
#make a data frame from the text file
subDataSet <- read.table("dataSubset.txt")

#print(dataSet[1,])

#find mean and median of column 10 and 14

#make vectors from the data frame 
column_10 <- subDataSet[,3]
column_14 <- subDataSet[,5]

#find the mean and medians of the vectors from above    
print(mean(column_10))
print(median(column_10))

print(mean(column_14))
print(median(column_14))

print('donea')

