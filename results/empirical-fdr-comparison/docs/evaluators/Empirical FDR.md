The empirical false discovery rate (FDR) for each method is computed as the
mean of the false discovery proportions (FDP) stratified over each
data-generating process and sample size. For any given simulated dataset, the
FDP is computed as follows:
\begin{equation}
  \text{FDP} = \frac{\text{# of biomarkers erroneously classified as predictive}}
  {\text{# of biomarkers classified as predictive}}.
\end{equation}
When no biomarkers are classified as predictive, $\text{FDP} = 0$.
