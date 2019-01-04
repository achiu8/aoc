import Control.Monad.State
import Data.List (foldr, partition)
import Data.Set (Set (..), fromList, member)

alive :: IO (Set String)
alive = readFile "12_input.txt" >>= return . fromList . map (take 5) . fst . partition ((== '#') . last) . drop 2 . lines

initial :: String
initial = "##.##..#.#....#.##...###.##.#.#..###.#....##.###.#..###...#.##.#...#.#####.###.##..#######.####..#"

grow :: (Set String) -> String -> Int -> Char
grow alive s n =
  let spread = take 5 $ drop n s
   in if member spread alive then '#' else '.'

tick :: (Set String) -> Int -> State String Int
tick alive d = do
  s <- get
  let s' = ".." ++ foldr (\n acc -> (grow alive s n) : acc) ".." [0..length s]
  put s'
  return . sum $ zipWith (\c i -> if c == '#' then i else 0) s' [-d..]

generate :: Int -> IO [Int]
generate n = do
  a <- alive
  let d = length initial * 10
  let cushion = replicate d '.'
  let s = cushion ++ initial ++ cushion
  return $ evalState (sequence . replicate n $ tick a d) s

partOne :: IO Int
partOne = generate 20 >>= return . last

main :: IO ()
main = do
  partOne >>= print
