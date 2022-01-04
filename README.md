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

Newton's method works well for estimating square roots of numbers. We just have to reformulate the square root as
quadratic equation:

    x = sqrt(N)
    x² - N = 0

Now we can apply the Newtons method quite easily

    f(x) = x² - N
    f'(x) = 2x

    x_[n+1] = x_n - f(x_n) / f'(x_n)
    x_[n+1] = x_n - ((x_n)² - N) / (2 x_n)

As the first guess we can use the number itself. Implementation in Haskell is really straight-forward:

    nsqrt :: Double -> Int -> Double
    nsqrt n depth
        | n < 0      = error "Can not take square root from negative number"
        | n == 0     = 0
        | depth <= 0 = n
        | otherwise  = x - (x**2 - n) / (2 * x)
        where x = nsqrt n (depth - 1)

Let's compare compared with the "official" sqrt:

    *Main> nsqrt 2 5
    1.4142135623730951
    *Main> sqrt 2
    1.4142135623730951

It is almost incredible how just few iterations make so accurate result!

## General solver

The biggest challenge for a general root solving code is the need for derivate of the function. If we would like to
give the function as a lambda, we clearly can not do symbolical differentiation. However, it turns out that we will get rather
good results when using numerical derivation; since the real derivate is the limit of

    (f(x + h) - f(x)) / h

when *h* approaches zero, we can approximate this with some small *h*.  Without further ado, the Haskell root solver:

    root :: (Double -> Double) -> Double -> Int -> Double -> Double
    root f x0 depth h
        | depth <= 0 = x0
        | otherwise  = root f x (depth - 1) h
        where x = x0 - f(x0) / ((f(x0 + h) - f(x0)) / h)

And it appears that we can get as good results with this for square root solving as we did with the *nsqrt*, only
requiring few more iterations:

    *Main> sqrt 2
    1.4142135623730951
    *Main> root (\x->x**2 - 2) 2 8 0.01
    1.4142135623730951

And just to show that it is really able to work with even more complex cases:

    *Main> root (\x->x**5 - 66*x**3 + 5*x**2 + 2*x + 1337) 2 8 0.01
    2.884545361600618

Wolfram Alpha [2] verifies that the closest root to our initial guess (2) is approximately 2.88455. Almost magical!

## References

[1] https://en.wikipedia.org/wiki/Newton%27s_method

[2] https://www.wolframalpha.com/input/?i=x**5+-+66*x**3+%2B+5*x**2+%2B+2*x+%2B+1337

