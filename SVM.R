library(e1071) 
library(caTools)

## Model IPK ##
SVM_lin = svm(formula = ipk~nemgroup+nmjur+nmsla, 
              data = training4, 
              type = 'eps-regression', 
              kernel = 'linear')


#by Metrics - SVM Linear
svmX <- data.frame(RMSE = rmse(testing4$ipk, pred.svm.lin), 
                   MSE = mse( testing4$ipk, pred.svm.lin),
                   MAE = mae(testing4$ipk, pred.svm.lin))

# SVM Semester #
SVM_sem = svm(formula = semester~nemgroup+nmjur+nmsla, 
              data = training5, 
              type = 'C-classification', 
              kernel = 'linear')

pred.svm.sem <- predict(SVM_sem, testing5,na.action = na.pass)
pred.svm.sem

levels(testing5$nmsla) <- levels(training5$nmsla)
t.svm.s1 <- 
  table(as.factor(pred.svm.sem), as.factor(testing5$semester))

confusionMatrix(t.svm.s1)

# SVM Prodi # 
SVM_jur = svm(formula = nmjur~nemgroup+nmsla, data = training6, 
              type = 'C-classification', kernel = 'linear')

pred.svm.jur <- predict(SVM_jur, testing6,na.action = na.pass)
accuracy(testing6$nmjur, pred.svm.jur)