################################################################################
# False Discovery Rate Plotting Function
################################################################################

summary_plot_fun <- function(eval_results) {

  # combine the evaluator results into a single tibble
  emp_fdr_tbl <- eval_results$`Empirical FDR` %>%
    dplyr::mutate(
      metric = "FDR",
      value = fdr,
      yintercept = 0.05
    ) %>%
    dplyr::select(-fdr)
  emp_tpr_tbl <- eval_results$`Empirical TPR` %>%
    dplyr::mutate(
      metric = "TPR",
      value = tpr,
      yintercept = NA
    ) %>%
    dplyr::select(-tpr)
  emp_tnr_tbl <- eval_results$`Empirical TNR` %>%
    dplyr::mutate(
      metric = "TNR",
      value = tnr,
      yintercept = NA
    ) %>%
    dplyr::select(-tnr)
  comb_tbl <- bind_rows(emp_fdr_tbl, emp_tpr_tbl, emp_tnr_tbl)

  plt <- ggplot2::ggplot(comb_tbl) +
    ggplot2::aes(x = n, y = value, colour = as.factor(.method_name)) +
    ggplot2::geom_point(alpha = 0.7) +
    ggplot2::geom_line(alpha = 0.7) +
    ggplot2::geom_hline(aes(yintercept = yintercept), colour = "red",
                        linetype = 2, alpha = 0.5) +
    ggplot2::facet_grid(cols = ggplot2::vars(.dgp_name),
                        rows = ggplot2::vars(metric)) +
    ggplot2::xlab("Sample Size") +
    ggplot2::ylab("Value") +
    ggplot2::scale_colour_viridis_d(name = "Method", option = "E", end = 0.8) +
    ggplot2::theme_bw()

  return(plt)
}
