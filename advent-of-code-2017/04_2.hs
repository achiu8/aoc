import Data.Function (on)
import Data.List (nubBy, sort)
import Data.List.Split (splitOn)

validate :: String -> Int
validate s =
  let w = words s
  in if length w == length (nubBy ((==) `on` sort) w) then 1 else 0

main = do
  print . sum . map validate . lines =<< readFile "04_input.txt"
