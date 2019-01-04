import Control.Arrow ((&&&))
import Data.List.Split (splitOn)

diff :: [Int] -> Int
diff = uncurry (-) . (maximum &&& minimum)

parseRow :: String -> [Int]
parseRow = map read . splitOn "\t"

main = do
  print . sum . map (diff . parseRow) . lines =<< readFile "02_input.tsv"
