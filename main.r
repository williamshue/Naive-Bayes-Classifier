#setwd("/Users/williamshue/Downloads/naive-bayes-classifier-master")
#read the data from the text file in as a matrix, data frame
subSet <- read.table("dataSubset.txt")

bins <- data.frame(matrix(ncol = 6, nrow = 0))
x <- c("# of rooms", "dist. from highway", "prop. tax", "stu. teach. ratio", "med. val. of homes", "buy or not")
colnames(bins) <- x

#rules for making bins for highway
counter <- 1
for (i in subSet[,2]){ 
  if(i > 4){
    bins[counter,2] <- "far" 
  } else if(i > 2 && i < 4){    
    bins[counter,2] <- "moderate"
  } else {
    bins[counter,2] <- "nearby"
  }
  counter <- counter + 1
}

#rules for making bins for rooms sizes
counter <- 1
for (i in subSet[,1]){ 
  if(i > 7){
    bins[counter,1] <- "large" 
  } else if(i > 6 && i < 7){
    bins[counter,1] <- "medium"
  } else {
    bins[counter,1] <- "small"
  }
  counter <- counter + 1
}

#rules for making bins for stu. teach. ratio
counter <- 1
for (i in subSet[,4]){ 
  if(i < 16){
    bins[counter,4] <- "small class" 
  } else {
    bins[counter,4]<- "large class"
  }
  counter <- counter + 1
}

#rules for making bins for property tax
#note! tax threshold changed to 266.5
counter <- 1
for (i in subSet[,3]){ 
  if(i <= 266.5){
    bins[counter,3] <- "high tax" 
  } else {
    bins[counter,3]<- "low tax"
  }
  counter <- counter + 1
}

#rules for making bins for property value
counter <- 1
for (i in subSet[,5]){ 
  if(i < 32){
    bins[counter,5] <- "high val." 
  } else {
    bins[counter,5]<- "low val."
  }
  counter <- counter + 1
}

#enter the manually calculated yes' and nos from the spreadsheet
bins[1,6] <- "yes"
bins[2,6] <- "yes"
bins[3,6] <- "yes"
bins[4,6] <- "yes"
bins[5,6] <- "no"
bins[6,6] <- "yes"
bins[7,6] <- "no"
bins[8,6] <- "no"
bins[9,6] <- "no"
bins[10,6] <- "no"

bins[56,6] <- "yes"
bins[99,6] <- "yes"
bins[145,6] <- "no"
bins[187,6] <- "yes"
bins[372,6] <- "yes"
bins[369,6] <- "yes"
bins[346,6] <- "no"
bins[306,6] <- "yes"
bins[415,6] <- "yes"
bins[506,6] <- "no"


#create probability table for highway data
highway_PT <- data.frame(matrix(0, ncol = 5, nrow = 4))
x <- c("distance-description", "# of yes'", "# of nos", "P(Y)", "P(N)")
colnames(highway_PT) <- x
x <- c("far", "moderate", "nearby", "results")
rownames(highway_PT) <- x

#create probability table for rooms data
rooms_PT <- data.frame(matrix(0, ncol = 5, nrow = 4))
x <- c("size-description", "# of yes'", "# of nos", "P(Y)", "P(N)")
colnames(rooms_PT) <- x
x <- c("small", "medium", "large", "results")
rownames(rooms_PT) <- x

#create probability table for class size
classSz_PT <- data.frame(matrix(0, ncol = 5, nrow = 3))
x <- c("size-description", "# of yes'", "# of nos", "P(Y)", "P(N)")
colnames(classSz_PT) <- x
x <- c("large", "small", "results")
rownames(classSz_PT) <- x

#create probability table for prop val
value_PT <- data.frame(matrix(0, ncol = 5, nrow = 3))
x <- c("price-description", "# of yes'", "# of nos", "P(Y)", "P(N)")
colnames(value_PT) <- x
x <- c("high", "low", "results")
rownames(value_PT) <- x

#create probability table for tax
tax_PT <- data.frame(matrix(0, ncol = 5, nrow = 3))
x <- c("tax-description", "# of yes'", "# of nos", "P(Y)", "P(N)")
colnames(tax_PT) <- x
x <- c("high", "low", "results")
rownames(tax_PT) <- x


#create probability table for overall results
results_PT <- data.frame(matrix(0, ncol = 2, nrow = 3))
x <- c("yes/no", "P(y)/p(n)")
colnames(results_PT) <- x
x <- c("yes", "no", "totals")
rownames(results_PT) <- x


#array of indexes to check
ind_check <- c(1,2,3,4,5,6,7,8,9,10,56,99,145,187,372,369,346,306,415,506)

#populate frequency tables for given factors
for(i in ind_check){
  
  #rules for when a yes (buy) is encountered
  if(bins[i,6] == "yes"){
    
    #rules for rooms
    if(bins[i,1] == "small"){
      rooms_PT[1,2] <- rooms_PT[1,2] + 1
    }
    if(bins[i,1] == "medium"){
      rooms_PT[2,2] <- rooms_PT[2,2] + 1
    }
    if(bins[i,1] == "large"){
      rooms_PT[3,2] <- rooms_PT[3,2] + 1
    }
    
    #rules for highway
    if(bins[i,2] == "far"){
      highway_PT[1,2] <- highway_PT[1,2] + 1
    }
    if(bins[i,2] == "moderate"){
      highway_PT[2,2] <- highway_PT[2,2] + 1
    }
    if(bins[i,2] == "nearby"){
      highway_PT[3,2] <- highway_PT[3,2] + 1
    }
    
    #rules for prop tax.
    if(bins[i,3] == "low tax"){
      tax_PT[1,2] <- tax_PT[1,2] + 1
    }
    if(bins[i,3] == "high tax"){
      tax_PT[2,2] <- tax_PT[2,2] + 1
    }
    
    #rules for student teacher ratio
    if(bins[i,4] == "large class"){
      classSz_PT[1,2] <- classSz_PT[1,2] + 1
    }
    if(bins[i,4] == "small class"){
      classSz_PT[2,2] <- classSz_PT[2,2] + 1
    }
    
    #rules for med home value
    if(bins[i,5] == "high val."){
      value_PT[1,2] <- value_PT[1,2] + 1
    }
    if(bins[i,5] == "low val."){
      value_PT[2,2] <- value_PT[2,2] + 1
    }
  }
  
  #rules for when a no (do not buy) is encountered
  if(bins[i,6] == "no"){
    
    #rules for rooms
    if(bins[i,1] == "small"){
      rooms_PT[1,3] <- rooms_PT[1,3] + 1
    }
    if(bins[i,1] == "medium"){
      rooms_PT[2,3] <- rooms_PT[2,3] + 1
    }
    if(bins[i,1] == "large"){
      rooms_PT[3,3] <- rooms_PT[3,3] + 1
    }
    
    #rules for highway
    if(bins[i,2] == "far"){
      highway_PT[1,3] <- highway_PT[1,3] + 1
    }
    if(bins[i,2] == "moderate"){
      highway_PT[2,3] <- highway_PT[2,3] + 1
    }
    if(bins[i,2] == "nearby"){
      highway_PT[3,3] <- highway_PT[3,3] + 1
    }
    
    #rules for prop tax.
    if(bins[i,3] == "low tax"){
      tax_PT[1,3] <- tax_PT[1,3] + 1
    }
    if(bins[i,3] == "high tax"){
      tax_PT[2,3] <- tax_PT[2,3] + 1
    }
    
    #rules for student teacher ratio
    if(bins[i,4] == "large class"){
      classSz_PT[1,3] <- classSz_PT[1,3] + 1
    }
    if(bins[i,4] == "small class"){
      classSz_PT[2,3] <- classSz_PT[2,3] + 1
    }
    
    #rules for med home value
    if(bins[i,5] == "high val."){
      value_PT[1,3] <- value_PT[1,3] + 1
    }
    if(bins[i,5] == "low val."){
      value_PT[2,3] <- value_PT[2,3] + 1
    }
  }
}

populate_matrix <- function(your_matrix){
  for(i in 1:nrow(your_matrix)-1){
    your_matrix[i,1] <- rowSums(your_matrix[i,])
  }
  for(i in 1:nrow(your_matrix)-1){
    #the 20 is hardcoded.
    your_matrix[i,4] <- your_matrix[i,2]/20
    your_matrix[i,5] <- your_matrix[i,3]/20
  }
  for(i in 1:5){
    your_matrix[nrow(your_matrix),i] <- colSums(your_matrix[i])
  }
  #print("pop max done")
  return(your_matrix)
}

highway_PT <- populate_matrix(highway_PT[])
rooms_PT <- populate_matrix(rooms_PT[])
tax_PT <- populate_matrix(tax_PT[])
classSz_PT <- populate_matrix(classSz_PT[])
value_PT <- populate_matrix(value_PT[])

#populate results population table

yes_count <- 0
no_count <- 0
for(i in ind_check){
  if(bins[i,6] == "yes"){
    yes_count <- yes_count + 1
  }
  if(bins[i,6] == "no"){
    no_count <- no_count + 1
  }
}

results_PT[1,1] <- yes_count
results_PT[2,1] <- no_count
results_PT[3,1] <- colSums(results_PT[1])
#the 20 is hardcoded
results_PT[1,2] <- yes_count/20
results_PT[2,2] <- no_count/20
results_PT[3,2] <- colSums(results_PT[2])

#now update the rest of the model
#tax, class size & rooms

for(i in 11:506){
  if(is.element(i, ind_check)){ #skip already processed elements
    i <- i + 1
  }
  
  pTax_y <- 0
  pTax_n <- 0
  pclassSz_y <- 0
  pclassSz_n <- 0
  prooms_y <- 0
  prooms_n <- 0
  
  if(bins[i,3]=="low tax"){
    pTax_y <- tax_PT[2,4]
    pTax_n <- tax_PT[2,5]
  } else {
    pTax_y <- tax_PT[1,4]
    pTax_n <- tax_PT[1,5]
  }
  
  if(bins[i,4]=="large class"){
    pclassSz_y <- classSz_PT[1,4]
    pclassSz_n <- classSz_PT[1,5]
  } else {
    pclassSz_y <- classSz_PT[2,4]
    pclassSz_n <- classSz_PT[2,5]
  }
  
  if(bins[i,1]=="large"){
    prooms_y <- rooms_PT[1,4]
    prooms_n <- rooms_PT[1,5]
  } else if(bins[i,1]=="medium") {
    prooms_y <- rooms_PT[2,4]
    prooms_n <- rooms_PT[2,5]
  } else {
    prooms_y <- rooms_PT[1,4]
    prooms_n <- rooms_PT[1,5]
  }
  
  p_y <- pTax_y*pclassSz_y*prooms_y
  p_n <- pTax_n*pclassSz_n*prooms_n
    
  if(p_y > p_n){
    cat("Y")
    bins[i,6] <- "yes"
  } else {
    bins[i,6] <- "no"
  }
}

print("done")




