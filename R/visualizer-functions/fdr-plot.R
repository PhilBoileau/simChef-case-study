################################################################################
# False Discovery Rate Plotting Function
################################################################################

fdr_plot_fun <- function(eval_results) {
  plt <- ggplot2::ggplot(eval_results) +
    ggplot2::aes(x = .data[[".n"]], y = .data[["fdr"]],
                 color = as.factor(.method_name)) +
    ggplot2::geom_bar(stat = "identity", position = ggplot2::position_dodge()) +
    ggplot2::facet_grid(cols = ggplot2::vars(.dgp_name)) +
    xlab("Sample Size") +
    ylab("Mean of 200 Replicates") +
    ggplot2::scale_fill_viridis_d(name = "Method", option = "E", end = 0.8) +
    ggplot2::theme_bw()

  return(plt)
}
