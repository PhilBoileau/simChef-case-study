# `simChef` Case Study

This repository uses the [`simChef`](https://yu-group.github.io/simChef/)
simulation framework to reproduce a portion of the simulation results presented
in "[A flexible approach for predictive biomarker
discovery](https://arxiv.org/abs/2205.01285)" by Boileau et al. The method
presented in this preprint is implemented in the publicly available
[`uniCATE`](https://insightsengineering.github.io/uniCATE/) `R` package and the
original simulation results are available in the repository
[`pub_uniCATE`](https://github.com/PhilBoileau/pub_uniCATE).

The simulation documentation and results generated by `simChef` are found
[here](https://PhilBoileau.yu-group.github.io/simChef-case-study/results/empirical-fdr-comparison/empirical-fdr-comparison.html).

## Navigating the Repository

The list below summarizes this repository's contents:

+ `R/`: The directory containing all of the `R` code. The data-generating
  processes are in `dgps-functions/`, the methods in `method-functions/`,
  `simChef` evaluator functions in `evaluator-functions/`, and the
  visualization functionality in `visualizer-functons/`. The main `simChef`
  file is `meal.R`; the simulation study code is found here.
+ `results/`: The results produced by running `R/meal.R` are saved here.
+ `slurm/`: This directory contains a bash script for running `R/meal.R` using
  SLURM scheduler 
+ `logs/`: The log file generated by the SLURM scheduler is saved in this
  directory.
+ `renv/`: This directory is automatically generated by the
  [`renv`](https://rstudio.github.io/renv/index.html) `R` package. Do not
  modify its contents manually.

## Reproducing the Simulation Study

You can reproduce the partial simulation study locally by running the contents
of the `R/meal.R` file. Be sure to install the
[`renv`](https://rstudio.github.io/renv/index.html) package first to ensure
that all required libraries are installed. `R/meal.R` can also be run on an
high-performance computing environment. Checkout the
`slurm/savio-run-experiment.sh` example SLURM script. You might also want to
modify the [`future`](https://cran.r-project.org/package=future) plan based on
the computational resources at your disposal.  

## Citing `simChef` and `uniCATE`

If you use the `simChef` package for your own simulation study, please cite it
with the following BibTeX entry:
```
@manual{simChef,
  title = {simChef: Intensive Computational Experiments Made Easy},
  author = {James Duncan and Tiffany Tang},
  year = {2022},
  note = {R package version 0.0.2},
  url = {https://yu-group.github.io/simChef},
}
```

`uniCATE` can be cited using the following entry:
```
@misc{boileau-2022,
  doi = {10.48550/ARXIV.2205.01285},
  url = {https://arxiv.org/abs/2205.01285},
  author = {Boileau, Philippe and Qi, Nina Ting and van der Laan, Mark J. and Dudoit, Sandrine and Leng, Ning},
  keywords = {Methodology (stat.ME), FOS: Computer and information sciences, FOS: Computer and information sciences},
  title = {A Flexible Approach for Predictive Biomarker Discovery},
  publisher = {arXiv},
  year = {2022}
}
```

---

&copy; 2022 [Philippe Boileau](https://pboileau.ca)

The contents of this repository are distributed under the MIT license. See file
`LICENSE` for details.
