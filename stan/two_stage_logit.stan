data {
  int<lower=1> N;
  vector[N] eta1;
  vector[N] eta2;
  vector[N] eta3;
  array[N] int<lower=0, upper=1> y;
}

parameters {
  real alpha;
  vector<lower=0>[3] w;  // Pesi positivi 
}

transformed parameters {
  vector[N] mu = alpha + w[1] * eta1 + w[2] * eta2 + w[3] * eta3;
}

model {
  // Priors
  alpha ~ normal(0, 5);
  w ~ normal(1, 1);
  
  // Likelihood
  y ~ bernoulli_logit(mu);
}