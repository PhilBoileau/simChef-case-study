################################################################################
# Kinked Model with Treatment Effect Modification
################################################################################

# Input:
#   n, an integer representing the number of observations to simulate
#   cov_mat, a 100x100 covariance matrix of the covariates
# Output:
#   A list object containing 100 covariates, a binary treatment indicator,
#   and the potential outcomes of n independently simulated observations in a
#   perfect RCT.
kinked_tem_fun <- function(n = 125, cov_mat = diag(1, nrow = 100)) {

  # define the coefficients vector for controls and treatment interactions
  beta_tem <- c(rep(2, 50), rep(0, 50))

  # generate the biomarkers
  W <- MASS::mvrnorm(n = n, mu = rep(0, 100), Sigma = cov_mat)
  colnames(W) <- paste0("W", seq_len(100))

  # simulate the binary treatment assignment
  A <- ifelse(runif(n) < 0.5, 0, 1)

  # simulate the outcomes under treatment
  epsilon_1 <- rnorm(n = n, mean = 0, sd = 0.5)
  W_t <- t(W)
  Y_1 <- as.vector(crossprod(W_t, beta_tem) + epsilon_1)

  # simulate the outcomes under control
  epsilon_0 <- rnorm(n = n, mean = 0, sd = 0.5)
  W_mod <- W[, 1:50]
  W_mod[W_mod < 0] <- 0
  W_mod_t <- t(cbind(W_mod, W[, 51:100]))
  Y_0 <- as.vector(crossprod(W_mod_t, beta_tem) + epsilon_0)

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
