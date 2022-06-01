################################################################################
# Linear Model with Treatment Effect Modification
################################################################################

# Input:
#   n, an integer representing the number of observations to simulate
#   cov_mat, a 100x100 covariance matrix of the covariates
# Output:
#   A list object containing 100 covariates, a binary treatment indicator,
#   and the potential outcomes of n independently simulated observations in a
#   perfect RCT.
lm_tem_fun <- function(n = 125, cov_mat = diag(1, nrow = 100)) {


  # define the sparse coefficients vector for the main effects, and controls and
  # treatment interactions
  beta_main <- c(rep(1, 20), rep(0, 80))
  beta_0 <- rep(0, 100)
  beta_1 <- c(rep(1, 50), rep(0, 50))

  # generate the biomarkers
  W <- MASS::mvrnorm(n = n, mu = rep(0, 100), Sigma = cov_mat)
  colnames(W) <- paste0("W", seq_len(100))

  # simulate the binary treatment assignment
  A <- ifelse(runif(n) < 0.5, 0, 1)

  # simulate the outcomes under treatment and controls
  epsilon_0 <- rnorm(n = n, mean = 0, sd = 0.5)
  epsilon_1 <- rnorm(n = n, mean = 0, sd = 0.5)
  W_t <- t(W)
  main_effects <- crossprod(W_t, beta_main)
  Y_0 <- as.vector(main_effects + crossprod(W_t, beta_0) + epsilon_0)
  Y_1 <- as.vector(main_effects + crossprod(W_t, beta_1) + epsilon_1)

  # define the observed outcome
  Y <- ifelse(A == 0, Y_0, Y_1)

  # assembled into a tibble
  sample_list <- list(
    "Y" = Y,
    "A" = A,
    "W" = W
  )

  return(sample_list)
}
