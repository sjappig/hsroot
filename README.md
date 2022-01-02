# Newton's method with Haskell

Newton's method is a root-finding algorithm which produces successively better approximations to the roots (or zeroes)
of a real-valued function [1]. The idea is to take a previous estimate of the root, and produce a better estimate from
it by taking the root of the function's tangent line. One way to look at this is process is that instead of trying to
solve the root directly, we are approximating the function where previous root estimate is with linear function, and
solving the root for that. Original estimate which sets this whole process in motion is basically a guess.

The equations can be derived from the linear approximation

    ax_[n+1] + b = 0

where

    a = f'(x_n)
    b = f(x_n) - f'(x_n) * x_n

Solving this for *x_n+1* yields

    x_[n+1] = x_n - f(x_n) / f'(x_n)

## Estimating square root

Newton's method works well for estimating square roots of numbers:
## References

[1] https://en.wikipedia.org/wiki/Newton%27s_method

