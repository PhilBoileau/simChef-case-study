################################################################################
# True Negative Rate Function Evaluator
################################################################################

tnp_fun <- function(tems) {

  # define the set of TEMs
  true_nontems <- paste0("W", seq(from = 51, to = 100))

  # compute the tpp
  tnp <- 1 - (sum(tems %in% true_nontems) / length(true_nontems))

  return(tnp)

}

tnr_fun <- function(fit_results) {

  # compute the false discovery proportion
  group_vars <- c(".dgp_name", ".method_name", "n")
  eval_out <- fit_results %>%
    mutate(tnp = purrr::map_dbl(tems, tnp_fun)) %>%
    dplyr::group_by(dplyr::across({{group_vars}})) %>%
    summarize(
      tnr = mean(tnp),
      .groups = "drop"
    )

  return(eval_out)
}
