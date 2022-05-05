################################################################################
# Modified Covariates Function
################################################################################

mod_cov_fun <- function(Y, A, W) {

  # define the propensity score function
  propensity_func <- function(x, trt) 0.5

  # apply the method
  mod_cov <- fit.subgroup(
    x = W,
    y = Y,
    trt = A,
    propensity.func = propensity_func,
    loss = "sq_loss_lasso",
    nfolds = 10
  )

  # extract the estimated coefficients
  coefs <- mod_cov$coefficients[paste0("W", seq_len(100)), ]

  # retain only the covariate names associated with nonzero coefficients
  tems <- names(coefs[which(coefs != 0)])
  tems <- list("tems" = tems)
  return(tems)

}
