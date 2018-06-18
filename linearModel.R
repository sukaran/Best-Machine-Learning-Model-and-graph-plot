###############################################################
#                                                             #
#            Linear Model for Regression                      #
#                                                             #
###############################################################


#--------------------------------------------------------------
# Step 1: Checking for correct number of parameters
#--------------------------------------------------------------

# Getting command line arguments
args=commandArgs(trailingOnly = TRUE)
if(length(args)!=3){
  cat("\nError !!! Wrong number of parameters") 
  cat("\nUsages: $rscript modelFile.R <dataFileName.csv> <trainingPercentage> <acceptableError>")
  cat("\nExample: $rscript modelFile.R dataFileName.csv 70 1\n") 
  q()  
}


#--------------------------------------------------------------
# Step 2: Include Library
#--------------------------------------------------------------

# No Library ia required


#--------------------------------------------------------------
# Step 3: Getting the starting time
#--------------------------------------------------------------
cat("\n\nRunning Linear Model.....")
startTime = proc.time()[3]


#--------------------------------------------------------------
# Step 4: Variable Declaration
#--------------------------------------------------------------
modelName <- "linearModel"
InputDataFileName=args[1]     # Data FileName
training = as.numeric(args[2])# Training Percentage; Testing = 100 - Training
acceptableError = as.numeric(args[3])   # acceptableError


#--------------------------------------------------------------
# Step 5: Data Loading
#--------------------------------------------------------------
dataset <- read.csv(InputDataFileName)      # Read the datafile


#--------------------------------------------------------------
# Step 6: Count total number of observations/rows.
#--------------------------------------------------------------
totalDataset <- nrow(dataset)



#--------------------------------------------------------------
# Step 7: Choose Target variable
#--------------------------------------------------------------
target  <- names(dataset)[1]   # i.e. RMSD


#--------------------------------------------------------------
# Step 8: Choose inputs Variables
#--------------------------------------------------------------
inputs <- setdiff(names(dataset),target)


#--------------------------------------------------------------
# Step 9: Select Training Data Set
#--------------------------------------------------------------
trainDataset <- dataset[1:(totalDataset * training/100),c(inputs, target)]


#--------------------------------------------------------------
# Step 10: Select Testing Data Set
#--------------------------------------------------------------
testDataset <- dataset[(totalDataset * training/100):totalDataset,c(inputs, target)]


#--------------------------------------------------------------
# Step 11: Model Building (Training)
#--------------------------------------------------------------
formula <- as.formula(paste(target, "~", paste(c(inputs), collapse = "+")))
model   <- lm(formula, trainDataset)



#--------------------------------------------------------------
# Step 12: Prediction (Testing)
#--------------------------------------------------------------
Predicted <- predict(model, testDataset)


#--------------------------------------------------------------
# Step 13: Extracting Actual
#--------------------------------------------------------------
Actual <- as.double(unlist(testDataset[target]))


#--------------------------------------------------------------
# Step 14: Model Evaluation
#--------------------------------------------------------------
# Step 14.1: Correlation
r <- round(cor(Actual,Predicted),2)

# Step 14.2: RSquare
R <- round(r * r,2) 

# Step 14.3: MAE (Mean Absolute)
mae <- round(mean(abs(Actual-Predicted)),2)

# Step 14.4: Accuracy
accuracy <- round(mean(abs(Actual-Predicted) <=acceptableError),4)*100


# Step 14.5: Scatter Plot
png(filename=paste(modelName,"-ScatterPlot.png",sep=''))
plot(Actual,Predicted,main=paste("Actual Vs Predicted\n",modelName),xlab="Predicted", ylab="Actual")#, pch=19)
abline(lm(Actual ~ Predicted,),col="White") 
grabage<-dev.off()

# Step 14.6: Total Time
totalTime = proc.time()[3] - startTime

# Step 14.7: Save evaluation resut 
result <- data.frame(modelName,r,R,mae,accuracy,acceptableError,totalTime)[1:1,]


#--------------------------------------------------------------
# Step 15: Writing to file
#--------------------------------------------------------------
# Step 15.1: Writing to file (evaluation result)
write.csv(result, file=paste(modelName,"-Evaluation-Result.csv",sep=''), row.names=FALSE)

# Step 15.2: Writing to file (Actual and Predicted)
write.csv(data.frame(Actual,Predicted), file=paste(modelName,"-ActualPredicted-Result.csv",sep=''), row.names=FALSE)


#--------------------------------------------------------------
# Step 16: Saving the Model
#--------------------------------------------------------------
save.image(file=paste(modelName,"-Model.RData",sep=''))

cat("\n..Done !! ", modelName, " Model Finished.....")


#--------------------------------------------------------------
#                           END 
#--------------------------------------------------------------
