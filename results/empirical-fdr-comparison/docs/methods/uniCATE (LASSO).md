We propose a cross-validated estimator that uses all available data. Begin by
randomly partitioning the $n$ observations of $P_n$ into $K$ independent
validation sets $P_{n, 1}^1, \ldots, P_{n, K}^1$ of approximately equal size.
For $k=1,\ldots, K$, define the training set as, in a slight abuse of notation,
$P_{n, k}^0 = P_n \setminus P_{n,k}^1$. Then the cross-validated estimator of
$\Psi_j(P_0)$ is defined as:

\begin{equation}
  \Psi_j^{(\text{CV})}(P_n) = \frac{1}{K} \sum_{k=1}^K
  \frac{\sum_{i=1}^n I(O_i \in P_{n, k}^1)\tilde{T}(O_i; P_{n,k}^0)B_{ij}}
  {\sum_{i=1}^n I(O_i \in P_{n, k}^1) B_{ij}^2},
\end{equation}
where $\tilde{T}(O;P)$ is the difference in augmented inverse probability
weight transformed outcomes. That is,
\begin{equation}
    \tilde{T}(O; P) = \left(\frac{I(A=1)}{g(1, W)} -
    \frac{I(A=0)}{g(0,W)}\right)
    (Y - \bar{Q}(A, W)) + \bar{Q}(1, W) - \bar{Q}(0,W),
\end{equation}
where $g(a,W) = \mathbb{P}_{P}[A=a|W]$. Here, $P$ is omitted from the subscript
of $g(a,W),\bar{Q}(A,W)$ to simplify notation.

This cross-validated estimator estimates $\bar{Q}_0(A,W)$ on the training set
using a LASSO regression that includes main and treatment-biomarker interaction
terms. The simple linear regression coefficient of the $j\text{th}$ biomarker
regressed on the difference in potential outcomes is then computed on the
validation set using the estimate of $\bar{Q}_0(A,W)$. This procedure is
repeated $K$ times, and the estimate is defined as the mean of the estimated
slopes for each validation set.

In a randomized control trial with known treatment assignment mechanism, this
estimator is asymptotically normal about the true parameter with variance given
by its efficient influence curve. Hypothesis testing is therefore possible
through the use of Wald-type confidence intervals. We define the null
hypothesis as $\Psi(P_0)=0$, and use an FDR cutoff of 5\% throughout the
simulation study. For more information, see [(P. Boileau, et al.
2022)](https://arxiv.org/abs/2205.01285).
