################################################################################
# False Discovery Proportion Function Evaluator
################################################################################

fdp_fun <- function(suspected_tems) {

  # define the set of non TEMs
  non_tems <- paste0("W", seq(from = 51, to = 100))

  # compute the false discovery proportion
  num_false_discoveries <- sum(suspected_tems %in% non_tems)
  num_discoveries <- length(suspected_tems)
  if (num_discoveries == 0)
    fdp <- 0
  else
    fdp <- num_false_discoveries / length(suspected_tems)

  # return the fdp
  return(fdp)
}
