# ============================
# evaluate predictions
# ============================

evaluate_predictions <- function(
    y_true,
    p_hat,
    threshold,
    model_name,
    method_name,
    cost_fp = 1,
    cost_fn = 10){
  
  
  y_pred <- ifelse(
    p_hat > threshold,
    1,
    0
  )
  
  
  TP <- sum(y_pred == 1 & y_true == 1)
  TN <- sum(y_pred == 0 & y_true == 0)
  FP <- sum(y_pred == 1 & y_true == 0)
  FN <- sum(y_pred == 0 & y_true == 1)
  
  
  tibble(
    Modello = model_name,
    Metodo = method_name,
    Soglia = round(threshold,4),
    
    Accuracy =
      round((TP+TN)/length(y_true),4),
    
    Sensitivity =
      round(TP/(TP+FN),4),
    
    Specificity =
      round(TN/(TN+FP),4),
    
    Precision =
      round(TP/(TP+FP),4),
    
    Costo_Totale =
      cost_fp*FP + cost_fn*FN
  )
}


# ============================
# K-S Statistic
# ============================

calc_ks_stat <- function(y_true, p_hat) {
  
  p_good <- p_hat[y_true == 0]
  p_bad  <- p_hat[y_true == 1]
  
  thresholds <- sort(unique(p_hat))
  
  cdf_good <- ecdf(p_good)(thresholds)
  cdf_bad  <- ecdf(p_bad)(thresholds)
  
  ks_val <- max(abs(cdf_good - cdf_bad)) * 100
  
  return(ks_val)
}


# ============================
# Complete evaluation
# ============================

evaluate_classifier <- function(y_true, p_hat) {
  
  # AUROC
  roc_obj <- pROC::roc(
    y_true, 
    p_hat, 
    quiet = TRUE
  )
  
  auroc <- as.numeric(pROC::auc(roc_obj)) * 100
  
  
  # PR-AUC
  df_pr <- tibble(
    truth = factor(y_true, levels = c(1, 0)),
    estimate = p_hat
  )
  
  pr_auc <- yardstick::pr_auc(
    df_pr,
    truth,
    estimate
  )$.estimate * 100
  
  
  # KS
  ks <- calc_ks_stat(
    y_true,
    p_hat
  )
  
  
  return(
    tibble(
      AUROC = auroc,
      PR_AUC = pr_auc,
      KS = ks
    )
  )
}