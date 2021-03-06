{-# LANGUAGE Haskell2010 #-}

module Main where

-- import Data.Array (listArray, elems)
import Data.Array.Unboxed (UArray, IArray, listArray, elems)

import Curry.Matrix
import Curry.Pivot
import Curry.Gauss

--listFromFile :: Read b => FilePath -> IO [b]
listFromFile path = fmap read $ readFile path

--matrixFromFile :: Read b => FilePath -> IO (Matrix b)
matrixFromFile path = do l <- listFromFile path
                         let m = floor . sqrt . fromIntegral . length $ l in
                           return $ listArray ((1, 1), (m, m)) l

eps = 1.0e-16

main :: IO ()
main = let m = hilb 128 :: Matrix Double
           m' = pivotize fullPivot m :: Matrix Double
           (l, u) = luDecomposition m'
       in print $ all ((<= eps) . abs) . elems $ (l * u) - m'
