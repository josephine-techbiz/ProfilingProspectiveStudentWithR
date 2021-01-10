library(dplyr)
library(rpart)       # performing regression trees
library(rpart.plot)  # plotting regression trees
library(caret)

### model IPK ####
m0 <- rpart(
  formula = ipk~nemgroup+nmjur+nmsla,
  data    = training4,
  method  = "anova"
)

rpart.plot(m0)
plotcp(m0)

m2 <- rpart(
  formula = ipk~nemgroup+nmjur+nmsla,
  data    = training4,
  method  = "anova", 
  control = list(cp = 0, xval = 10)
)

plotcp(m2)
abline(v = 9, lty = "dashed")

m0$cptable

############# TUNING #################
m3 <- rpart(
  formula = ipk~nemgroup+nmjur+nmsla,
  data    = training4,
  method  = "anova", 
  control = list(minsplit = 10, maxdepth = 9, xval = 10)
)
m3$cptable

hyper_grid <- expand.grid(
  minsplit = seq(3, 14, 1),
  maxdepth = seq(6, 12, 1)
)

head(hyper_grid)

# total number of combinations
nrow(hyper_grid)


models <- list()
for (i in 1:nrow(hyper_grid)) {
  # get minsplit, maxdepth values at row i
  minsplit <- hyper_grid$minsplit[i]
  maxdepth <- hyper_grid$maxdepth[i]
  
  # train a model and store in the list
  models[[i]] <- rpart(
    formula = ipk~nemgroup+nmjur+nmsla,
    data    = training4,
    method  = "anova",
    control = list(minsplit = minsplit, maxdepth = maxdepth))}

# function to get optimal cp
get_cp <- function(x) {
  min    <- which.min(x$cptable[, "xerror"])
  cp <- x$cptable[min, "CP"] }

# function to get minimum error
get_min_error <- function(x) {
  min    <- which.min(x$cptable[, "xerror"])
  xerror <- x$cptable[min, "xerror"] }

hyper_grid %>%
  mutate(
    cp    = purrr::map_dbl(models, get_cp),
    error = purrr::map_dbl(models, get_min_error)
  ) %>%
  arrange(error) %>%
  top_n(-5, wt = error)

optimal_tree <- rpart(
  formula = ipk~nemgroup+nmjur+nmsla,
  data    = training4,
  method  = "anova",
  control = list(minsplit = 9, maxdepth = 10, cp = 0.01)
)

pred.rt <- predict(optimal_tree, newdata = testing4)
RMSE(pred = pred.rt, obs = testing4$ipk)
MAE (pred.rt, testing4$ipk)

# Metrics for Regression Tree
rt <- data.frame(RMSE=rmse(testing4$ipk, pred.rt),
                 MSE=mse(testing4$ipk, pred.rt),
                 MAE=mae(testing4$ipk, pred.rt))
