################################################################################
# uniCATE Function
################################################################################

unicate_fun <- function(Y, A, W) {

  # assemble the data into a tibble
  sample_tbl <- tibble::tibble(Y = Y, A = A)
  sample_tbl <- dplyr::bind_cols(sample_tbl, W)

  # define the covariates and biomarkers names
  biomarker_names <- colnames(W)

  # define the propensity scores for a perfect RCT
  propensity_score_ls <- list("1" = 0.5, "0" = 0.5)

  # wrap uniCATE
  unicate_tbl <- uniCATE::unicate(
    data = sample_tbl,
    outcome = "Y",
    treatment = "A",
    covariates = biomarker_names,
    biomarkers = biomarker_names,
    propensity_score_ls = propensity_score_ls,
    v_folds = 10
  )

  # extract the suspected treatment effect modifiers
  tems <- unicate_tbl %>%
    dplyr::filter(p_value_bh <= 0.05) %>%
    dplyr::pull(biomarker)

  return(tems)

}
