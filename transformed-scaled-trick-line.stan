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
  xM <- mean(x);
  yM <- mean(y);
  xD <- max(x) - min(x);
  yD <- max(y) - min(y);
  xT <- (x - xM) / xD;
  yT <- (y - yM) / yD;
}
parameters {
  real a;
  real b;
  real<lower=0> sigma;
}
transformed parameters {
  real aT;
  real bT;
  real sigmaT;
  aT <- a  * xD / yD;
  bT <- (b + yM) / yD;
  sigmaT <- sigma / yD;
}
model {
  a ~ normal(mu_alpha, sigma_alpha);
  b ~ normal(mu_alpha, sigma_alpha);
  sigma ~ exponential(mu_sigma);

  yT ~ normal(aT * xT + bT, sigmaT);
}