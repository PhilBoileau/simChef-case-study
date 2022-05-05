################################################################################
# uniCATE Function
################################################################################

unicate_fun <- function(Y, A, W, use_sl = FALSE) {

  # assemble the data into a tibble
  sample_tbl <- tibble::tibble(Y = Y, A = A)
  sample_tbl <- dplyr::bind_cols(sample_tbl, W)

  # define the covariates and biomarkers names
  biomarker_names <- colnames(W)

  # define the propensity scores for a perfect RCT
  propensity_score_ls <- list("1" = 0.5, "0" = 0.5)

  # set up the super learner, if necessary
  if (use_sl) {

    # define the interactions
    interactions <- lapply(biomarker_names, function(b) c(b, "A"))
    lrnr_interactions <- sl3::Lrnr_define_interactions$new(interactions)

    # define the base learners
    lrnr_lasso <- sl3::make_learner(
      sl3::Pipeline, lrnr_interactions, sl3::Lrnr_glmnet$new(alpha = 1)
    )
    lrnr_enet <- sl3::make_learner(
      sl3::Pipeline, lrnr_interactions, sl3::Lrnr_glmnet$new(alpha = 0,5)
    )
    lrnr_ridge <- sl3::make_learner(
      sl3::Pipeline, lrnr_interactions, sl3::Lrnr_glmnet$new(alpha = 0)
    )
    lrnr_ranger <- sl3::make_learner(
      sl3::Pipeline, lrnr_interactions, sl3::Lrnr_ranger$new()
    )

    # assemble the super learner
    super_learner <- sl3::Lrnr_sl$new(
      learners = sl3::make_learner(
        sl3::Stack, lrnr_lasso, lrnr_enet, lrnr_ridge, lrnr_ranger,
        sl3::Lrnr_mean$new()
      ),
      metalearner = sl3::make_learner(sl3::Lrnr_nnls)
    )

  } else {
    super_learner <- NULL
  }

  # wrap uniCATE
  unicate_tbl <- uniCATE::unicate(
    data = sample_tbl,
    outcome = "Y",
    treatment = "A",
    covariates = biomarker_names,
    biomarkers = biomarker_names,
    propensity_score_ls = propensity_score_ls,
    v_folds = 5,
    super_learner = super_learner
  )

  # extract the suspected treatment effect modifiers
  tems <- unicate_tbl %>%
    dplyr::filter(p_value_bh <= 0.05) %>%
    dplyr::pull(biomarker)

  # return the list of TEMs
  tems <- list("tems" = tems)
  return(tems)

}
