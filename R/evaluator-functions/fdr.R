################################################################################
# False Discovery Proportion Function Evaluator
################################################################################

fdp_fun <- function(tems) {

  # define the set of non TEMs
  non_tems <- paste0("W", seq(from = 51, to = 100))

  # compute the
  num_false_discoveries <- sum(tems %in% non_tems)
  num_discoveries <- length(tems)
  if (num_discoveries == 0)
    fdp <- 0
  else
    fdp <- num_false_discoveries / num_discoveries

  return(fdp)

}

fdr_fun <- function(fit_results) {

  # compute the false discovery proportion
  group_vars <- c(".dgp_name", ".method_name", ".n")
  eval_out <- fit_results %>%
    mutate(fdp = purrr::map(tems, fdp_fun)) %>%
    dplyr::group_by(dplyr::across({{group_vars}})) %>%
    summarize(
      fdr = mean(fdp)
    )

  return(eval_out)
}
