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
transformed data {
  vector[N] xT;
  vector[N] yT;
  real xM;
  real yM;
  real mu_bT;
  xM <- mean(x);
  yM <- mean(y);
  xT <- (x - xM);
  yT <- (y - yM);
  mu_bT <- mu_beta + mu_alpha * xM - yM;
}
parameters {
  real a;
  real bT;
  real<lower=0> sigma;
}
transformed parameters {
  real b;
  b <- bT - a * xM + yM;
}
model {
  a ~ normal(mu_alpha, sigma_alpha);
  bT ~ normal(bT, sigma_beta);
  sigma ~ exponential(mu_sigma);

  yT ~ normal(a * xT + bT, sigma);
}
