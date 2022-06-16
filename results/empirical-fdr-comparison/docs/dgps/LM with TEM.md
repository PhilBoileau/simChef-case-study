"LM with TEM" Stands for "Linear Model with Treatment Effect Modification".
Its generative model is as follows:
\begin{equation}
  \begin{split}
    W = B & \sim N(0, I_{100 \times 100}) \\
    A | W = A & \sim \text{Bernoulli}(1/2) \\
    Y | A, W & \sim N\left(W^\top
      \left(\beta + I(A = 1)\gamma^{(1)} + I(A = 0)\gamma^{(0)}\right),
      1/2\right).
  \end{split}
\end{equation}
Here, $\beta = (\beta_1, \ldots, \beta_{100})^\top$ such that $\beta_1 = \ldots
= \beta_{20} = 2$ and $\beta_{21} = \ldots = \beta_{100} = 0$, and
$\gamma^{(a)} = (\gamma_1^{(a)}, \ldots, \gamma_{100}^{(a)})^\top$ where
$\gamma_1^{(1)} = \ldots = \gamma_{50}^{(1)} = 5$, $\gamma_1^{(0)} = \ldots =
\gamma_{50}^{(0)} = 5$ and $\gamma_{51}^{(1)} = \ldots = \gamma_{100}^{(1)} =
0$ for $a = \{0, 1\}$.
