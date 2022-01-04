nsqrt :: Double -> Int -> Double
nsqrt n depth
    | n < 0      = error "Can not take square root from negative number"
    | n == 0     = 0
    | depth <= 0 = n
    | otherwise  = x - (x**2 - n) / (2 * x)
    where x = nsqrt n (depth - 1)

root :: (Double -> Double) -> Double -> Int -> Double -> Double
root f x0 depth h
    | depth <= 0 = x0
    | otherwise  = root f x (depth - 1) h
    where x = x0 - f(x0) / ((f(x0 + h) - f(x0)) / h)
