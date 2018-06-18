1. To Run each model one by one at command line
Usages: $rscript modelFile.R <dataFileName> <trainingPercentage> <acceptableError>
Example: $rscript randomForest.R dataFile.csv 70 1


2. To Run all models at once at command line
Using Python-->
Usages: $python runAllModels.py <dataFileName> <trainingPercentage> <acceptableError>
Example: $python runAllModels.py dataFile.csv 70 1

Using R-->
Usages: $rscript runAllModels.R <dataFileName> <trainingPercentage> <acceptableError>
Example: $rscript runAllModels.R dataFile.csv 70 1
