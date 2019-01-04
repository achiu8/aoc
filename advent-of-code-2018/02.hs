import Data.List (find, group, sort)
import Data.Maybe (fromJust, isJust)

input :: IO [String]
input = readFile "02_input.txt" >>= return . lines

counts :: String -> [Int]
counts = map length . group . sort

partOne :: IO Int
partOne = input >>= return . product . foldr f [0,0]
  where f x = zipWith (\n acc -> if elem n (counts x) then acc + 1 else acc) [2,3]

combine :: (Eq a) => (a -> b) -> b -> [a] -> [a] -> [b]
combine f b = zipWith (\x y -> if x == y then f x else b)

hamming :: String -> String -> Int
hamming = (sum .) . combine (const 0) 1

valids :: [Maybe a] -> [a]
valids = map fromJust . filter isJust

similar :: String -> String -> String
similar = (valids .) . combine Just Nothing

partTwo :: IO String
partTwo = do
  ids <- input
  let [x, y] = valids . map (\id -> find ((== 1) . hamming id) ids) $ ids
  return $ similar x y

main :: IO ()
main = do
  partOne >>= print
  partTwo >>= print
