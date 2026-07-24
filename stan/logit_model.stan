data {
  int<lower=1> N;                       // Numero di osservazioni (es. 120.000)
  int<lower=1> K;                       // Numero di covariate (es. 13)
  matrix[N, K] X;                       // Matrice delle covariate standardizzate
  array[N] int<lower=0, upper=1> y;     // Target binario
}

parameters {
  real alpha;                           // Intercetta
  vector[K] beta;                       // Coefficienti di regressione
}

model {
  // Weakly Informative Priors (Gelman et al.)
  alpha ~ normal(0, 5); 
  beta ~ normal(0, 2.5); 
  
  // Likelihood GLM vettorizzata (veloce ed efficiente)
  y ~ bernoulli_logit_glm(X, alpha, beta);
}