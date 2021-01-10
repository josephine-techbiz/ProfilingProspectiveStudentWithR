library(dplyr)
library(rpart)       # performing regression trees
library(rpart.plot)  # plotting regression trees
library(caret)

m4 <- rpart(
  formula = semester~nemgroup+nmjur+nmsla,
  data    = training5,
  method  = "class"
)

rpart.plot(m4)
plotcp(m4)

m5 <- rpart(
  formula = semester~nemgroup+nmjur+nmsla,
  data    = training5,
  method  = "class", 
  control = list(cp = 0, xval = 10)
)

plotcp(m5)
abline(v = 3, lty = "dashed")

m5$cptable

m6 <- rpart(
  formula = semester~nemgroup+nmjur+nmsla,
  data    = training5,
  method  = "class", 
  control = list(minsplit = 10, maxdepth = 3, xval = 10))
m6$cptable

ct_model = m6

pred.ct <- predict(ct_model, newdata = testing5, type="class")
pred.ct

t.rt.s1
t.ct.s1 <- table(as.factor(pred.ct), as.factor(testing5$semester))

confusionMatrix(t.ct.s1)



