################################################################################
# Simulation Script
################################################################################

# load required libraries
library(here)
library(dplyr)
library(tibble)
library(MASS)
library(sl3)
library(ranger)
library(glmnet)
library(xgboost)
library(polspline)
library(uniCATE)
library(personalized)
library(ggplot2)
library(simChef)
library(future)

# set up parallelization
plan(multisession, workers = 20L)

# define the data-generating process objects
source(here("R/dgps-functions/lm-with-tem.R"))
source(here("R/dgps-functions/kinked-with-tem.R"))
source(here("R/dgps-functions/nlm-with-tem.R"))
linear_dgp <- create_dgp(.dgp_fun = lm_tem_fun)
kinked_dgp <- create_dgp(.dgp_fun = kinked_tem_fun)
nonlinear_dgp <- create_dgp(.dgp_fun = nlm_tem_fun)

# define the method objects
source(here("R/method-functions/uniCATE.R"))
source(here("R/method-functions/modified-covariates.R"))
source(here("R/method-functions/augmented-modified-covariates.R"))
unicate_lasso_method <- create_method(.method_fun = unicate_fun, use_sl = FALSE)
unicate_sl_method <- create_method(.method_fun = unicate_fun, use_sl = TRUE)
mod_cov_method <- create_method(.method_fun = mod_cov_fun)
aug_mod_cov_method <- create_method(.method_fun = aug_mod_cov_fun)

# define the FDR evaluator objects
source(here("R/evaluator-functions/fdr.R"))
source(here("R/evaluator-functions/tpr.R"))
source(here("R/evaluator-functions/tnr.R"))
fdr_eval <- create_evaluator(.eval_fun = fdr_fun)
tpr_eval <- create_evaluator(.eval_fun = tpr_fun)
tnr_eval <- create_evaluator(.eval_fun = tnr_fun)

# define the visualizer objects
source(here("R/visualizer-functions/classification-summary-plot.R"))
summary_plot <- create_visualizer(.viz_fun = summary_plot_fun)

# meal prep
experiment <- create_experiment(name = "empirical-fdr-comparison") %>%
  add_dgp(linear_dgp, name = "LM with TEM") %>%
  add_dgp(kinked_dgp, name = "Kinked with TEM") %>%
  add_dgp(nonlinear_dgp, name = "NLM with TEM") %>%
  # is there a way to vary across all DGPs at the same time
  add_vary_across(.dgp = "LM with TEM", n = c(125, 250, 500)) %>%
  add_vary_across(.dgp = "Kinked with TEM", n = c(125, 250, 500)) %>%
  add_vary_across(.dgp = "NLM with TEM", n = c(125, 250, 500)) %>%
  add_method(unicate_lasso_method, name = "uniCATE (LASSO)") %>%
  add_method(unicate_sl_method, name = "uniCATE (SL)") %>%
  add_method(mod_cov_method, name = "Modified Covariates") %>%
  add_method(aug_mod_cov_method, name = "Augmented Modified Covariates") %>%
  add_evaluator(fdr_eval, name = "Empirical FDR") %>%
  add_evaluator(tpr_eval, name = "Empirical TPR") %>%
  add_evaluator(tnr_eval, name = "Empirical TNR") %>%
  add_visualizer(summary_plot, name = "Summary Plot")

# put it in the oven
set.seed(510)
results <- experiment$run(n_reps = 200, save = TRUE)

