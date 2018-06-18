###############################################################
# Run all Models
###############################################################


#--------------------------------------------------------------
# Step 1: Include Library
#--------------------------------------------------------------
import sys
import os
import time



#--------------------------------------------------------------
# Step 2: Checking for correct number of parameters
#--------------------------------------------------------------
# Getting command line arguments
args=sys.argv
if len(args)!=4:
  print "\nError !!! Wrong number of parameters"
  print "\nUsages: $python runAllModels.py <dataFileName.csv> <trainingPercentage> <acceptableError>"
  print "\nExample: $python runAllModels.py dataFileName.csv 70 1\n"
  exit()  

#--------------------------------------------------------------
# Step 3: Getting the starting time
#--------------------------------------------------------------
print "\n.........All Running Model....."
startTime = time.time()


#--------------------------------------------------------------
# Step 4: Variable Declaration
#--------------------------------------------------------------
InputDataFileName=args[1]     # Data FileName
training = int(args[2])# Training Percentage; Testing = 100 - Training
acceptableError = int(args[3])   # acceptableError


#--------------------------------------------------------------
# Step 5: Run all models; one by one
#--------------------------------------------------------------
# 5.1 Running randomforest
cmd='rscript randomForest.R %s %d %d'%(InputDataFileName, training, acceptableError)
os.system(cmd)

# 5.2 Running neuralNetwork
cmd='rscript neuralNetwork.R %s %d %d'%(InputDataFileName, training, acceptableError)
os.system(cmd)

# 5.3 Running linearModel
cmd='rscript linearModel.R %s %d %d'%(InputDataFileName, training, acceptableError)
os.system(cmd)
          

# 5.4 Running decisionTree
cmd='rscript decisionTree.R %s %d %d'%(InputDataFileName, training, acceptableError)
os.system(cmd)
          

#--------------------------------------------------------------
# Step 6: Merge all result file into one file
#--------------------------------------------------------------

# Note: Do it yourself



#--------------------------------------------------------------
# Step 7: Grand Total Running Time
#--------------------------------------------------------------
totalTime = time.time() - startTime
print "\n\nTotal Running Time:", totalTime, " sec"
print "\nFinished\n"




