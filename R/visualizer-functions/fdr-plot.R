################################################################################
# False Discovery Rate Plotting Function
################################################################################

fdr_plot_fun <- function(eval_results) {
  plt <- ggplot2::ggplot(eval_results$`Empirical FDR`) +
    ggplot2::aes(x = n, y = fdr, colour = as.factor(.method_name)) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::facet_grid(cols = ggplot2::vars(.dgp_name)) +
    xlab("Sample Size") +
    ylab("Empirical FDR") +
    ggplot2::scale_colour_viridis_d(name = "Method", option = "E", end = 0.8) +
    ggplot2::theme_bw()

  return(plt)
}
