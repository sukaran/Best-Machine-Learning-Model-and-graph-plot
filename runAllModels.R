###############################################################
# Run all Models
###############################################################


#--------------------------------------------------------------
# Step 1: Include Library
#--------------------------------------------------------------

#None



#--------------------------------------------------------------
# Step 2: Checking for correct number of parameters
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
# Step 3: Getting the starting time
#--------------------------------------------------------------
cat("\n.........All Running Model.....")
startTime = proc.time()[3]


#--------------------------------------------------------------
# Step 4: Variable Declaration
#--------------------------------------------------------------
InputDataFileName=args[1]     # Data FileName
training = as.numeric(args[2])# Training Percentage; Testing = 100 - Training
acceptableError = as.numeric(args[3])   # acceptableError


#--------------------------------------------------------------
# Step 5: Run all models; one by one
#--------------------------------------------------------------
# 5.1 Running randomforest
cmd=paste('rscript randomForest.R',InputDataFileName, c(training),c(acceptableError))
system(cmd)

# 5.2 Running neuralNetwork
cmd=paste('rscript neuralNetwork.R',InputDataFileName, c(training),c(acceptableError))
system(cmd)

# 5.3 Running linearModel
cmd=paste('rscript linearModel.R',InputDataFileName, c(training),c(acceptableError))
system(cmd)

# 5.4 Running decisionTree
cmd=paste('rscript decisionTree.R',InputDataFileName, c(training),c(acceptableError))
system(cmd)


#--------------------------------------------------------------
# Step 6: Merge all result file into one file
#--------------------------------------------------------------
mydata1=read.csv("C:\Users\lenovo\Desktop\summerML\Day-08 - Automate ML Process\Day-08 - Automate ML Process\04 - Practical Session on R (using Coding)\Session-06-Run all models through command line\1", header=T)
mydata2=read.csv("C:\Users\lenovo\Desktop\summerML\Day-08 - Automate ML Process\Day-08 - Automate ML Process\04 - Practical Session on R (using Coding)\Session-06-Run all models through command line\2" ,header=T)
mydata3=read.csv()
mydata4=read.csv()

myfulldata=merge(mydata1,mydata2)



#--------------------------------------------------------------
# Step 7: Grand Total Running Time
#--------------------------------------------------------------
totalTime = proc.time()[3] - startTime
cat("\n\nTotal Running Time:", totalTime, " sec")
cat("\nFinished\n")




