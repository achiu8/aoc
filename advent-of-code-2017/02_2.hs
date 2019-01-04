import Control.Arrow ((&&&))
import Data.List.Split (splitOn)

divisible :: [Int] -> Int -> [Int] -> [Int]
divisible xs n acc =
  foldr
    (\x acc' ->
      if (not (null acc'))
        then acc'
        else
          if (n /= x && n `mod` x == 0)
            then [n, x]
            else [])
    acc
    xs

result :: [Int] -> Int
result xs =
  let [x, y] = foldr (divisible xs) [] xs
  in x `div` y

parseRow :: String -> [Int]
parseRow = map read . splitOn "\t"

main = do
  print . sum . map (result . parseRow) . lines =<< readFile "02_input.tsv"
