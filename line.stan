data {
  int<lower=1> N;
  vector[N] x;
  vector[N] y;
  real mu_alpha;
  real sigma_alpha;
  real mu_beta;
  real sigma_beta;
  real mu_sigma;
}
parameters {
  real a;
  real b;
  real<lower=0> sigma;
}
model {
  a ~ normal(mu_alpha, sigma_alpha);
  b ~ normal(mu_beta, sigma_beta);
  sigma ~ exponential(mu_sigma);

  y ~ normal(a * x + b, sigma);
}