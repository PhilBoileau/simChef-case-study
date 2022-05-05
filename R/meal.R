################################################################################
# Simulation Script
################################################################################

# load required libraries
library(here)
library(dplyr)
library(tibble)
library(MASS)
library(uniCATE)
library(ggplot2)
library(simChef)

# define the data-generating process objects
source(here("R/dgps-functions/lm-with-tem.R"))
linear_dgp <- create_dgp(
  .dgp_fun = lm_tem_fun,
  .name = "LM with TEM",
  n = 125
)

# define the method objects
source(here("R/method-functions/uniCATE.R"))
unicate_method <- create_method(.method_fun = unicate_fun)

# define the FDR evaluator objects
source(here("R/evaluator-functions/fdr.R"))
fdr_eval <- create_evaluator(.eval_fun = fdr_fun)

# define the visualizer objects
source(here("R/visualizer-functions/fdr-plot.R"))
fdr_plot <- create_visualizer(.viz_fun = fdr_plot_fun)

# assemble the experiment
experiment <- create_experiment(name = "empirical-fdr-comparison") %>%
  add_dgp(linear_dgp, name = "LM with TEM") %>%
  add_method(unicate_method, name = "uniCATE") %>%
  add_evaluator(fdr_eval, name = "Empirical FDR") %>%
  add_visualizer(fdr_plot, name = "Empirical FDR Plot")

# run the experiment
results <- experiment$run(n_reps = 10, save = TRUE)

