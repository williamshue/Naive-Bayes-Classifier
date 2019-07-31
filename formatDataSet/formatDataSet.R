#DESCRIPTION: This script takes just the raw data from the data set we found and formats it into simple rows and columns in a plain text file

# installing 'stringr'
#install.packages("stringr")

# load 'stringr'
library(stringr)

fileName <- 'rawDataSet.txt'
bigString <- readChar(fileName, file.info(fileName)$size)
dataSet <- unlist(strsplit(bigString, "\n"))

sink("dataSet.txt")
i <- 1;
while(i <= length(dataSet)) {
  values <- paste(dataSet[i],dataSet[i+1])
  
  cat(str_trim(values))
  cat("\n")
  i <- i+2
}
sink()

print('done')