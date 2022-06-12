We propose a cross-validated estimator that uses all available data. Begin by randomly partitioning the $n$ observations of $P_n$ into $K$ independent validation sets $P_{n, 1}^1, \ldots, P_{n, K}^1$ of approximately equal size. For $k=1,\ldots, K$, define the training set as, in a slight abuse of notation, $P_{n, k}^0 = P_n \setminus P_{n,k}^1$. Then the cross-validated estimator of $\Psi_j(P_0)$ is defined as:

\begin{equation}
  \Psi_j^{(\text{CV})}(P_n) = \frac{1}{K} \sum_{k=1}^K
  \frac{\sum_{i=1}^n I(O_i \in P_{n, k}^1)\tilde{T}(O_i; P_{n,k}^0)B_{ij}}
  {\sum_{i=1}^n I(O_i \in P_{n, k}^1) B_{ij}^2}.
\end{equation}
