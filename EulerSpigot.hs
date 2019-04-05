-- Author: Zachary Ratliff
-- Email: ratliffzachary@yahoo.com

-- This program generates the digits of Euler's constant one by one, only using integer multiplication.
-- That is, no floating point arithmatic is used. 

-- The method is based off the paper by Sale[1] and is better known as a spigot method. Calculating the digits of e 
-- can be accomplished by representing the transcendental number in mixed radix notation i.e. each digit in the fractional 
-- part of e has it's own base: 1 + (1/1)(1 + (1/2)(1 + (1/3)(1 + (1/4)(1 + ...)))) = 2 + (1/2)(1 + (1/3)(1 + (1/4)(1 + ...))) 

-- [1] Sale, A. H. J. "The calculation of e to many significant digits." The Computer Journal 11.2 (1968): 229-230.

import System.Environment
import System.IO

-- The base array represents the denominator of the bases in mixed radix
initializeBaseArr s = [2 .. (s + 100)]

-- These are the digits representing the fractional part of Euler's constant in mixed radix
initializeValArr s = replicate (s + 99) 1

-- Loops through the mixed radix representation of Euler's constant to compute the next digit
getDigit (x:[]) (y:[]) = do
                    let q = div x y
                    let r = mod x y
                    putStr $ show q
                    hFlush stdout
                    return [r]
getDigit (x:xs) (y:ys) = do
                    let q = div x y
                    let r = mod x y
                    let newHead = q + head xs
                    let zs = [newHead] ++ tail xs
                    c <- getDigit zs ys
                    return $ c ++ [r]

-- Turns on the Spigot! Prints out the digits of euler's constant
spigot xs ys n | n == 0 = do
                        putStrLn "\nDone"
               | otherwise = do
                            a <- getDigit xs ys
                            spigot (reverse (map (*10) a)) ys (n - 1)

printUsage = do
    print "USAGE: ./EulerSpigot [numDigits]"
    print "Example: ./EulerSpigot 100  (will generate the first 100 decimal digits of e)"

main :: IO()
main = do
        args <- getArgs
        if (length args) /= 1
            then do
                printUsage
        else if null args
            then printUsage
        else do    
            putStr "2."
            let numDigits = read (args !! 0) :: Int
            let a = map (*10) $ initializeValArr numDigits
            let b = reverse $ initializeBaseArr numDigits
            spigot a b numDigits
