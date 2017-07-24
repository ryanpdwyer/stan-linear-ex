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
    // Gamma distribution: alpha = mu^2 / sigma^2
    //                      beta = mu / sigma^2
    dfc ~ normal(0, sigma_fc);
    kc ~ gamma(mu_kc^2/sigma_kc^2, mu_kc / sigma_kc^2);
    Q ~ gamma(mu_Q^2/sigma_Q^2, mu_Q / sigma_Q^2);
    Pdet ~ gamma(mu_Pdet^2/sigma_Pdet^2, mu_Pdet/sigma_Pdet^2);
    
    for (i in 1:N) {
        y[i] ~ gamma(M, M / (
            ((2 * 1.381e-5 * T) / (pi() * Q * kc)) / scale * (dfc + mu_fc)^3 /
            ((f[i] * f[i] - (dfc + mu_fc)^2) * (f[i] * f[i] - (dfc + mu_fc)^2) + f[i] * f[i] * (dfc + mu_fc)^2 / Q^2)
            + Pdet)
            );
    }
}