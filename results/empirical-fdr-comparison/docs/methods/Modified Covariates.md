uniCATE's capacity to identify predictive biomarkers was compared to that of
popular CATE estimation methods: the modified covariates approach and its
augmented counterpart of [Tian et al.
(2012)](https://www.tandfonline.com/doi/abs/10.1080/01621459.2014.951443).
Briefly, the former directly estimates the linear model coefficients of the
treatment-biomarker interactions, using a linear working model for these terms,
without having to model or estimate the main effects. While Tian et al.'s
method is flexible since it avoids making any assumptions about the functional
form of the main biomarker effects, it can lack finite sample precision in
small-sample, high-dimensional settings. When using a penalized method like the
LASSO, biomarkers are designated as predictive when their estimated
coefficients are non-zero.
