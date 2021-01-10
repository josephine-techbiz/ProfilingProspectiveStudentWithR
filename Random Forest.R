library(randomForest)
library(Metrics)
library(caret)

#Model IPK
ForestOfStudent<- randomForest(ipk~nemgroup+nmjur+nmsla, 
                               data = training4)
#Model semester
ForestOfStudentS1<- randomForest(semester~nemgroup+nmjur+nmsla, data = training5)


which.min(ForestOfStudent$mse)
sqrt(ForestOfStudent$mse[which.min(ForestOfStudent$mse)])

# Tune RF
m2 <- tuneRF(
  x          = training4[features],
  y          = training4$ipk,
  ntreeTry   = 500,
  mtryStart  = 5,
  stepFactor = 1.5,
  improve    = 0.01,
  trace      = FALSE      
)
m2


# hyperparameter grid search
hyper_grid_rf <- expand.grid(
  mtry       = seq(1, 8, by = 2),
  node_size  = seq(4, 10, by = 4),
  #sampe_size = c(.80),
  OOB_RMSE   = 0
)

# total number of combinations
nrow(hyper_grid_rf)

# mencari mtry dan nodesize dari error paling rendah
for(i in 1:nrow(hyper_grid_rf)) {
  
  # train model
  model <- ranger(
    formula         = ipk ~ nemgroup+nmjur+wilayah, 
    data            = training4, 
    num.trees       = 499,
    mtry            = hyper_grid_rf$mtry[i],
    min.node.size   = hyper_grid_rf$node_size[i],
    #sample.fraction = hyper_grid$sampe_size[i],
    seed            = 123
  )
  
  # add OOB error to grid
  hyper_grid_rf$OOB_RMSE[i] <- sqrt(model$prediction.error)
}
hyper_grid_rf %>% 
  dplyr::arrange(OOB_RMSE) %>%
  head(10)


ForestOfStudent499a<- randomForest(ipk~nemgroup+nmjur+nmsla, 
                                   data = training4, 
                                   ntree=499, mtry=3, nodesize=4)


# by Metrics - Random Forest
rf <- data.frame(RMSE = rmse(testing4$ipk, pred.rf.499a) ,
                 MSE = mse(testing4$ipk, pred.rf.499a),
                 MAE = mae(testing4$ipk, pred.rf.499a))

# Bikin prediksi & confusion matrix
pred.rf.s1 <- predict(ForestOfStudentS1, testing5,na.action = na.pass)
t.rf.s1 <- table(as.factor(pred.rf.s1), 
                 confusionMatrix(t.rf.s1)
                 
                 # RF Prodi #
                 ForestOfStudentJur<- randomForest(nmjur~nemgroup+wilayah, 
                                                   data = training6)
                 pred.rf.jur <- predict(ForestOfStudentJur, testing6,na.action = na.pass)
                 accuracy(testing4$nmjur, pred.rf.jur)
                 