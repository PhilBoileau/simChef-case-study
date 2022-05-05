################################################################################
# True Positive Rate Function Evaluator
################################################################################

tpp_fun <- function(tems) {

  # define the set of TEMs
  true_tems <- paste0("W", seq(from = 1, to = 50))

  # compute the tpp
  tpp <- sum(tems %in% true_tems) / length(true_tems)

  return(tpp)

}

tpr_fun <- function(fit_results) {

  # compute the false discovery proportion
  group_vars <- c(".dgp_name", ".method_name", "n")
  eval_out <- fit_results %>%
    mutate(tpp = purrr::map_dbl(tems, tpp_fun)) %>%
    dplyr::group_by(dplyr::across({{group_vars}})) %>%
    summarize(
      tpr = mean(tpp),
      .groups = "drop"
    )

  return(eval_out)
}
