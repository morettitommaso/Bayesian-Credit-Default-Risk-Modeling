data {
  int<lower=1> N;                       // Numero di osservazioni
  int<lower=1> K;                       // Numero di covariate
  matrix[N, K] X;                       // Matrice di covariate
  array[N] int<lower=0, upper=1> y;     // Target binario (0 = No Default, 1 = Default)
}

parameters {
  real alpha;                           // Intercetta
  vector[K] beta;                       // Vettore dei coefficienti di regressione
}

model {

  // 1. Weakly Informative Priors
  alpha ~ normal(0, 5); 
  beta ~ normal(0, 2.5); 
  
  // 2. Likelihood Vettorizzata
  y ~ bernoulli_logit_glm(X, alpha, beta);

}

generated quantities {
  // Calcolo delle probabilità posteriori out-of-sample per ROC / PR-AUC e Cost-Sensitivity
  vector[N] log_lik;
  vector[N] y_hat;
  
  for (n in 1:N) {
    log_lik[n] = bernoulli_logit_lpmf(y[n] | alpha + dot_product(X[n], beta));
    y_hat[n] = inv_logit(alpha + dot_product(X[n], beta));
  }
}