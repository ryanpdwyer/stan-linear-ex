data {
  int<lower=0> N;
  int<lower=0> M;
  vector[N] f;
  vector[N] y;
  real mu_fc;
  real mu_kc;
  real mu_Q;
  real mu_Pdet;
  real sigma_fc;
  real sigma_kc;
  real sigma_Q;
  real sigma_Pdet;
  real scale;
  real<lower=0> T;
}
parameters {
  real dfc;
  real<lower=0> kc;
  real<lower=0> Q;
  real<lower=0> Pdet;
}
model {
    // Priors on fit parameters
    dfc ~ normal(0, sigma_fc);
    kc ~ normal(mu_kc, sigma_kc);
    Q ~ normal(mu_Q, sigma_Q);
    Pdet ~ cauchy(mu_Pdet, sigma_Pdet);
    
    for (i in 1:N) {
        y[i] ~ gamma(M, M / (
            ((2 * 1.381e-5 * T) / (pi() * Q * kc)) / scale * (dfc + mu_fc)^3 /
            ((f[i] * f[i] - (dfc + mu_fc)^2) * (f[i] * f[i] - (dfc + mu_fc)^2) + f[i] * f[i] * (dfc + mu_fc)^2 / Q^2)
            + Pdet)
            );
    }
}