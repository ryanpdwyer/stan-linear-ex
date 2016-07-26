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
  real xD;
  real yD;
  real mu_bT;
  real mu_aT;
  real sigma_aT;
  xM <- mean(x);
  yM <- mean(y);
  xD <- max(x) - min(x);
  yD <- max(y) - min(y);
  xT <- (x - xM) / xD;
  yT <- (y - yM) / yD;
  mu_bT <- (mu_beta + mu_alpha * xM - yM)/yD;
  mu_aT <- mu_alpha * xD / yD;
  sigma_aT <- sigma_alpha * xD / yD;
}
parameters {
  real aT;
  real bT;
  real<lower=0> sigmaT;
}
transformed parameters {
  real a;
  real b;
  real sigma;
  a <- aT  * yD / xD;
  b <- (bT - a * xM + yM) * yD;
  sigma <- sigmaT * yD;
}
model {
  aT ~ normal(mu_aT, sigma_aT);
  bT ~ normal(mu_bT, mu_beta / yD);
  sigmaT ~ exponential(mu_sigma / yD);

  yT ~ normal(aT * xT + bT, sigmaT);
}