"Kinked with TEM" stands for "Kinked Model with Treatment Effect Modification".
Its generative model is as follows:
\begin{equation}
  \begin{split}
    W = B & \sim N(0, I_{100 \times 100}) \\
    A | W = A & \sim \text{Bernoulli}(1/2) \\
    Y | A, W & \sim N\left(
        W^\top \left(I(A = 1)\gamma + I(A = 0)\;\text{diag}(I(W >
              0))\;\gamma\right), 1/2
        \right),
  \end{split}
\end{equation}
where $\gamma = (\gamma_1, \ldots, \gamma_{100})$, $\gamma_{1} = \ldots
= \gamma_{50} = 10$, $\gamma_{51} = \ldots = \gamma_{100} = 0$, and
$\text{diag}(\cdot)$ is a diagonal matrix whose diagonal equals the
input vector.

As with the LM with TEM mode, 200 datasets of 125, 250 and 500
observations are generated.
