
#Library downloading
library(caret)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(rattle)
library(e1071)
library(randomForest)
set.seed(1)

train.url <-
  "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
test.url <- 
  "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

path <- paste(getwd(),"/", "machine", sep="")
train.file <- file.path(path, "machine-train-data.csv")
test.file <- file.path(path, "machine-test-data.csv"


train.data.raw <- read.csv(train.file, na.strings=c("NA","#DIV/0!",""))
test.data.raw <- read.csv(test.file, na.strings=c("NA","#DIV/0!",""))

#Cleaning data
train.data.clean1 <- train.data.raw[,8:length(colnames(train.data.raw))]
test.data.clean1 <- test.data.raw[,8:length(colnames(test.data.raw))]

# Naming NAs
train.data.clean1 <- train.data.clean1[, colSums(is.na(train.data.clean1)) == 0] 
test.data.clean1 <- test.data.clean1[, colSums(is.na(test.data.clean1)) == 0] 

# Checking for near zero variance predictors and deleting them if needed
nzv <- nearZeroVar(train.data.clean1,saveMetrics=TRUE)
zero.var.ind <- sum(nzv$nzv)

if ((zero.var.ind>0)) {
  train.data.clean1 <- train.data.clean1[,nzv$nzv==FALSE]
}

#Slicing for cross validation

in.training <- createDataPartition(train.data.clean1$classe, p=0.70, list=F)
train.data.final <- train.data.clean1[in.training, ]
validate.data.final <- train.data.clean1[-in.training, ]

#Training the model
control.parms <- trainControl(method="cv", 5)
rf.model <- train(classe ~ ., data=train.data.final, method="rf",
                  trControl=control.parms, ntree=251)
rf.model

#Estimating 
rf.predict <- predict(rf.model, validate.data.final)
confusionMatrix(validate.data.final$classe, rf.predict)

accuracy <- postResample(rf.predict, validate.data.final$classe)
acc.out <- accuracy[1]

overall.ose <- 
  1 - as.numeric(confusionMatrix(validate.data.final$classe, rf.predict)
                 $overall[1])

#Running the model
results <- predict(rf.model, 
                   test.data.clean1[, -length(names(test.data.clean1))])
results

#Decision tree
treeModel <- rpart(classe ~ ., data=train.data.final, method="class")
fancyRpartPlot(treeModel)
