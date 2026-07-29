youden_threshold <- function(roc_obj){
  
  coords(
    roc_obj,
    "best",
    ret = "threshold"
  )[[1]]
}



cost_sensitive_threshold <- function(
    roc_obj,
    y_train,
    cost_fp = 1,
    cost_fn = 10){
  
  coord_all <- coords(
    roc_obj,
    "all",
    ret = c(
      "threshold",
      "sensitivity",
      "specificity"
    )
  )
  
  N_0 <- sum(y_train == 0)
  N_1 <- sum(y_train == 1)
  
  fpr <- 1 - coord_all$specificity
  fnr <- 1 - coord_all$sensitivity
  
  total_cost <- 
    (cost_fp * fpr * N_0) +
    (cost_fn * fnr * N_1)
  
  coord_all$threshold[
    which.min(total_cost)
  ]
}