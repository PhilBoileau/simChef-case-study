################################################################################
# Augmented Modified Covariates Function
################################################################################

aug_mod_cov_fun <- function(Y, A, W) {

  # define the propensity score function
  propensity_func <- function(x, trt) 0.5

  # define the augmentation function (taken from personalized vignette)
  augment_func <- function(x, y) {
    df.x  <- data.frame(x)
    # add all squared terms to model
    form <- eval(paste(" ~ 1 + ", paste(colnames(df.x), collapse = " + ")))
    mm <- model.matrix(as.formula(form), data = df.x)
    cvmod <- glmnet::cv.glmnet(y = y, x = mm, nfolds = 10)
    predictions <- predict(cvmod, newx = mm, s = "lambda.min")
    predictions
  }

  # apply the method
  aug_mod_cov <- personalized::fit.subgroup(
    x = W,
    y = Y,
    trt = A,
    propensity.func = propensity_func,
    loss = "sq_loss_lasso",
    augment.func = augment_func,
    nfolds = 10
  )

  # extract the estimated coefficients
  coefs <- aug_mod_cov$coefficients[paste0("W", seq_len(100)), ]

  # retain only the covariate names associated with nonzero coefficients
  tems <- names(coefs[which(coefs != 0)])
  tems <- list("tems" = tems)
  return(tems)

}
