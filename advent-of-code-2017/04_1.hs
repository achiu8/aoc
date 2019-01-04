import Data.List (nub)
import Data.List.Split (splitOn)

validate :: String -> Int
validate s =
  let w = words s
  in if length w == length (nub w) then 1 else 0

main = do
  print . sum . map validate . lines =<< readFile "04_input.txt"
